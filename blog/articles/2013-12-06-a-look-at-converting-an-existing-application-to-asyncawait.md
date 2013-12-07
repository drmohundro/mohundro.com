---
title: A Look at Converting an Existing Application to Async/Await
date: 2013/12/06

Microsoft has made strides in the realm of multithreading in the last few years by introducing things like the Task Parallel Library and now async/await support in C#. I thought it would be interesting to share some of my experiences in converting an existing WPF application over to use async/await.

## Initial Setup with Caliburn.Micro

The application that I converted is an automated deployment tool. It lets us copy compressed builds from our build server to servers in our web farm, unzip them, and deploy them. It's a central part of our [continuous delivery](http://en.wikipedia.org/wiki/Continuous_delivery) strategy. As you might imagine, there are a lot of opportunities for asynchronous operations to occur... the UI needs to wait for a build to copy to a server, then it needs to wait for it to unzip, then it needs to wait for it to deploy, then it needs to wait for our automated smoke tests to run, etc. None of these operations can run in parallel either - we can't start deploying unless the unzip operation is complete.

Prior to the conversion, the application was written using [Caliburn.Micro](http://caliburnmicro.codeplex.com/). This made asynchronous calls a lot easier than using straight WPF, mainly because Caliburn.Micro has support for [coroutines](http://caliburnmicro.codeplex.com/wikipage?title=IResult%20and%20Coroutines).

Basically, you implement Caliburn's `IResult` and then any methods on your view model that do asynchronous operations just need to have a return type of `IEnumerable<IResult>`. Once this is done, your method just needs to `yield return` each IResult. Typically, you will create multiple IResult implementations.

Below is a snippet of the code from one of our view models:

    ```cs
    var otherServers = allServers.Except(initialServers).ToList();

    // copy from build server (threaded)
    var firstCopyMessage = string.Join("\n", initialServers.Select(
        s => string.Format("Copying {0} to {1}...", buildToCopy.Name, s.Name)));
    Busy(firstCopyMessage);
    yield return new BulkCopyFromBuildServerAction(initialServers, buildToCopy);

    // copy to other servers (threaded)
    var copyMessage = string.Join("\n", otherServers.Select(
        s => string.Format("Copying from {0} to {1}...", buildToCopy.Name, s.Name)));
    Busy(copyMessage);
    yield return new BulkCopyFromPrimaryServerAction(initialServers, otherServers);

    // unzip on all (threaded)
    var unzipMessage = string.Join("\n", allServers.Select(
        s => string.Format("Unzipping {0} on {1}...", buildToCopy.Name, s.Name)));
    Busy(unzipMessage);
    yield return new BulkUnzipAction(allServers, initialServers.First().LastDeploymentBundle.Name);

The code is hopefully easy to follow, but it should give you an idea of what Caliburn's coroutine-support provides. The `Busy` method is used to indicate to the user what the application is doing. Each `Action` instance above will actually be kicked off on a separate thread, but the UI will not block. So, the `BulkCopyFromBuildServerAction` will take a list of initial servers to copy to as well as a build and will copy the build to each server in the list. The `BulkCopyFromPrimaryServerAction` will copy from a list of servers to the other servers in the environment.

*Aside - We initially did this because the connection from our build server to the web farm was slower than the gigabit connection between our web servers - it made the deployments significantly faster.*

And, of course, the `BulkUnzipAction` will unzip the compressed build artifact on each of the servers in question. Each action is doing work in parallel, but it has to wait for each prior action to complete first.

Here is the code for `BulkCopyFromBuildServerAction`:

    ```cs
    public class BulkCopyFromBuildServerAction : AsyncResult
    {
        private readonly DeploymentBundle _bundleToDeploy;
        private readonly IEnumerable<DeploymentServer> _otherServers;

        public BulkCopyFromBuildServerAction(IEnumerable<DeploymentServer> otherServers, DeploymentBundle bundleToDeploy)
        {
            _bundleToDeploy = bundleToDeploy;
            _otherServers = otherServers;
        }

        protected override void ExecuteAsync(ActionExecutionContext context)
        {
            Parallel.ForEach(_otherServers, s => s.CopyFromBuildServer(_bundleToDeploy));
        }
    }

As you can see, we do the copy in parallel using `Parallel.ForEach`. Note that Caliburn.Micro doesn't provide the AsyncResult base class implementation - I haven't included the source here, but I can if needed.

## Converting from Caliburn.Micro's Coroutines to Async/Await Continuations

I was concerned that it would take a lot of work to rip out all of the IResult actions and replace them with async/await instead, but it turned out to be pretty easy to do, mainly because [Caliburn.Micro now has support for returning Tasks](http://caliburnmicro.codeplex.com/wikipage?title=Async%20%28Task%29%20Support&referringTitle=Documentation). At the time of this post, the documentation wasn't updated to show how it worked, but it is quite easy to change out. The return signature for my method prior to adding async support was `public IEnumerable<IResult>`. Afterwards, it is just `public async Task`. That was the first change.

The second was to remove the `yield return` calls and basically inline the work that the actions were doing. I might end up reintroducing the actions as a refactoring option, but it was less code at the time to just bring the action code over.

    ```cs
    var otherServers = allServers.Except(initialServers).ToList();

    // copy from build server (threaded)
    var firstCopyMessage = string.Join("\n", initialServers.Select(
        s => string.Format("Copying {0} to {1}...", buildToCopy.Name, s.Name)));
    Busy(firstCopyMessage);
    await initialServers.ForEachAsync(async s => await s.CopyFromBuildServer(buildToCopy));

    // copy to other servers (threaded)
    var copyMessage = string.Join("\n", otherServers.Select(
        s => string.Format("Copying from {0} to {1}...", buildToCopy.Name, s.Name)));
    Busy(copyMessage);
    await otherServers.ForEachAsync(async s => await s.CopyFrom(initialServers()));

    // unzip on all (threaded)
    var unzipMessage = string.Join("\n", allServers.Select(
        s => string.Format("Unzipping {0} on {1}...", buildToCopy.Name, s.Name)));
    Busy(unzipMessage);
    await allServers.ForEachAsync(async s => await s.UnzipBuild(initialServers.First().LastDeploymentBundle.Name));

As you can see, there aren't a lot of differences aside from the new `await` calls.

One difference is that I can no longer use `Parallel.ForEach`, because it won't wait for `async` lambdas (the same is true for the IEnumerable<T>.ForEach extension method). You'll need to modify your usages of `Parallel.ForEach` if you try to add an `await` in them.

I recommend looking at the following posts from Stephen Toub on the PFX team:

- [http://blogs.msdn.com/b/pfxteam/archive/2012/03/04/10277325.aspx](http://blogs.msdn.com/b/pfxteam/archive/2012/03/04/10277325.aspx)
- [http://blogs.msdn.com/b/pfxteam/archive/2012/03/05/10278165.aspx](http://blogs.msdn.com/b/pfxteam/archive/2012/03/05/10278165.aspx)

I ended up bringing in both ForEachAsync methods into the codebase and converted all of my `Parellel.ForEach` calls over to use one of the `ForEachAsync` extension methods instead.

## Thoughts Post-Conversion

Easily, the most difficult part of the conversion for me was handling the `Parallel.ForEach` and converting them to use a `ForEachAsync` extension method instead. Visual Studio helped me out by alerting me that I needed to convert any awaitable lambdas over to be async lambdas, but I then had to do further debugging to realize that `Parallel.ForEach` was just kicking off the requests and continuing. It makes sense in hindsight, because `Parallel.ForEach` would have to have an `await` of its own, but it was still confusing.

I was also shocked at just how much changed by introducing async/await. I can't recall the source, but I remember reading someone who mentioned that async/await will "barf all over your code." That isn't an exaggeration. Over 70% of the source files in the solution had to change before the conversion was done. Here is the diff stat for the change:

    36 files changed, 607 insertions(+), 725 deletions(-)

It makes sense when you think about it... you find one operation that you want to make async, say, a call to a web resource. So, basically you change the code from using `WebClient.DownloadString` to instead use `HttpClient.GetStringAsync` and add an `await`. Sounds simple enough, except that the method that is now awaiting has to be marked `async`. And then all callers to this method have to add an `await`... which means they have to be marked `async`. And so and so forth, all the way to the top of the application. Alternatively, you can add an explicit `Task.Wait`, but no one wants to add a blocking call when you could have non-blocking async goodness.

Here is just another list of things that I ran into:

- you can't have async properties (i.e. no async getters or setters)
- you can't use them with in all LINQ statements (e.g. SelectMany)
- you'll be returning *a lot* of `Task<T>` instances (every async method should return either a straight `Task` instead of a `Task<T>` instance)
- hand-rolled WCF proxies all have to change
    - you have to introduce async Task to all of your operations
    - alternatively, you can change to let either Visual Studio or svcutil generate new async proxies for you
- you can't use inline statements with await (i.e. you can't use `if (await GetIsDoneAsync())`, instead you have to save off the result and then check it)
- while there are many classes in .NET that now support async, there are many that don't (e.g. Process.WaitForExit, File.ReadAllLines, etc.)

Admittedly, most of the things I've discovered are minor. They speak more to how well Microsoft introduced async/await support than they do to the weaknesses in the implementation. I would never dream of having a property getter be async, but as easy as it is to add an await statement, you might find yourself tempted to try to create an async getter.

In the end, I'm quite impressed with the async/await support. I sort of feel like I should be yelling at all of these async/await kids and telling them to get off my lawn, because I had to deal with IAsyncResults and BeginInvoke/EndInvoke, but then again, I'd much rather be using async/await.

Let me know your thoughts if you've worked with it!

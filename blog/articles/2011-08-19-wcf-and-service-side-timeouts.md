---
title: WCF and service-side Timeouts
date: 2011/08/19

Ah, timeouts. At my previous job, I wrote quite a bit of code that dealt with
threading. When dealing with threads, asynchronous operations, and performant
UIs, you can't always rely on callbacks to get you the results of some
asynchronous operation. Sometimes you also have to throw in some waits,
particularly if the UI gets to a point before the callback has happened.
Whenever I did have to write any code to wait for something (usually off an
AutoResetEvent or a ManualResetEvent), I *never* wanted to actually specify a
timeout. What would my application do if it timed out? Would I retry again?
Would I just show the user an error? Instead of dealing with that question, I
just made the wait last for the default... which in most cases is INFINITE.

I guess circumstances change. Today, most of my code is from the web. Not only
that, but a lot of the code that I'm writing has dependencies on external
services (SOAP, REST, etc.). The [default timeout for ASP.NET requests is 110
seconds (or 90 seconds in .NET 1.0 and 1.1)](http://msdn.microsoft.com/en-us/library/e1f13641.aspx).
That is an eternity when you're talking about a user browsing a web page. What if your
web page is calling a WCF service that is calling a web service? You might
trust your service, but do you trust the web service you're calling?

## What happens when service calls go CRAZY

Let's up the stakes here - WCF services default to allowing only 10
concurrent calls at a time. See, `maxConcurrentSessions`. [Here's the details from
MSDN](http://msdn.microsoft.com/en-us/library/ms731379.aspx):

> A positive integer that specifies the maximum number of concurrent
> connections to a single service. The service will accept connections in
> excess of the limit, but only the channels below the limit are active
> (messages are read from the channel). Setting this value to 0 is equivalent
> to setting it to Int32.MaxValue. The default is 10.

I'll point that default of 10 out again. The fact that it is that low is to
help protect against DoS attacks - this is a good thing. However, it means
that the service can only work on 10 incoming calls at a time. What this means
practically speaking is that performance issues have the potential to pile up
quickly. If one request starts eating resources, it can slow the others down -
it may not be long before you've filled up those 10 concurrent sessions.

Let's assume that the horrible service in question is written with an infinite
loop. Sort of like this:

```cs
public class TestServiceImpl : ITestService
{
    public TestResult TestIt(TestArgs args)
    {
        var stopwatch = new Stopwatch();
        stopwatch.Start();

        // this is a contrived example, but it shows that WCF never stops this thread
        while (true)
        {
            Console.WriteLine("{0}> I'm running forever...", stopwatch.Elapsed);
        }

        return new TestResult {Result = "Args were " + args.Args};
    }
}
```

Will WCF do anything to help you out? Not really, at least from the
service side. You can configure the `receiveTimeout`, `sendTimeout`,
`closeTimeout`, and the `openTimeout` but these won't really buy you anything
other than timing out the client. The service just keeps on going and going
and going... and your user has given up and closed the browser.

What is strange to me is that WCF doesn't timeout requests while ASP.NET does.
At least ASP.NET will try to prevent that one bad request from eating
resources forever. I actually [asked about this on Stackoverflow because I was
baffled](http://stackoverflow.com/questions/4974640/why-doesnt-wcf-support-service-side-timeouts).
We even opened a case with Microsoft because we were running into problems
with this and we didn't have any visibility into where our hang was. For all
we knew, it was an external service that wasn't returning. It was really a
vicious hang cycle from which there was no return. Well, that was overly
dramatic, but you get the point.

## The solution... maybe?

One of my colleagues decided to take it upon himself to solve this. He
ended up writing his very own timeout monitor... or what we affectionately
refer to as "the Thread Killer."

The code works by spawning a single monitor thread that has an internal
collection of threads for each of the executing service calls. Each thread is
stored along with a ticket which keeps track of the timeout. Any time there
are any threads being monitored, a timer is ticking (currently every 250
milliseconds) and will abort any threads that have run for longer than
they should be. During the thread abort, the actual `ThreadAbortException` is
caught and is reset, so that a true `TimeoutException` can be thrown instead.

Usage looks like this:

```cs
Run.For(10.Seconds(), () => DoSomeStuff());
```

Basically, you pass in how long it should run (we've made it a little more
readable with some extension methods), and a delegate. When we're working with
WCF, though, we don't want this in our code - this is an infrastructure
concern.

WCF has the
[IOperationInvoker](http://msdn.microsoft.com/en-us/library/system.servicemodel.dispatcher.ioperationinvoker.aspx)
interface that is used to invoke service operations. It works in conjunction
with an
[IOperationBehavior](http://msdn.microsoft.com/en-us/library/system.servicemodel.description.ioperationbehavior.aspx),
which can be used to decorate service operations on the service contracts.

So, the invoke method of our custom IOperationInvoker looks like this:

```cs
public object Invoke(object instance, object[] inputs, out object[] outputs)
{
    object[] inputOutputs = null;
    object returnValue = null;
    Run.For(_timeout,
        () =>
        {
            returnValue = _decoratedInvoker.Invoke(instance, inputs, out inputOutputs);
        });
    outputs = inputOutputs;
    return returnValue;
}
```

If we were to hook up our custom behavior directly to a service contract, it
would look like this:

```cs
[ServiceContract]
public interface IAmAnAwesomeServiceContract
{
    [OperationContract]
    [OperationTimeoutBehavior(60)]
    OpResults GoFindSomeAwesomeStuff(OpArgs args);
}
```

However, we would rather it happen for all of our services, so we implemented
a custom ServiceHost and we add our custom behavior in the OnOpening method.

```cs
protected override void OnOpening()
{
    foreach (var op in Description.Endpoints
        .SelectMany(ep => ep.Contract.Operations)
        .Where(op => !op.Behaviors.Contains(typeof (OperationTimeoutBehavior))))
    {
        op.Behaviors.Add(new OperationTimeoutBehavior());
    }
    base.OnOpening();
}
```

The above details could be used to hook in just about any behaviors around WCF
invocation, including pre and post call.

## So, how does it work?

Well, with all of that work, you'd think it would fix our problems, right? It
did, indirectly - it turns out that most of the cases that we were interested
in timing out were external service calls. It also turns out that aborting
threads doesn't actually do anything when you're dealing with external
service calls.

Some thread abort history - when you call the Abort method of some thread
instance, you're not just killing the thread in question. What .NET is doing
for you behind the scenes is that it is injecting some IL that will throw the
ThreadAbortException on the thread in question. If your code is waiting on
unmanaged execution (networking calls, SQL calls, etc all go unmanaged at some
point), your thread abort may never be thrown.

The solution in this case is to set the timeouts at each level - if you're
working with a SQL call, make sure that the [`CommandTimeout`](http://msdn.microsoft.com/en-us/library/system.data.sqlclient.sqlcommand.commandtimeout.aspx) is being set. If
you're working with a web service, there is a [`Timeout`](http://msdn.microsoft.com/en-us/library/system.web.services.protocols.webclientprotocol.timeout.aspx) property that can be set
there.

By ensuring that all of our SQL calls and service calls had appropriate
timeouts on them, we caught 99% of the problem areas.

## Then... what about thread abort?

By the time we had properly coded timeouts around our problem areas, we had
already coded our thread abort solution. I didn't mention how that went for
the first deployment... it went pretty badly actually. It turns out that you
can thread abort the dispatcher thread for WCF and, while the service stays
up, it will stop responding to requests. Our only recourse was to kill the
worker process serving the requests.

Thread aborts are *dangerous*. You are playing with fire.

* [Eric Lippert says it "should be avoided at all costs"](http://stackoverflow.com/questions/1559255/whats-wrong-with-using-thread-abort/1560567#1560567)
* [Eric Lippert also calls it an axe... an axe that you should be careful with](http://blogs.msdn.com/b/ericlippert/archive/2010/02/22/should-i-specify-a-timeout.aspx)
* [Jeffrey's answer to my question calls it "insanely error-prone"... and I
  agree](http://stackoverflow.com/questions/4974640/why-doesnt-wcf-support-service-side-timeouts/4974721#4974721)

On the other hand, using them along with our error logging helped point us to
the performance problems in the first place. We might still have been dealing
with performance problems had we not started down the thread abort path. The
thread abort solution *would* have helped us catch our horrible infinite loop
example above... though thankfully we don't have any code like that!

## Wrapping up

I've been trying to think of other things that we could have done to have
prevented this issue.

One potential solution might have been logging (WCF provides [extensive
tracing support](http://msdn.microsoft.com/en-us/library/ms733025.aspx)). I'm
not convinced this would have helped us though, because the errors we were
actually seeing were relatively sporadic. We didn't know anything strange was
happening *until* we started seeing system errors. To effectively have seen
this, we would have had to add system wide logging across the board - we
didn't have visibility into the problem in order to inform us about where the
problem even was! We'll likely add better logging (see [Ayende's
post](http://ayende.com/blog/4276/what-kind-of-logging-should-you-do-in-production))
but it will take time. Another thing about logging is that it can be very difficult
to know what kind of logging is needed before issues occur. In hindsight, well
sure we'd have loved to have logged service entry and exit points along with
times along with the parameters that were involved when the slowdown occurred!

I've thought about whether or not the usage of asynchronous service calls
would have helped also. I think it might have prevented as many system hangs
(particularly if I/O Completion Ports are being used for waiting for responses
instead of thread pool threads), but it wouldn't have done anything to inform
us of the actual problems.

In sharing this post, I want to point out the things we learned:

* WCF doesn't time services out - at all (certainly not with TCP or named pipe bindings)
* It isn't all that hard to decorate all service calls
* Thread abort is dangerous
* Thread abort is really dangerous
* Thread abort doesn't always abort
* Most components that might run for a long time provide timeout facilities of
  their own

Hope this helps.


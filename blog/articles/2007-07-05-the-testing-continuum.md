
title: "The Testing Continuum"
author: David
date: 2007/07/05
categories: programming

In the few years that I've worked as a software developer, I've read and seen many examples of testing software. As a result, my own thinking regarding testing has changed drastically over the past year or two. It seems that there is a continuum behind the thinking that goes behind testing. I originally titled this post "the Evolution of Testing Thought Processes" but evolution doesn't describe this as well for me, because I find myself moving between the different processes depending on the circumstances. 

This post has a few goals: 

1. I want to gain a better understanding of where I stand regarding testing code.
2. I want to share some of these ideas with others, particularly my coworkers, who might not have encountered ideas like unit testing.
3. I want to get your input on this and see if anyone else struggles with these issues, too.

Here are the different thought processes that I've seen regarding testing:

### No Testing (i.e. did it compile?)

This one's easy to categorize, right? Basically, no testing happened whatsoever. If it compiles, you're set. If you're working in a dynamic or interpreted language, then good luck. Hopefully, you've never seen this one before, but I wouldn't be surprised if you have. 

I have a horror story to share regarding this. A few years ago, my team was on track to install a fairly substantial update to a daily scheduled application. The update unfortunately required some changes to the script that kicked off the whole process. Because my team didn't own this script, we had to get someone else to do it. What we didn't know is that a certainly individual who will remain nameless decided to convert this script from REXX to VBScript. This would have been a good change at the time, had we prepared for it. Needless to say, this wasn't even the worst part.

This individual never even attempted to run this script.

You heard me - this individual converted a script from one language to another one and never tested the script at all. How could I possibly know this when I didn't even know the script was being converted? Because when the script was scheduled to run the next day, it blew up. It blew up because of invalid syntax. It blew up because there was VBScript code at the top... and REXX script at the bottom. I spent the better part of two days attempting to fix that problem. 

The lesson here is to at least run your application *once* before installing. I don't care if you're the best developer in the world. You can still make mistakes. 

Don't do this. 

### Manual Testing (i.e. F5 testing)

Manual testing is when developers run their application and attempt to test all of the functionality themselves. If they don't spot any problems, then the application is ready for production.

I used this technique the most while in college. If my professor could break our application with invalid input, then our grade would drop. For each problem the professor found, the grade would continue to drop. The majority of the applications that I wrote during this time were command line applications, so most of the user interaction was pretty easy to verify. I missed a few edge cases sometimes, but I was able to test the basic functionality because the application itself was so simple. 

I consider having someone else test your application an example of this as well. My experience is that usability problems are discovered here instead of bugs. The problem is that most developers have their own projects to work on, so testing your application isn't exactly at the top of their list of things to do. In other words, their testing will likely be even less rigorous than your testing. 

### Manual Unit Testing

This is a small variation on manual testing the whole application. At this point, you are testing smaller units rather than an entire application, which is a good thing. To do this, you typically have either a command line interface, a small form or a small web page that uses the small unit from your application. Your UI likely performs a few actions on your library and you then examine the results for problems. Sometimes, you'll enter a few input details to test different scenarios. Ideally, you'll test as much of the functionality that the library provides as possible. 

The most common place I see this is when someone has written a shared component or created some external assembly that will potentially be used by someone else. It doesn't have a UI of its own, so to test it, you have to create something else to run it. 

On the testing continuum, this is the first case where application testing is broken up into pieces. Developers can test parts of the application separate from the rest. As a result, there is less to distract developers. 

### Unit Testing

The problem with manually testing units of an application is that verification of the results is still dependent upon the developer. Everyone makes mistakes so it is only a matter of time before someone misses a problem. [Unit Testing](http://en.wikipedia.org/wiki/Unit_testing) takes the last approach and expands upon it by letting the computer decide whether or not your library is working correctly. 

With a manual test application, you simply look at the results that your test UI provides. Why not put those results (expectations) into code? The test can then be much more precise about its results. For example, it is much easier to determine if a returned numeric type is an integer or decimal value from code than you can from a UI. In .NET, you can just check the type. Better yet, you know immediately from code whether or not that is a "0" or an "O". 

These tests provide value during development time, but particularly during maintenance time. Imagine that a user of your system decides that they want to change something. Crazy, right? Have you ever made a change to an existing system and then broken existing functionality elsewhere in the application? This is why [regression testing](http://en.wikipedia.org/wiki/Regression_testing) is necessary. Unit testing makes regression testing even easier because the list of tests you have stays with the application. As you find new bugs, you can write tests for those so that they never show up again. 

Tool support for unit testing is awesome, too. With tools like [MbUnit](http://www.mbunit.com/), [NUnit](http://www.nunit.org/), [TestDriven.NET](http://www.testdriven.net/) and others, it is easier than ever to write and use unit tests. The tools get better with each release, too. One of the things that is nice about the unit testing libraries available is that they all have test runners that generate reports. This allows you to automate the testing and tie it into your build process or test your code nightly or whatever. That is one of the ideas behind Continuous Integration. Every check-in of an item into source control results in a build script running which can also run tests. Not only do you find out if you broke the build, you also find out if your tests now fail. 

One of the problems that people have with unit tests is that they feel like they spend twice as long on code because they're writing tests in addition to the code that will run on a user's machine. Doesn't that increase development time? In my experience, it adds to the time (though not twice as long) of the first iteration of software development, but it can significantly cut down on latter iterations. Have you ever maintained legacy code? I hate working with legacy code because half the time I end up breaking existing functionality. With unit tests, when I later have to come in to change a program, I can feel confident knowing that I'm not breaking existing functionality. 

### Test Driven Development

How about writing your unit tests first? That will blow your mind the first time you think about it. The idea behind [Test-Driven Development](http://en.wikipedia.org/wiki/Test-driven_development) isn't so much that you're writing a test first as you are *designing the contract for your class from the outside*. Proponents of test driven development very often state that this development methodology helps drive their design more than providing a good test framework. The test framework is an added benefit to good and extensible design. 

This is the hardest of the thought processes behind testing to really grasp, at least for me, because it requires a change in the way you think about developing software. Some don't see the benefits from it and others wouldn't program without it. I certainly can see the value in it, but I haven't had enough real world experience actually doing it to be effective with it yet. 

So, did I miss anything? Where are you on the testing continuum? I find that I move back and forth between Manual Unit Testing and Test Driven Development. I'd like to move more towards <acronym title="Test Driven Development">TDD</acronym>, because it is certainly beneficial and I find that code [designed with testability](http://weblogs.asp.net/rosherove/articles/Design4Tesatbility1.aspx) in mind is much easier to modify later. 

One thing to remember is that all of these ideas play a part in testing an application... except for the not testing idea. At some point, you'll need to actually run your application to try it out. If you employ unit tests, they'll simply provide more confidence in the application and provide future insurance when the code changes - and it will change. 

For more information, check out [this software testing article on Wikipedia](http://en.wikipedia.org/wiki/Software_testing).


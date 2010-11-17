
title: "No multi-line lambdas in VB 2008"
author: David
date: 2007/12/06
categories: .net;languages;programming

In case you've been under a rock recently, Visual Studio 2008 was released recently which supports a lot of functional capabilities like lambda expressions. I've been playing around with the lambda syntax in both C# and VB.NET recently and the addition to the languages is great. I did run into one thing that is still frustrating me in VB.NET, though. 

Check out the below C# snippet: 

    TryTimes(() =>
    {
      Console.WriteLine("hi there.");
      throw new Exception("haha");
      Console.WriteLine("hi there after .");
    }, 5);

This is the prototype for the usage of a function that could try an operation a certain number of times and then fail if the operation didn't succeed after N number of tries. Obviously, the above code sample will fail every time, but the idea could work alright for file I/O if you're unsure if anyone else might have locks on the file. 

The above is impossible to do in VB.NET, though, because VB.NET does not support multi-line lambda expressions. The C# supports them by wrapping the expressions in curly braces, essentially making the lambda expression a block. I wanted to emulate the same thing with VB.NET, but after some fruitless web searches, I came across [this MSDN forum posting on VB.NET and lambdas](http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=2091730&SiteID=1) which then pointed to [Paul Vick's post on the VB 2008 features that are still in](http://www.panopticoncentral.net/archive/2007/06/27/21113.aspx). 

I've been wanting the equivalent of anonymous delegates in VB for a long time and I thought, with lambda expressions, I might finally get them. We are a lot closer, but they still don't provide quite the benefit that they could have had we gotten multi-line lambda support. I guess those annoying line continuation characters in VB mess this all up. I think if I could change anything about VB, it would be to make those optional. 

On the positive side, though, the intellisense support for VB.NET has increased substantially. For that, I am thankful.


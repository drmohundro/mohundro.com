
title: "65% of my time in Garbage Collection?!?"
author: David
date: 2006/03/16
categories: visual studio
guid: 7e135a1f-2b2f-4d33-8cfc-442ea3b1a0d7

A few days ago, I was working in Visual Studio 2005 and I was getting awful performance out of it. I decided to pull up [Process Explorer](http://www.sysinternals.com/Utilities/ProcessExplorer.html) to see if I could determine where the problem was. I right-clicked on devenv.exe and pulled up its properties and went to the .NET tab. You can then use the combo box to select different .NET performance measures. Here's what I found:

![Visual Studio Screenshot](https://s3.amazonaws.com/mohundro/blog/2005-03-16-devenv.png)

As you can see with my hastily scribbled red circle and arrow, I'm attempting to draw your attention to the 65.94 number. It is telling me that devenv.exe was spending about 66% of its time in doing garbage collection.

WHAT?!? 66%? That explains why my process was barely responding to me, but it doesn't tell me why it was doing that. I will say that I had a code file up that was about 7000 lines long, but I would still expect it to be able to handle that. Maybe I'm wrong, though. Since then, I've significantly cut that file down in size and I haven't run into that issue again, but it was pretty weird.


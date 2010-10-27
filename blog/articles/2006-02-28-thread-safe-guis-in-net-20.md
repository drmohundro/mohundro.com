
title: "Thread-safe GUIs in .NET 2.0"
author: David
date: 2006/02/28

[Roy Osherove](http://weblogs.asp.net/rosherove/) [posts today](http://weblogs.asp.net/rosherove/archive/2006/03/01/439309.aspx) about different ways to accomplish thread-safe GUIs using .NET 2.0... and C#.

Since we're primarily using VB.NET at work, we don't get the anonymous delegate love... oh well. Ever since I discovered that JavaScript could do the same thing__*__, I've been wanting to use it in managed code as well. I guess I'll have to do it on my own time for now.

__*__ like so: `document.body.onload = function() { alert("I've been loaded!") }`

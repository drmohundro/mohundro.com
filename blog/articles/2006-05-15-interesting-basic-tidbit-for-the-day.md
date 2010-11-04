
title: "Interesting Basic tidbit for the day"
author: David
date: 2006/05/15
categories: .net;programming

If you've ever wondered why the increment and decrement operators weren't included in VB.NET, here's a [post explaining why](http://http://www.panopticoncentral.net/archive/2003/12/02/251.aspx).

Coming from the C/C++ world, I still miss the increment (++) and decrement (\-\-) operators, but I definitely understand why after reading. Basically, it has to do with the fact that assignments in VB are done at the statement level instead of the expression level. If you're not following, consider how you can have things like (if (x = 5) ...) in C, but you can't in VB because the = sign is used for both assignment and equality, depending on the STATEMENT. There isn't any problems in C, because equality is checked with the == sign.

Interesting.


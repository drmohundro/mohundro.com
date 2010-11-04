
title: "Checking for visual style support"
author: David
date: 2006/04/14
categories: .net;programming

I had some code that I was porting from .NET 1.1 to .NET 2.0 today. The code I had was checking the version of comctl32.dll to see if it was version 6 or greater to determine if the application supported visual styles or not. As I didn't write that code, I'm not sure if that is a valid way to check for visual style support in .NET 1.1.

I DO know that in .NET 2.0, that check doesn't necessarily work correctly; however, there is a new way to check that is much easier and more reliable -- Application.RenderWithVisualStyles. If you call Application.EnableVisualStyles in your Sub Main method, this boolean will be set to true. That's all you need to check!

See MSDN documentation [here](http://msdn2.microsoft.com/en-us/library/ms171733%28VS.80%29.aspx).


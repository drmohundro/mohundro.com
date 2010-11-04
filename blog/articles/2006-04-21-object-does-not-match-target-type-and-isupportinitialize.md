
title: "\"Object does not match target type.\" and ISupportInitialize"
author: David
date: 2006/04/21
categories: .net;visual studio

Continuing in the tradition of posts on Visual Studio [WSoD's](http://blogs.msdn.com/rprabhu/archive/2005/08/11/450332.aspx), I ran into another one today that gave me this error: "Object does not match target type."

Okay... super.

Luckily, I got some warnings with line numbers. They pointed me to a line in my designer code that looked like this:

    CType(Me.MyUserControlInstance, System.ComponentModel.ISupportInitialize).BeginInit()

The other error was the same line except it was the matching EndInit call.

Similar to [before](http://feeds.feedburner.com/DavidMohundro?m=42), I was working with code that was in the process of being updated to the .NET 2.0 Framework. I had been working with a control that was inheriting from a .NET 1.1 control. The ISupportInitialize code had been in there for the 1.1 parent. The designer didn't mind at all until I moved the parent control over to 2.0. The solution was easy enough... just take the ISupportInitialize code out. I'm not sure if this is the recommended solution or not (I didn't Google it for too long), but it works.


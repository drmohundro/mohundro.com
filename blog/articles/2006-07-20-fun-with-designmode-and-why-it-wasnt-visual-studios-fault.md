
title: "Fun with DesignMode (and why it wasn't Visual Studio's fault)"
author: David
date: 2006/07/20
categories: .net;programming;visual studio
guid: b7f56faa-6a13-4c51-a189-a39256310ad6

Like many other users of Visual Studio 2005, I've occasionally received the WSoD (White Screen of Death) while using the designer. And like a typical user, I blamed it on Visual Studio. That's what users do, right? They blame the program, because the user is always right. The same behavior that frustrates me to no end when users enter invalid data into MY program and then blame MY program (of course, if my UI were better, it wouldn't be as difficult to use, but that is another story). Anyway, my frustrations with VS2005 crashing and the WSoD's were in fact a problem with the user - me.

In one of my forms, I had some background threading work that was started when the form loaded. Like a good programmer, I had wrapped this threading work in a check against Me.DesignMode to ensure that it wouldn't try to do this work while in the designer. What I didn't know at the time is that the DesignMode property isn't set until AFTER the constructor fires. I checked around with some guys at work and I discovered that I wasn't the first one to discover this. They had already put a check against Application.ExecutablePath to see if it was devenv.exe. If it is, then we're in DesignMode. Simple as that!

So, all of my VS crashes and weird WSoD's have now been tracked back to my OWN code. HOWEVER, I would like to say that it would have been nice if Visual Studio had given me a better message to inform me that my designer code was trying to run background threads or something - in much the same way that my own code should work better and give my users better messages.

Ah, the joys of user interaction.

**Note:** This fixed the problem suggested after sending error reports that link to this hotfix ([http://support.microsoft.com/?kbid=915038](http://support.microsoft.com/?kbid=915038)). If you're running into this, check and double-check the code in your UI constructors, INCLUDING base class constructors!



title: "New security model with Silverlight?"
author: David
date: 2007/04/30

I just finished reading this post from the [BCLTeam blog](http://blogs.msdn.com/bclteam/default.aspx) on the [Silverlight 1.1 Alpha release](http://blogs.msdn.com/bclteam/archive/2007/04/30/introducing-microsoft-silverlight-1-1-alpha-justin-van-patten.aspx) that was announced at MIX07. It sounds like there is a new security model that is being introduced with Silverlight as a replacement for CAS (Code Access Security). I haven't done any research yet, but it looks like we'll be able to just decorate methods with attributes like Transparent or SafeCritical.

From just a cursory glance, it sounds like this will be much easier to work with than CAS. I couldn't ever really follow CAS very well - usually I just followed the FxCop guidelines and left it at that. I found the MSDN documentation on [developing Silverlight applications with the .NET Framework](http://msdn2.microsoft.com/en-us/library/bb404700.aspx), but there isn't much on the security side of things yet. I'm interested to see if Microsoft will start to move away from CAS to a more developer-friendly model. 

Sounds interesting.

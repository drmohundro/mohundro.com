
title: "The Remote Debugger from Visual Studio 2008 isn't backwards compatible"
author: David
date: 2007/12/19

This is probably a big duh for some of you out there, but if you're running the remote debugger that comes packaged with Visual Studio 2008 (you can find it at C:\program files\Microsoft Visual Studio 9.0\Common7\IDE\Remote Debugger) on a remote machine and you try to <em>attach</em> to that remote machine using Visual Studio 2005, you'll get an error. In fact, VS2005 will tell you that it can't find any servers running on the remote machine. All afternoon yesterday, I was trying to figure out how this one users' security was wrong and keeping me from attaching to a remote debugger he was running when, in fact, I just had an older version of Visual Studio trying to talk to a newer remote debugger.  
*sigh* 
Maybe now I can figure out what the original problem I was trying to debug was in the first place.

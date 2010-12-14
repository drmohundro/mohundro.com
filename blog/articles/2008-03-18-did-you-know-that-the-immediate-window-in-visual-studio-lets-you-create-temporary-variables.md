
title: "Did you know that the Immediate window in Visual Studio lets you create temporary variables?!?"
author: David
date: 2008/03/18
categories: visual studio
guid: 8ce24427-e154-444a-af02-99a92c9de878

I am a huge fan of the immediate window in Visual Studio. I say forget the watch window - I'd rather use code to check values. In case you didn't know, you can get values in the Immediate window by typing "?" and the variable name. Like so:

    ? myCoolVar

You can also execute commands at the immediate window by just typing them. It is a nice way to change values at debug-time.

    myCoolVar = "some other blah"

What I didn't realize until today is that you can create completely new variables at the Immediate window as well! Just type in the variable declaration as you normally would in code. (note that you need the semi-colon in this case)

    string myNewCoolVar = "I'm a brand new variable!";

Here's a screenshot of this behavior in action:

![Immediate Window](https://s3.amazonaws.com/mohundro/blog/WindowsLiveWriter/DidyouknowthattheImmediatewindowinVisual_A747/image_2.png) 

Right now, I'm using this behavior while working with a new WPF application. I've got an IMultiValueConverter and it is a hassle casting my generic array of objects into types, especially when I'm still deciding on the various bindings I'd like to pass in. With this, I can just set a breakpoint and use the Immediate window to play with the code.

This gets me a lot closer to an interactive console (like IRB) with .NET. Though I can do all of this with IronPython, F#, or IronRuby, it is nice to be able to do this at debug time from Visual Studio.


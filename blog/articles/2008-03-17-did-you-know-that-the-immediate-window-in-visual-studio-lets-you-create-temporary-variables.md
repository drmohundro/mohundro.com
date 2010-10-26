
title: "Did you know that the Immediate window in Visual Studio lets you create temporary variables?!?"
author: David
date: 2008/03/17

<p>I am a huge fan of the immediate window in Visual Studio. I say forget the watch window - I'd rather use code to check values. In case you didn't know, you can get values in the Immediate window by typing "?" and the variable name. Like so:</p><pre>? myCoolVar</pre>
<p>You can also execute commands at the immediate window by just typing them. It is a nice way to change values at debug-time.</p><pre>myCoolVar = "some other blah"</pre>
<p>What I didn't realize until today is that you can create completely new variables at the Immediate window as well! Just type in the variable declaration as you normally would in code. (note that you need the semi-colon in this case)</p><pre>string myNewCoolVar = "I'm a brand new variable!";</pre>
<p>Here's a screenshot of this behavior in action:</p>
<p><a href="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/DidyouknowthattheImmediatewindowinVisual_A747/image_2.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="253" alt="image" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/DidyouknowthattheImmediatewindowinVisual_A747/image_thumb.png" width="438" border="0"></a> </p>
<p>Right now, I'm using this behavior while working with a new WPF application. I've got an IMultiValueConverter and it is a hassle casting my generic array of objects into types, especially when I'm still deciding on the various bindings I'd like to pass in. With this, I can just set a breakpoint and use the Immediate window to play with the code.</p>
<p>This gets me a lot closer to an interactive console (like IRB) with .NET. Though I can do all of this with IronPython, F#, or IronRuby, it is nice to be able to do this at debug time from Visual Studio.</p>

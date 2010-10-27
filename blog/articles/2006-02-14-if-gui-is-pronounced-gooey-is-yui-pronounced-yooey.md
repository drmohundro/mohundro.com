
title: "If GUI is pronounced \"gooey\", is YUI pronounced \"yooey\"?"
author: David
date: 2006/02/14

For those two or three who missed it, [Yahoo! released two libraries yesterday](http://www.yuiblog.com/): the [Yahoo! Design Patterns Library](http://developer.yahoo.net/ypatterns) and the [Yahoo! User Interface Library](http://developer.yahoo.net/yui). I particularly like the UI library. First of all, it was released under as open source, so as long as you include the copyright at the top, it looks like you can use it. I checked out their JavaScript code and it looks pretty good. It seems that the whole object { name : value }<strong>*</strong> notation of declaring objects is becoming more popular. It is also becoming much more common to see entire frameworks being developed (I'm thinking of the JavaScript libraries that come with [Atlas](http://atlas.asp.net)). Anyway, interesting stuff. It will be a lot easier to add some nice, production quality JavaScript to pages now.

<strong>*</strong> Instead of:<br><br><font face="Courier New">var newObject = new function () {<br>   this.name = value;<br>}<br></font><br>It is:<br><br><font face="Courier New">var newObject = {<br>   name: value;<br>}</font>


title: "If GUI is pronounced \"gooey\", is YUI pronounced \"yooey\"?"
author: David
date: 2006/02/14

<P>For those two or three who missed it, <A href="http://www.yuiblog.com/">Yahoo! released two libraries yesterday</A>: the <A href="http://developer.yahoo.net/ypatterns">Yahoo! Design Patterns Library</A>&nbsp;and the <A href="http://developer.yahoo.net/yui">Yahoo! User Interface Library</A>. I particularly like the UI library. First of all, it was released under as open source, so as long as you include the copyright at the top, it looks like you can use&nbsp;it. I checked out their JavaScript code and it looks pretty good. It seems that the whole object { name : value }<STRONG>*</STRONG> notation of declaring objects is becoming more popular. It is also becoming much more common to see entire frameworks being developed (I'm thinking of the JavaScript libraries that come with <A href="http://atlas.asp.net">Atlas</A>). Anyway, interesting stuff. It will be a lot easier to add some nice, production quality JavaScript to pages now.</P>
<P><STRONG>*</STRONG> Instead of:<BR><BR><FONT face="Courier New">var newObject = new function () {<BR>&nbsp;&nbsp;&nbsp;this.name = value;<BR>}<BR></FONT><BR>It is:<BR><BR><FONT face="Courier New">var newObject = {<BR>&nbsp;&nbsp;&nbsp;name: value;<BR>}</FONT></P>

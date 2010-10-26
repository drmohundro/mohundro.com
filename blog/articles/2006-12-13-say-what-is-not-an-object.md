
title: "Say what is not an object?!?"
author: David
date: 2006/12/13

<p>Ahhh, JavaScript error messages.</p> <p>&lt;sarcasm&gt;<br>They are the epitome of the user friendly error message. Developers love them, because they always tell you exactly where the problem is. Absolute error message perfection.<br>&lt;/sarcasm&gt;</p> <p>Below is an example of one of these messages that a friend sent:</p> <p><a href="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Saywhatisnotanobject_9AEE/crazy-javascript-error%5B2%5D.png" atomicselection="true"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="101" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Saywhatisnotanobject_9AEE/crazy-javascript-error_thumb.png" width="712" border="0"></a> </p> <p>Nice, eh?</p> <p>You can tell EXACTLY what the problem is. That... thing... is null or not an object! And we've even got a line number, too!</p> <p><strong>NOTE:</strong> The above message was generated by a&nbsp;script I wrote a while back that is kicked off by the window.onerror event that fires when JavaScript exceptions are thrown. It posts to an application which then emails the developers in question.</p>
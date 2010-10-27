
title: "Problems with the WebBrowser control and IDocHostUIHandler"
author: David
date: 2007/02/11

Lately, I've been doing some work with the WebBrowser control (new in the 2.0 framework). It really does offer a lot of benefits over directly using the underlying ActiveX web browser control. And when the new functionality doesn't cover a need you may have, you can always get at the ActiveX control (though you'll need plenty of COM interface definitions - hello [pinvoke.net](http://pinvoke.net/)!). 
The typical usage scenario with the WebBrowser control is that, if you want more than just a basic control, you're going to inherit from it. I was wanting to be able to provide a custom context menu instead of using the default IE one. Here comes MSDN documentation to the rescue! According to [the documentation on the protected CreateWebBrowserSiteBase method](http://msdn2.microsoft.com/en-us/library/system.windows.forms.webbrowser.createwebbrowsersitebase(VS.80).aspx), the method can be overridden to provide a custom WebBrowser.WebBrowserSite object. Here's the quote from the documentation: <blockquote> 
To use this feature, implement classes that inherit from the <strong>WebBrowser</strong> and <strong>WebBrowser.WebBrowserSite</strong> classes. The unmanaged <strong>WebBrowser</strong> ActiveX control uses the protected <strong>CreateWebBrowserSiteBase</strong> method to retrieve extensibility interfaces implemented by the <strong>WebBrowser.WebBrowserSite</strong> class. Override the <strong>CreateWebBrowserSiteBase</strong> method to return an instance of your own class that inherits from the <strong>WebBrowser.WebBrowserSite</strong> class. The <strong>WebBrowser.WebBrowserSite</strong> class provides default implementations of the OLE [IDocHostUIHandler](http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/hosting/reference/ifaces/idochostuihandler/idochostuihandler.asp). You can provide your own implementation of this interface or implement any other <strong>WebBrowser</strong> ActiveX control interface in order to customize the behavior of the control.
</blockquote> 
Super! 
Because the WebBrowserSite class is protected and internal to the WebBrowser, your implementation must be internal to your inherited WebBrowser class to have access to it. Like so:
<pre style="font-family: consolas, monospace">public class CustomWebBrowser : WebBrowser
{
	private class CustomBrowserSite : WebBrowserSite
	{
		// Your implementation
	}
}
</pre>

So, I happily pulled up the [interface definition for IDocHostUIHandler](http://pinvoke.net/default.aspx/Interfaces/IDocHostUIHandler.html), coded it up and made my custom WebBrowserSite implement it. To verify that it was working, I just stuck a message box to tell me hello in the ShowContextMenu method. When I ran my test, I right clicked and saw a context menu... the default context menu! Huh?!?

I was positive I must have missed something, because the documentation is CLEAR on the fact that this scenario is possible.

And yet... and yet... [WHAT IS THIS?!?](https://connect.microsoft.com/VisualStudio/feedback/ViewFeedback.aspx?FeedbackID=115198)

More searching and I find that there is a bug reported for this exact scenario on Microsoft Connect! And what's more, it has been closed because it has been postponed!!!

This wouldn't really irk me so much except that the documentation specifically says that it can be done. Here is a snippet of the reasoning behind closing the bug:
<blockquote>... The bug you entered has been reproduced, but our evaluation determined that it does not meet the criteria to be addressed in this release. The main reason for this is that in this release, our webBrowser control is tightly tied to the IDocHostUIHandler not leaving much room for such customization. ...</blockquote>

Why, oh why wasn't this tested? The documentation says THAT THIS CAN BE DONE! Don't post documentation that says that you can do this and then tell us that you can't because your implementation won't allow it!

Luckily, there are 2 workarounds listed that let you hook your own IDocHostUIHandler implementation in (it involves implementing ICustomDoc and calling the SetUIHandler method, [see this CodeProject article for more details](http://www.codeproject.com/csharp/advhost.asp)). Tightly tied my butt... the workaround gets the same results just fine.

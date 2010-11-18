
title: "DDE isn't really dead"
author: David
date: 2007/04/12
categories: programming
guid: 06923884-d3ca-49f8-a1b1-76a8a553adde

Scott Hanselman recently posted about a [bug that can occur when using Firefox as your default browser](http://www.hanselman.com/blog/FixQuotGeneralFailurequotWhileLaunchingFireFoxURLsFromOutlook.aspx). The root problem deals with Outlook trying to start up Firefox using <acronym title="Dynamic Data Exchange">DDE</acronym> instead of just a simple command line argument. At work, we ran into a very similar situation, because we were wanting to open up URLs in the default browser from our application. Normally, this would be easy because all you would have to do is Process.Start the URL without providing an application and ShellExecute would handle the rest for you. Needless to say, this wasn't going to work for us because we had overridden the default open action for URL shortcuts with our own action (it's a long story that I won't go into in this post). 

Our solution started with pulling out the default browser from the registry (we still kept the original open action command, see HKEY_CLASSES_ROOT\HTTP\shell\open\command). Once we have the value, we thought we would be able to Process.Start the command line from the registry passing in the specified URL. We tested it out in Firefox and everything worked great. Even better, Firefox would reuse windows based on the user-defined settings. 

Not so with Internet Explorer. Internet Explorer would open the URL for us, sure, but it would not respect the user-defined settings on the reuse of windows. This was confusing to us, because Outlook was smart enough to get Internet Explorer to reuse windows. The question was how it was happening... and that's where <acronym title="Dynamic Data Exchange">DDE</acronym> came in. 

When Outlook opens a URL shortcut, it connects to the DDE IExplore server on the WWW_OpenURLNewWindow topic. If he is able to connect, then Internet Explorer is already running. He then sends an XTYP_EXECUTE transaction passing along the URL. If everything works correctly, then Internet Explorer will open the new window and bring it to front for you. If no Internet Explorer instances are running, Outlook will start a new instance. 

In case you were wondering, this was all verified using DDESpy (which you can find in the Visual C++ 6.0 Tools installation... if you still have it). It was also tested against Internet Explorer 7 and Outlook 2007 which means this information is still current. 

And yet, [Raymond Chen has encouraged us to stop using DDE](http://blogs.msdn.com/oldnewthing/archive/2007/02/26/1763683.aspx), because "DDE has been dead as a shell interface for over ten years." Oh how I wish that the Internet Explorer team knew that. If they had, we wouldn't have had to code up DDE to get similar behavior in our application. And let me tell you, DDE is not fun to code against. There are very few resources covering DDE on the Internet (probably because DDE died before the Internet became really widespread... or not).


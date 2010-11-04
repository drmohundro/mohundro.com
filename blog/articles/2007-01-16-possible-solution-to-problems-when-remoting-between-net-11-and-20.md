
title: "Possible solution to problems when remoting between .NET 1.1 and 2.0"
author: David
date: 2007/01/16
categories: .net

We're in the process of migrating to .NET 2.0 at work and one of the the things we've encountered is a problem with remoting between .NET 1.1 and 2.0 frameworks. 

This is our scenario in a nutshell. 

An application is upgraded to 2.0 but is still referencing a 1.1 component. This works fine until the 1.1 component remotes to a 1.1 server. The client is running under the 2.0 framework while the server is running under the 1.1 framework. We can't upgrade the server because there are still other 1.1 clients out there as well. 

What's funny about this is that it will work sometimes. Interoperability between 1.1 and 2.0 is actually fairly solid... unless you're serializing a DateTime across the wire. If you're sending a DateTime between the two frameworks, you'll see this error: 

> Exception: System.ArgumentOutOfRangeException<br />
> Message: Ticks must be between DateTime.MinValue.Ticks and DateTime.MaxValue.Ticks.<br />
> Parameter name: ticks

If you were to change the server side over to run under .NET 2.0, you won't see the problem anymore. On the plus side, Microsoft [has released a hotfix](http://support.microsoft.com/kb/907262) to address this issue ([and even more information here](http://blogs.msdn.com/eugeneos/archive/2006/03/15/552315.aspx)) that specifically patches the 1.1 framework. The problem is that you've got to contact Microsoft to get the hotfix. 

I'm hoping that by posting this, I will let others know about it and maybe even to get Microsoft to release it for download. 

Then again, maybe no one else has to deal with this issue :-)


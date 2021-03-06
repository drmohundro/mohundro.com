
title: "Back from .NET Roadshow 2007"
author: David
date: 2007/09/14
categories: conferences
guid: 68707928-b5f9-4031-ac8b-5ebe01af4dcd

Well, I got back from the .NET Roadshow last night. It went really well, too. The conference lasted two days with three tracks.

The first day was all WCF with Juval L&ouml;wy. Juval is a great speaker and really knows his stuff. I mean, seriously, the guy is a genius. There is a reason that Scott Hanselman put him on his list of "Smart People and their pages for Utils they Wrote" (a subitem of his [Ultimate Tools](http://www.hanselman.com/tools/)). He really pointed out how WCF will change the way we write code. Your implementation of a service might look like a class, smell like a class, quack like a class and walk like a class... but it isn't a class anymore. It is a service. What does this really mean? Well, it means this thing that looks like a class now inherently supports transactions, threading, queuing, throttling, security, and more. Now, I'm going to insert my little bit of reality here - this service functionality isn't all magic. You have to configure your service and you have to host it. You don't just say myVar = new myService() or something like that. But there is still a ridiculous amount of power that WCF gives you out of the box. I like it. 

The second day, we got to choose between a security-focused track by Mich&egrave;le Leroux Bustamante and a Workflow/WPF track by Brian Noyes. I chose Brian's track simply because I know we'll be using WPF soon and because I have zero background in Workflow. Workflow really is pretty cool, though it is a little hard to explain. The benefits, as far as I'm concerned, come in visualizing business processes so that you can verify functionality with your users via a flow chart instead of trying to explain through code. The more activities that you create, the closer that your workflow can get to true business/domain terms. Also, I didn't realize it until Brian mentioned it, but Workflow supports persistence, so you could conceivably have a 6 month long workflow that persists between machine reboots and all of your logic still flows without any problems. Very cool. 

I had the most background in WPF ahead of time, so I didn't really learn anything new. Having purchased [Adam Nathan's book on WPF](http://adamnathan.net/wpf/) as well as having watched a multitude of dnrTV episodes on WPF, I had a pretty good background on what WPF is capable of. Needless to say, WPF is awesome. I still couldn't use Expression Blend to safe my life, but the entire platform is sweet. I think my favorite example of what you can do with WPF is the example from Adam's book on customizing the ToolTip so that it looks like the tooltips from Office 2007. It doesn't sound like something to get all that excited about, but the ease with which it is done really shows just how powerful the WPF composition engine is. 

All in all, I really enjoyed the Roadshow. If you've already got some background in .NET 3.0 or are using it, I don't know if you would gain much; however, if you're like me and haven't had a chance to really dig in, you can really learn a lot and see some of the capabilities that .NET 3.0 will give you.


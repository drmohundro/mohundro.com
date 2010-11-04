
title: "Duh of the Day - Turn off IE's &quot;Show friendly HTTP error messages&quot;"
author: David
date: 2007/04/06
categories: general

I'm sure you've seen this page before: 

!["The website cannot display the page"](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/DuhoftheDayTurnoffIEsShowfriendlyHTTPerr_937B/sshot2%5B2%5D.png) 

I've seen a million posts on it, too. Jeff Atwood posted about this problem when he was talking about [user-friendly 404 pages](http://www.codinghorror.com/blog/archives/000819.html). Internet Explorer tries to hide ugly error pages from you unless the page displayed is greater than 512 bytes in size. 

I used to have this setting turned off, but my employers recently pushed out Internet Explorer 7 to the corporate masses. I already had it installed, but it apparently went over my previous installation, which means that I lost my previously customized settings. Anyway, I spent about an hour trying to figure out why my IIS installation had CustomErrors turned on for everybody before I realized that it was actually Internet Explorer helping me out. 

To turn the setting off, go here: 

![Don't Show Friendly HTTP Errors](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/DuhoftheDayTurnoffIEsShowfriendlyHTTPerr_937B/sshot1%5B2%5D.png) 

As Jeff points out, the best solution is to make sure that your error pages are bigger than 512 bytes. Most of the time, ASP.NET error pages are far larger than 512 bytes, too. HOWEVER, error messages from HTTP Remoting\* are NOT always greater than 512 bytes and I'm not sure if you can customize those or not. So I like to just save myself the headache and turn this off. 

\* As a note, a useful tip for debugging HTTP remoting applications is to browse to your registered channel (i.e. http://localhost/remotingEndPoint.rem) with a browser. If there are any problems with your remoting configuration or with your assemblies being loaded, you'll get the friendly ASP.NET error message displayed to you. If you don't get an ASP.NET error, you'll usually get a message that looks like this:

    System.Runtime.Remoting.RemotingException: Requested Service not found

It basically means that you're configured correctly and that the server didn't find a service based on your HTTP GET. I prefer checking remoting servers this way because it is easier to read messages in your browser than trying to interpret a binary serialization exception while in your remoting client.



title: "Design and structure of my website"
author: David
date: 2006/02/19
categories: .net;programming

I'd like to talk a little bit about what I did to get my personal site up and running.

First off, I wanted it to support blogging for my wife and I. I tried a lot of different ASP.NET blogging engines like [CommunityServer](http://communityserver.org/) and [SUB](http://www.markitup.com/) (Single User Blog). CommunityServer is great, but it had way too much for my needs. I really liked SUB, particularly version 2 because it was in ASP.NET 2.0 and Master pages rule. My only problems with it were probably more my fault, but I had some weird issues with the ASP.NET Development Server (aka Cassini). Something about files existing in two different places. I imagine if I had installed the [Web Application Project](http://msdn.microsoft.com/asp.net/reference/infrastructure/wap/default.aspx) things might have worked better. Still, I would suggest checking out SUB if you can. 

I ended up going with [dasBlog](http://www.dasblog.net/). I was already somewhat familiar with it and it is extremely easy to set up. It allows multiple logins by adding multiple users to the siteConfig.config file. My only obstacle was encorporating my own pages (Photos) and creating my own theme. I'd like to say thanks to [James Snape](http://www.jamessnape.me.uk/) for the Project84 theme (the default here), because I based my new theme off of it. If you're going to create your own dasBlog theme, I recommend starting with one you already like. Copy it to a new directory under the themes folder and then started changing things. See what happens. That's really all I did. Since dasBlog is written under ASP.NET 1.1, we can't use Master pages, but we get something pretty close. dasBlog uses template files that are very easy to change and that give you almost complete control over the way your blog will look. If you're interested in using my theme, let me know and I'll zip it up and post it.

The other primary addition to the standard dasBlog setup is that I added a Photos page written in ASP.NET 2.0. It is proof that you can run ASP.NET 1.1 and 2.0 side by side for relatively simple applications. My photos page relies primarily on [Picasa](http://picasa.google.com/), which is a great photo album application. I'm relying primarily on the "Make a webpage..." ability, which will export a selected album into a directory with appropriately sized images, thumbnails, and an index file. The best part is that you can choose to export to an XML file. The XML file is very simple, but it provides a simple way to provide image galleries in a format other than the Picasa defaults. My page basically has a Galleries subdirectory with exported albums. It grabs all of the albums in the gallery and parses the XML file to display the images. All my wife has to do to add albums is export from Picasa and drop the folder into the Galleries directory. How easy is that?

I'll be the first one to admit that there are issues with my Photos page (the exported albums' name are exactly the safest for the web), but it works. At some point, I'd like to clean up the names and add the ability to display our comments as well as to take comments from visitors to the site.

That pretty much sums up what I've done with the site. If you'd like to know more, let me know!



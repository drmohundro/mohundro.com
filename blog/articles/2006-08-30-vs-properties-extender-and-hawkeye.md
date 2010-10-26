
title: "VS Properties Extender and Hawkeye"
author: david
date: 2006/08/30

<P>Back in January, <A href="http://weblogs.asp.net/gmilano/">Gaston Milano</A> <A href="http://weblogs.asp.net/gmilano/archive/2006/01/24/436359.aspx">posted a sort of wishlist</A> for the next version of Visual Studio. One of the features he wanted was the ability to filter properties down in his Properties window. Here's a screenshot of what he had in mind (from his posting):</P>
<P><IMG style="BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px" height=210 src="http://www.mohundro.com/blog/content/binary/2006-08-31-gmilano.png" width=247 border=0> </P>
<P>Well, I've got great news! Corneliu from his <A href="http://acorns.com.au/cs/blogs/parallelthinking/default.aspx">parallelthinking blog</A> has created an addin to do just that! It works by using his <A href="http://www.acorns.com.au/Hawkeye/">Hawkeye application</A>, which is a sort of superpowered Spy++ for .NET. Hawkeye allows you to attach to any running .NET application and inspect various .NET controls and their properties as well as methods, events, and all sorts of other fun things. With Hawkeye, you can even CHANGE properties and INVOKE methods! On the fly! And the other .NET application never even has to know about it!</P>
<P>His <A href="http://www.acorns.com.au/projects/vsaddins/">VS Properties Extender</A> uses the functionality of Hawkeye to add a text box to the properties window at run time which allows you to filter to commands. It works great, too. Now I'm really curious what other sorts of functionality could be added to an application like Visual Studio by using Hawkeye. Check it out!</P>
<P><IMG style="BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px" height=174 src="http://www.mohundro.com/blog/content/binary/2006-08-31-vs-extender.png" width=263 border=0> </P>
<P>(found via <A href="http://www.larkware.com/dg6/TheDailyGrind960.aspx">Larkware</A>)</P>
<b>UPDATE (2009-10-19):</b> I've received a few email questions related to this the Properties Extender and where to find it - to be honest, it looks like it has entirely disappeared. I don't have the download anymore either. If I do find it again, then I'll try to update this post, but it appears that, at least for now, it's gone.

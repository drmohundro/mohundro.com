
title: "XPath Helper"
author: David
date: 2006/06/06
categories: .net;utilities

I don't have much experience with XPath expressions. This was further illustrated to me recently when I was attempting to use XPath to programmatically parse an MSBuild project file. Yeah... I couldn't find anything. So, when presented with a problem, what do all programmers do? They write a program to solve the problem!

Here's a screenshot of my XPath Helper:

![XPath Helper App](http://www.mohundro.com/blog/content/binary/2006-06-06-XPathHelper.png)

As you can see, I learned how to use XPath to parse MSBuild project files. My problem was not using XML namespaces correctly. XPath Helper attempts to automatically find XML namespaces and then add them to an XmlNamespaceManager (see the ListBox on the right - it lists all namespaces that it found). That way, when an XPath expression is used, it will know to use the XmlNamespaceManager. I'm confident that it won't work in all situations, but it is a nice learning tool to play around with XPath.

If anyone is interested, I can post the code... but if I do, don't count on it having any unit tests or anything. This guy is NOT production quality.



title: "\"The designer loader did not provide a root component but has not indicated why.\""
author: David
date: 2006/04/14
categories: .net;programming;visual studio
guid: 3790cea0-9197-4008-84b7-a402cfcc91b3

Ever seen this error in Visual Studio 2005?

![Designer Error](http://www.mohundro.com/blog/content/binary/2006-04-14-designer-error.gif)

I've seen it all too often and it is really annoying.

However, I did find a possible fix today. I was working in a project that had multiple assembly references. One of the references was using a 1.1 assembly, so it came along for the ride. By simply removing that reference, I was able to view my form without any problems. If I tried to add the reference back, I would get the designer error again. I reworked the assembly being referenced to not use any 1.1 components and... lo and behold... the designer errors stopped.

Is this just a really random bug or is this a subtle way to push people to migrate to .NET 2.0?


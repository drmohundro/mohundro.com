
title: "My Vista stability score is way down lately..."
author: David
date: 2007/02/20
categories: windows vista

Check this out... 

![Vista Reliability Score](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/MyVistastabilityscoreiswaydownlately_11A85/image%7B0%7D%5B3%5D.png)  

My Vista stability score was well on its way back to 10 when I got hammered with some hard crashes in Internet Explorer. It took me a while to figure out what the problem was, but then I noticed the Sun Java icon in the toolbar and the Data Execution Protection message...

I had recently enabled DEP with Internet Explorer via the Internet Options menu (you'll have to run Internet Explorer as an Administrator before you can change this option). I was sort of curious about it and wanted to check it out. 

![Internet Options](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/MyVistastabilityscoreiswaydownlately_11A85/image%7B0%7D%5B6%5D.png)  

I discovered about [DEP and Internet Explorer 7 via Michael Howard's blog](http://blogs.msdn.com/michael_howard/archive/2006/12/12/update-on-internet-explorer-7-dep-and-adobe-software.aspx) and I also verified from a comment to his post that (as of the writing of this post), the Sun JVM does not work with DEP in Internet Explorer. 

So, if you're getting a lot of random crashes in IE, don't stress out. It might be DEP. 
Too bad my stability score had to drop so low, though.


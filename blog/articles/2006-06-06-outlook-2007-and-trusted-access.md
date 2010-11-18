
title: "Outlook 2007 and Trusted Access"
author: David
date: 2006/06/06
categories: general;programming
guid: bd274f71-7932-4423-be55-372d4c836534

As many of you are aware, if you attempt to access your Outlook data using some of the Outlook Interop assemblies, you'll be seeing a security dialog informing you that something is attempting to access your emails and whether or not you will allow this. If you're like me, you've run into this before and attempted to [circumvent it](http://www.mohundro.com/blog/PermaLink,guid,7f402ce8-f923-4e77-bd87-4414ae0aaa88.aspx).

Well, with the advent of Office 2007, we can all breathe a huge sigh of relief. Why, you ask? Because the fine folks at Microsoft heard our collective annoyances about the security model and fixed it! For the long story, check out [this MSDN article](http://msdn2.microsoft.com/en-us/ms772422.aspx). Here's the gist of it:

> Outlook 2007 introduces an important change in the way that the Outlook object model guard operates. While the behavior of the object model guard has not changed significantly for Outlook add-ins, Outlook 2007 allows external applications to run without object model guard prompts-**provided that the computer on which your code is running has functional antivirus software installed and that all antivirus definitions are current**."

I've bolded the important part for you. Now, you'll only get the warning if your antivirus software is out of date. You also have the option to either always show the warnings (yeah, right) or completely disable the warnings. Your choice.

Great news!


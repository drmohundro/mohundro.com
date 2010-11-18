
title: "Tech Ed &ndash; Day 2 Review"
author: David
date: 2008/07/03
categories: conferences
guid: e82fb73d-25c9-40af-b999-1ef331a7c084

Continuing in my never-ending (at least until day 4) review of Tech Ed, this post will talk about how the second day of the conference went. 
 
At breakfast, I got to sit down at the same table as [Sara Ford](http://blogs.msdn.com/saraford), a PM at Microsoft on the CodePlex team and a well known for her [Visual Studio Tip of the Day](http://blogs.msdn.com/saraford/archive/tags/Visual+Studio+2008+Tip+of+the+Day/default.aspx) series. That experience sort of reinforced the fact that you really do get to interact with the people who are working on the tools that we use every day. 

The first session from that day was entitled "Nine Essential Tools for Every Developer." I left early because I didn't notice the subtitle that told me the session was *actually* about Office Power Tools. I don't currently develop any Office interop applications, primarily because we're still supporting Office 2000 (if not 97). It wasn't exactly the most accurate session title. 

I attended a session by [Drew Robbins](http://blogs.iis.net/drobbins/) on hosting WCF in IIS7. I am seriously excited about IIS7 and it really makes me want to move my development machine from XP to either Vista or Server 2008. It won't really make a difference because we're still targeting Server 2003 (and thus IIS6), but it is still awesome. I got a lot more out of this session on IIS7 than I did on WCF hosting. The best part of the session for me was the demo of the [IIS7 PowerShell provider](http://blogs.msdn.com/powershell/archive/2008/07/03/iis7-powershell-provider-tech-preview-2.aspx). 

At lunch, I got to hang out with the [TwitterTribe](http://hashtags.org/tag/twittertribe/). 

![TwitterTribe lunch (includes Colin Neller, Scott C. Reynolds, Alan Stevens, and others)](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/TechEdDay2Review_8D46/Tech%20Ed%202008%202008-06-02%20005.jpg)  

I didn't catch everyone's name, but the picture above has (from left) [Colin Neller](http://www.colinneller.com/blog/) ([http://twitter.com/cneller](http://twitter.com/cneller)), [Scott C. Reynolds](http://www.scottcreynolds.com/) ([http://twitter.com/scottcreynolds](http://twitter.com/scottcreynolds "http://twitter.com/scottcreynolds")), and [Alan Stevens](http://netcave.org/) ([http://twitter.com/alanstevens](http://twitter.com/alanstevens "http://twitter.com/alanstevens")) (after the guy in the blue shirt). The guy on the right just out of the picture is [Dan Hibbets](http://mobilitymatters.wordpress.com/) ([http://twitter.com/MobilityMatters](http://twitter.com/MobilityMatters)). [Keith Elder](http://keithelder.net/blog/) ([http://twitter.com/keithelder](http://twitter.com/keithelder)) swung by later as did [Cory Smith](http://addressof.com/blog) ([http://twitter.com/DualBrain](http://twitter.com/DualBrain)). I apologize to those that I missed (leave a comment and I'll add you in, too). We had a lot of fun geeking out and thanks to Alan for organizing it. Alan even put together a poster with the "Twitter is having problems" image so we would know where to meet up. :-) 

After lunch, I attended a session by [Scott Hanselman](http://www.hanselman.com/blog/) on Dynamic Data in ASP.NET. Scott is a great presenter, but you already knew that if you've watched any of his sessions or screencasts. This session served as a part 1 to a two part session, but I skipped out on part 2, because I had to catch the session on the Managed AddIn Framework. 

The session on MAF with Jesse Kaplan was very exciting to me. Some of the readers will know that the primarily application that I work on dynamically hosts other application in it. I deal with things like Assembly Binding, Assembly Loading, versioning, etc. every single day. I am really excited about System.AddIn. Having the ability to load up addins in separate AppDomains to have isolation from your host to your addin is a great feature. Honestly, I know this could be done before, but the real benefit for us is the ability to host our addins (that have a UI) in a separate AppDomain. Through some very nasty hacking, I was able to get WinForms UI to run in a separate AppDomain from the host WinForms UI, but it was not ideal by any means. If you want to do this sort of thing, *look at System.AddIn*. I'd like to present on MAF at the user groups in the area at some point, so if you're at all interested in this, let me know and I'll see about putting some information together. 

That pretty much finishes up my second day of Tech Ed. Just two more days of review left!


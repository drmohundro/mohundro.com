
title: "Tech Ed &ndash; Day 2 Review"
author: David
date: 2008/07/02

<p></p> <p>Continuing in my never-ending (at least until day 4) review of Tech Ed, this post will talk about how the second day of the conference went.</p> <p></p> <p>At breakfast, I got to sit down at the same table as <a href="http://blogs.msdn.com/saraford">Sara Ford</a>, a PM at Microsoft on the CodePlex team and a well known for her <a href="http://blogs.msdn.com/saraford/archive/tags/Visual+Studio+2008+Tip+of+the+Day/default.aspx">Visual Studio Tip of the Day</a> series. That experience sort of reinforced the fact that you really do get to interact with the people who are working on the tools that we use every day.</p> <p>The first session from that day was entitled “Nine Essential Tools for Every Developer.” I left early because I didn’t notice the subtitle that told me the session was <em>actually</em> about Office Power Tools. I don’t currently develop any Office interop applications, primarily because we’re still supporting Office 2000 (if not 97). It wasn’t exactly the most accurate session title.</p> <p>I attended a session by <a href="http://blogs.iis.net/drobbins/">Drew Robbins</a> on hosting WCF in IIS7. I am seriously excited about IIS7 and it really makes me want to move my development machine from XP to either Vista or Server 2008. It won’t really make a difference because we’re still targeting Server 2003 (and thus IIS6), but it is still awesome. I got a lot more out of this session on IIS7 than I did on WCF hosting. The best part of the session for me was the demo of the <a href="http://blogs.msdn.com/powershell/archive/2008/07/03/iis7-powershell-provider-tech-preview-2.aspx">IIS7 PowerShell provider</a>.</p> <p>At lunch, I got to hang out with the <a href="http://hashtags.org/tag/twittertribe/">TwitterTribe</a>.</p> <p><a href="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/TechEdDay2Review_8D46/Tech%20Ed%202008%202008-06-02%20005.jpg"><img title="TwitterTribe lunch (includes Colin Neller, Scott C. Reynolds, Alan Stevens, and others)" style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="483" alt="TwitterTribe lunch (includes Colin Neller, Scott C. Reynolds, Alan Stevens, and others)" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/TechEdDay2Review_8D46/Tech%20Ed%202008%202008-06-02%20005_thumb.jpg" width="644" border="0"></a> </p> <p>I didn’t catch everyone’s name, but the picture above has (from left) <a href="http://www.colinneller.com/blog/">Colin Neller</a> (<a href="http://twitter.com/cneller">http://twitter.com/cneller</a>), <a href="http://www.scottcreynolds.com/">Scott C. Reynolds</a> (<a title="http://twitter.com/scottcreynolds" href="http://twitter.com/scottcreynolds">http://twitter.com/scottcreynolds</a>), and <a href="http://netcave.org/">Alan Stevens</a> (<a title="http://twitter.com/alanstevens" href="http://twitter.com/alanstevens">http://twitter.com/alanstevens</a>) (after the guy in the blue shirt). The guy on the right just out of the picture is <a href="http://mobilitymatters.wordpress.com/">Dan Hibbets</a> (<a href="http://twitter.com/MobilityMatters">http://twitter.com/MobilityMatters</a>). <a href="http://keithelder.net/blog/">Keith Elder</a> (<a href="http://twitter.com/keithelder">http://twitter.com/keithelder</a>) swung by later as did <a href="http://addressof.com/blog">Cory Smith</a> (<a href="http://twitter.com/DualBrain">http://twitter.com/DualBrain</a>). I apologize to those that I missed (leave a comment and I’ll add you in, too). We had a lot of fun geeking out and thanks to Alan for organizing it. Alan even put together a poster with the “Twitter is having problems” image so we would know where to meet up. :-)</p> <p>After lunch, I attended a session by <a href="http://www.hanselman.com/blog/">Scott Hanselman</a> on Dynamic Data in ASP.NET. Scott is a great presenter, but you already knew that if you’ve watched any of his sessions or screencasts. This session served as a part 1 to a two part session, but I skipped out on part 2, because I had to catch the session on the Managed AddIn Framework.</p> <p>The session on MAF with Jesse Kaplan was very exciting to me. Some of the readers will know that the primarily application that I work on dynamically hosts other application in it. I deal with things like Assembly Binding, Assembly Loading, versioning, etc. every single day. I am really excited about System.AddIn. Having the ability to load up addins in separate AppDomains to have isolation from your host to your addin is a great feature. Honestly, I know this could be done before, but the real benefit for us is the ability to host our addins (that have a UI) in a separate AppDomain. Through some very nasty hacking, I was able to get WinForms UI to run in a separate AppDomain from the host WinForms UI, but it was not ideal by any means. If you want to do this sort of thing, <em>look at System.AddIn</em>. I’d like to present on MAF at the user groups in the area at some point, so if you’re at all interested in this, let me know and I’ll see about putting some information together.</p> <p>That pretty much finishes up my second day of Tech Ed. Just two more days of review left!</p>

title: "Find-String.ps1 – ack for PowerShell"
author: David
date: 2009/06/11

Never heard of [ack](http://betterthangrep.com/)? Well, by ack's admission, it is "better than grep." That's up to you to decide, but it does make searching code easier than grep. 

As a means of illustration, here is a grep example of a recursive search for StringBuilder across multiple C# files that I used back in [my post on "finding stuff quickly."](http://www.mohundro.com/blog/2009/05/12/FindingStuffQuicklyOrSearchingThroughCodeEffectively.aspx) 

![grep output](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Findingstuffquicklyorsearchingthroughcod_BD54/image_thumb_5.png)

The output is pretty nice, but the addition of the find command to limit the searching to only C# files isn't the easiest to type quickly. 

ack makes this a little... well, a lot easier. 

![ack output](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/FindString.ps1ackforPowerShell_7013/image_2.png)

Nice! Even EASIER to read than the grep matching. And it is easier to type. 

Well, of course, I had to add this functionality to Find-String. (Guess what, it runs faster than grep and ack both! At least on Windows...) 

![Find-String output](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/FindString.ps1ackforPowerShell_7013/image_4.png)

Now, this makes… the third post I've had on a Find-String PowerShell script I think. At some point, you're going to get tired of this if you haven't already.

"Is this guy seriously going to post every time he changes the way Find-String works?"

No, no, I guess I shouldn't. 

But for my own benefit, I do want this in source control. And I'd like to make it easier to use and find this. I've been using a local SVN repository for my changes to my scripts, but they included all of my scripts. Well, I moved just the Find-String source over to GitHub yesterday. I even started from the initial version of Find-String and committed my change history over from SVN :-) 

![Find-String on GitHub](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/FindString.ps1ackforPowerShell_7013/image_6.png)

For up to date versions of Find-String, they'll be out there. The URL is [http://github.com/drmohundro/Find-String/tree/master](http://github.com/drmohundro/Find-String/tree/master). If you don't want to install [git](http://www.git-scm.com/) to check the source out, there is a big download button on the project page. It will package up the current version of Find-String for you which you can then download and use to your heart's content. 

If you improve upon the script, send me pull requests or a patch and I'd be happy to make it better. 

**Warning, upcoming tangent regarding GitHub adding PowerShell syntax support...**

My other hope with posting this is that maybe GitHub will add the PowerShell syntax support to GitHub. If you view the source for Find-String on the GitHub website, you won't see any syntax highlighting. 

![GitHub not highlighting PowerShell syntax](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/FindString.ps1ackforPowerShell_7013/image_8.png)

But... they have syntax highlighting for *lots* of other file types, as is evidenced by the gists I've already shared. 

![GitHub highlighting C# syntax](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/FindString.ps1ackforPowerShell_7013/image_10.png)

[I already asked for this on the GitHub support site](http://support.github.com/discussions/feature-requests/327-powershell-as-a-support-language#comment_134001), but it was inexplicably closed with "no more actions from GitHub... are required" and that it is apparently “resolved.” Maybe I shouldn't worry and the feature just hasn't gone live yet. In which case, I'm just blabbing on and on for no reason and creating a long tangent to the rest of my post. If *not*, well, maybe they'll add support if I complain some more!

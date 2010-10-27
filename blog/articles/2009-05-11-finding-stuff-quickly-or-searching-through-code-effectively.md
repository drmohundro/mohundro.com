
title: "Finding stuff quickly (or searching through code effectively)"
author: David
date: 2009/05/11

I [blogged a while back about finding in files with PowerShell](http://www.mohundro.com/blog/2006/11/06/FindInFilesWithPowerShell.aspx) and I wanted to share an update on that. 
The original post highlighted using a combination of Get-ChildItem and Select-String to quickly find things. It works fine, but the output isn’t the easiest to read, because the found text isn’t highlighted in any way.
<pre class="brush: ps1;">Get-ChildItem –include *.cs –recurse | Select-String searchText
</pre>

[<img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Findingstuffquicklyorsearchingthroughcod_BD54/image_thumb_3.png" width="678" height="127">](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Findingstuffquicklyorsearchingthroughcod_BD54/image_8.png) 

I really like the color output that grep provides. Check out the results of grep on the same search.
<pre class="brush: bash;">find –name *.cs | xargs grep StringBuilder
</pre>

[<img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Findingstuffquicklyorsearchingthroughcod_BD54/image_thumb_4.png" width="665" height="85">](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Findingstuffquicklyorsearchingthroughcod_BD54/image_10.png) 

That is <em>so much easier</em> to read that it isn’t even funny. The match jumps out at you because of the color difference.

I did some searching and found [Wes Haggardâs Find-String script](http://weblogs.asp.net/whaggard/archive/2007/03/23/powershell-script-to-find-strings-and-highlight-them-in-the-output.aspx). It had the additional benefit that it also displayed the line number, but it didn’t display the relative path.
<pre class="brush: ps1;">find-string.ps1 StringBuilder *.cs -recurse
</pre>

[<img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Findingstuffquicklyorsearchingthroughcod_BD54/image_thumb_2.png" width="663" height="82">](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Findingstuffquicklyorsearchingthroughcod_BD54/image_6.png) 

Wes’ script still served my purposes, though, so I used it for a long time until I learned about grep’s Context Line Control arguments. They would let grep print out additional lines before or after the display search result so that you could see the context of your search result. Like so:
<pre class="brush: bash;">find –name *.cs | xargs grep StringBuilder –A 3
</pre>

[<img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Findingstuffquicklyorsearchingthroughcod_BD54/image_thumb_5.png" width="700" height="159">](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Findingstuffquicklyorsearchingthroughcod_BD54/image_12.png) 

Unfortunately for me, PowerShell’s Select-String didn’t support context… at least until version 2.

With the addition of the Context parameter, I could now build a nice grep replacement in PowerShell. I broke my version out into two separate scripts: one to actually format the MatchInfo object and one to do the finding. As you might imagine, the formatting script is a little more interesting. You can get Out-ColorMatchInfo at [http://poshcode.org/1095](http://poshcode.org/1095 "http://poshcode.org/1095") and you can get my version of Find-String at [http://poshcode.org/1096](http://poshcode.org/1096 "http://poshcode.org/1096").

Here’s sample output:
<pre class="brush: ps1;">find-string StringBuilder *.cs –context 0,3
</pre>

[<img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Findingstuffquicklyorsearchingthroughcod_BD54/image_thumb_6.png" width="650" height="183">](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Findingstuffquicklyorsearchingthroughcod_BD54/image_14.png) 

I went with only displaying the relative path to the file on one line and then displaying the results on the following lines. It makes reading context easier for me.

Let me know what you think.

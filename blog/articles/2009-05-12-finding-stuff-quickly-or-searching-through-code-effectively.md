
title: "Finding stuff quickly (or searching through code effectively)"
author: David
date: 2009/05/12
categories: powershell;utilities

I [blogged a while back about finding in files with PowerShell](http://www.mohundro.com/blog/2006/11/06/FindInFilesWithPowerShell.aspx) and I wanted to share an update on that. 

The original post highlighted using a combination of Get-ChildItem and Select-String to quickly find things. It works fine, but the output isn't the easiest to read, because the found text isn't highlighted in any way.

    Get-ChildItem -include *.cs -recurse | Select-String searchText

![Get-ChildItem Output](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Findingstuffquicklyorsearchingthroughcod_BD54/image_8.png) 

I really like the color output that grep provides. Check out the results of grep on the same search.

    find -name *.cs | xargs grep StringBuilder

![grep output](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Findingstuffquicklyorsearchingthroughcod_BD54/image_10.png) 

That is *so much easier* to read that it isn't even funny. The match jumps out at you because of the color difference.

I did some searching and found [Wes Haggard's Find-String script](http://weblogs.asp.net/whaggard/archive/2007/03/23/powershell-script-to-find-strings-and-highlight-them-in-the-output.aspx). It had the additional benefit that it also displayed the line number, but it didn't display the relative path.

    find-string.ps1 StringBuilder *.cs -recurse

![Find-String output](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Findingstuffquicklyorsearchingthroughcod_BD54/image_6.png) 

Wes' script still served my purposes, though, so I used it for a long time until I learned about grep's Context Line Control arguments. They would let grep print out additional lines before or after the display search result so that you could see the context of your search result. Like so:

    find -name *.cs | xargs grep StringBuilder -A 3

![grep output with context](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Findingstuffquicklyorsearchingthroughcod_BD54/image_12.png) 

Unfortunately for me, PowerShell's Select-String didn't support context... at least until version 2.

With the addition of the Context parameter, I could now build a nice grep replacement in PowerShell. I broke my version out into two separate scripts: one to actually format the MatchInfo object and one to do the finding. As you might imagine, the formatting script is a little more interesting. You can get Out-ColorMatchInfo at [http://poshcode.org/1095](http://poshcode.org/1095) and you can get my version of Find-String at [http://poshcode.org/1096](http://poshcode.org/1096).

Here's sample output:

    find-string StringBuilder *.cs -context 0,3

![Find-String output with context](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Findingstuffquicklyorsearchingthroughcod_BD54/image_14.png) 

I went with only displaying the relative path to the file on one line and then displaying the results on the following lines. It makes reading context easier for me.

Let me know what you think.


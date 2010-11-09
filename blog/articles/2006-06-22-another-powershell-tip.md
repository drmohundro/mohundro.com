
title: "Another PowerShell tip..."
author: David
date: 2006/06/22
categories: programming;utilities

I can't help myself, PowerShell is great and I keep finding useful things to do with it. Most of what I've been finding is easily accomplished in other ways, but this just goes to show the power available straight from the PowerShell command prompt.

What if you want to know the full path to all of the solutions in a sub-directory?

You could try this:

    PS C:\Dev>dir -recurse -include *.sln . | foreach { $_.FullName }
    
This builds on my [post](http://feeds.feedburner.com/DavidMohundro?m=63) from yesterday.

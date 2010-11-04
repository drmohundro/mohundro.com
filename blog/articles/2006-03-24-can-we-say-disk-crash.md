
title: "Can we say disk crash?"
author: David
date: 2006/03/24
categories: general;hardware

Yesterday, after I had been at work for about an hour, Outlook started giving me some weird errors (something about cyclic redundancy checks). I googled the error and found a KB article that suggested that I try chkdsk. I tried that and it found some bad sectors on my drive. Afterwards, my computer booted back up and from then on... utter mayhem. Explorer would die with "Unknown hard errors" all over the place.

Below is a screenshot of my eventvwr after my disk was ghosted to a new, working drive. As you can see, the all-wise eventvwr knew there were problems before I did.

![Event Viewer Screenshot](http://www.mohundro.com/blog/content/binary/2006-03-24-diskEvents.png)<img src="" border="0">


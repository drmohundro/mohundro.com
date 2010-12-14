
title: "Documents and Settings still exists in Vista..."
author: David
date: 2006/09/29
categories: windows vista
guid: 953e99da-055a-42dd-9135-f27ff430aa1c

If you've seen some of the Vista screenshots lately or even installed the RC1 for Vista, you will undoubtedly have noticed that Windows Vista makes use of the C:\Users directory instead of C:\Documents and Settings that Windows XP had previously used. 

I had been a little curious how Vista handled programs that might have the C:\Documents and Settings path hardcoded (which is a bad thing), but I now understand. *Documents and Settings still exists!* The new Users directory is actually much more like a Junction point ([see Scott's post on code organization and junctions for more information if you're unfamiliar with junctions](http://www.hanselman.com/blog/HowDoYouOrganizeYourCode.aspx)) that references the Documents and Settings directory! 

Would you be interested to know how I discovered this? 

I was digging around my drive trying to track down a duplicate song that iTunes had found. It showed one beneath my Users directory and one beneath my Documents and Settings directory. That really threw me at first so I dug down into the hidden Documents and Settings directory and found duplicates of all of my document files! The reason I wasn't suspicious about this is because I didn't do a complete format before installing RC1. I still did a clean install, but it simply doesn't perform an upgrade of the existing Windows install... a nuance, but it is still important. The difference is that directories other than your Program Files and Windows directories stay behind. 

Anyway, I started to delete what I thought were duplicates and suddenly noticed my User directory was losing files, too! That's when I realized that Windows was using a junction of some sort to tie the User and Documents and Settings directory together. 

Thankfully, Vista's excellent Restore previous versions worked great so I didn't lose any pictures. 

![Restore Previous Versions](https://s3.amazonaws.com/mohundro/blog/WindowsLiveWriter/DocumentsandSettingsstillexistsinVista_12956/20060928vistarestore2.png)

One note about the Restore previous versions that caught me though is that if you have the folder open, it won't let you restore it. You actually have to collapse the folder in Explorer and right click on it for it to work. Or at least I did. 

**UPDATE:** [Scott Hanselman](http://www.hanselman.com/blog/WindowsVistaJunctionsAndMovingMyDocumentsToAnotherDrive.aspx) and [Rob Boek](http://robboek.com/blog/2006/09/29/JunctionsInWindowsVista.aspx) both provided some great feedback to my post. I hadn't thought to try the "dir /ad" command like Rob did to show the junction... I was mainly basing my prior statements based off of observations. Thanks for the updates guys!



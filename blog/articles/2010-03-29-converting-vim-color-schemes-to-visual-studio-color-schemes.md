
title: "Converting VIM color schemes to Visual Studio color schemes"
author: David
date: 2010/03/29
categories: powershell;vim;visual studio

My favorite text editor right now is vim. As a result, I cannot develop without my (customized) vim key bindings. To get around that when writing .NET code, I use ViEmu when I'm in Visual Studio. However, I still miss the huge variety of color schemes that are available for vim when I'm in Visual Studio.

A couple of years ago, I finally sat down and [converted by hand the Wombat theme I was using in vim for Visual Studio](http://www.mohundro.com/blog/2008/01/11/MyAttemptAtConvertingTheVIMWombatThemeToSupportVisualStudio.aspx). At the time, I attempted to write a script to do this conversion process for me, but it didn't really work out. Well, just over a month ago, I decided to try again and finally got a script working. Here's some screenshots using the [Nick Moffitt's version of the railscasts color theme](http://www.vim.org/scripts/script.php?script_id=2175) to give you an idea of how it works: 

VIM: 

![VIM Color Scheme](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/ConvertingVIMcolorschemestoVisualStudioc_BA85/image_thumb_3.png)

Visual Studio: 

![Visual Studio Color Scheme](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/ConvertingVIMcolorschemestoVisualStudioc_BA85/image_thumb_2.png)
 
I left the ReSharper lightbulb icon there so you would believe me :-) 

Now, there are differences – the conversion is not perfect and likely won't be able to be because of differences in how each editor determines things like identifiers and keywords. Still, I consider it a huge headstart in converting a color scheme if you're interested in doing this. 

For now, the code is a simple ~200 line PowerShell script (with at least 40 lines of comments taken from the vim documentation for reference) so it is pretty basic. The script also assumes that a starting vssettings file lives next to the script as a starting point for the conversion. The brains behind the conversion is a big hash table in the script that maps Visual Studio color scheme settings to vim color scheme settings. 

![VS to VIM Mapping](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/ConvertingVIMcolorschemestoVisualStudioc_BA85/image_thumb_4.png)

If you're interested in trying it out or if you'd like to check out the code, I posted it up on github at [http://github.com/drmohundro/ColorConverter](http://github.com/drmohundro/ColorConverter). My long term goal for this would be to add a GUI to the project so that color schemes could be viewed side by side and allow tweaks to be made before exporting the final vssettings file. Also, I'm not at all opposed to looking into converting between other editors besides vim or Visual Studio.


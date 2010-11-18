
title: "PowerShell in Color!"
author: David
date: 2006/07/26
categories: powershell
guid: 7945d820-4f60-4ecf-bad1-ff2932e029f5

Recently, I've been experimenting with different console colors in PowerShell, primarily because the light gray on black is sort of boring (lame excuse, I know). I've been using [Console](http://sourceforge.net/projects/console) and I had set the foreground color to green in the options. The only problem with doing this is that programs that output other colors, such as the error messages from MSBuild, are not displayed. I like seeing the color difference because the red text really jumps out at me and says that I have an error.

This got me curious about whether or not I could set a different color in PowerShell, instead of in Console. I stumbled across this [TechNet article](http://www.microsoft.com/technet/scriptcenter/topics/msh/output.mspx) from way back when PowerShell was still MSH. Basically, you use the -foregroundcolor or -backgroundcolor switch against Write-Host to alter the color of the text you're outputting. That's certainly userful information if you're writing cmdlets, but I wanted to change the default color for the entire session.

If you've worked with .NET console applications, you may have seen System.Console.ForegroundColor. Well, this is available from PowerShell as well! .NET shell integration is great! So now, my PowerShell profile has a brand new line in it:

    [System.Console]::ForegroundColor = [System.ConsoleColor]::Green

By doing this, whenever an application, cmdlet, function or whatever changes the default output color, like MSBuild does, you'll be able to see it. As a side note, I really like the PowerShell profile idea. Though options dialogs tend to be more user friendly, the PowerShell profile (try 'notepad $profile') is far more powerful and customizable.


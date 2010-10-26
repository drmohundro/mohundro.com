
title: "PowerShell in Color!"
author: David
date: 2006/07/25

<P>Recently, I've been experimenting with different console colors in PowerShell, primarily because the light gray on black is sort of boring (lame excuse, I know). I've been using <A href="http://sourceforge.net/projects/console">Console</A> and I had set the foreground color to green in the options. The only problem with doing this is that programs that output other colors, such as the error messages from MSBuild, are not displayed. I like seeing the color difference because the red text really jumps out at me and says that I have an error.</P>
<P>This got me curious about whether or not I could set a different color in PowerShell, instead of in Console. I stumbled across this <A href="http://www.microsoft.com/technet/scriptcenter/topics/msh/output.mspx">TechNet article</A> from way back when PowerShell was still MSH. Basically, you use the -foregroundcolor or -backgroundcolor switch against Write-Host to alter the color of the text you're outputting. That's certainly userful information if you're writing cmdlets, but I wanted to change the default color for the entire session.</P>
<P>If you've worked with .NET console applications, you may have seen System.Console.ForegroundColor. Well, this is available from PowerShell as well! .NET shell integration is great! So now, my PowerShell profile has a brand new line in it:</P>
<P><FONT face="Courier New">[System.Console]::ForegroundColor = [System.ConsoleColor]::Green</FONT></P>
<P>By doing this, whenever an application, cmdlet, function or whatever changes the default output color, like MSBuild does, you'll be able to see it. As a side note, I really like the PowerShell profile idea. Though options dialogs tend to be more user friendly, the PowerShell profile (try 'notepad $profile') is far more powerful and customizable.</P>

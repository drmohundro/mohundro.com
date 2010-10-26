
title: "Easily open the results from Select-String"
author: David
date: 2006/11/28

<p>A few weeks ago I posted a way to use PowerShell to find in files. This is just an extension of that post to show how you might open the results of your find in a program.</p> <p>Try this out:</p> <p><font face="Consolas">dir -include *.vb -recurse | select-string "text to search for" | % { notepad $_.Path }</font></p> <p>If you've got a lot of Visual Basic files that contain "text to search for", you may end up with a lot of instances of notepad open. At work, I use UltraEdit, so I typically would open my files using uedit32 so that all of the results get opened in tabs. You could do the same with Notepad++ or any other program.</p> <p>I haven't really used PowerShell for much production work, but it has already made me for more productive than I used to be.</p> <p>While I'm at it, I'll share another nice one-liner that <a href="http://www.kerryjenkins.com">Kerry</a> shared with me to ngen all assemblies in a directory:</p> <p><font face="Consolas">dir *.dll | % { C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\ngen.exe $_.fullname}</font></p>

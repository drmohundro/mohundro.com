
title: "Find in files with PowerShell"
author: David
date: 2006/11/06
categories: powershell
guid: ec5e386a-5eba-4473-b553-e5e4350e0404

I haven't posted anything on PowerShell in a while so here's something that's useful. 

    Get-ChildItem -Recurse -Include *.* | Select-String "text to search for"

Or, if you like things a little more abbreviated, try this: 

    dir -r -i *.* | Select-String "text to search for"

Select-String is a cmdlet that will search files or strings, sort of like grep in Unix or findstr in cmd.exe. If you use the Get-ChildItem cmdlet, you can specify the -Recurse switch to retrieve subdirectories and the -Include switch will only include the file types that you specify. Then you can pipe it over to Select-String. 

Pretty nifty if you're wanting to do some quick file searches. 

Check out this [PowerShell in Action book excerpt](http://www.microsoft.com/technet/scriptcenter/topics/winpsh/payette2.mspx). It gives a good overview on file manipulation from PowerShell and also introduced me to using the Get-ChildItem command and piping the output to Select-String. 

Before I began using PowerShell, I had been using a small cmd file called ff.cmd that used the following: 

    findstr /p /s /i /c:%1 %2

Then I could type things like: 

    ff "text to search for" .\*.*

But PowerShell is so much cooler now :-)



title: "Find in files with PowerShell"
author: David
date: 2006/11/05

I haven't posted anything on PowerShell in a while so here's something that's useful. 
<font face="Consolas" size="2">Get-ChildItem -Recurse -Include *.* | Select-String "<em>text to search for</em>"</font> 
Or, if you like things a little more abbreviated, try this: 
<font face="Consolas" size="2">dir -r -i *.* | Select-String "<em>text to search for</em>"</font> 
Select-String is a cmdlet that will search files or strings, sort of like grep in Unix or findstr in cmd.exe. If you use the Get-ChildItem cmdlet, you can specify the -Recurse switch to retrieve subdirectories and the -Include switch will only include the file types that you specify. Then you can pipe it over to Select-String. 
Pretty nifty if you're wanting to do some quick file searches. 
Check out this [PowerShell in Action book excerpt](http://www.microsoft.com/technet/scriptcenter/topics/winpsh/payette2.mspx). It gives a good overview on file manipulation from PowerShell and also introduced me to using the Get-ChildItem command and piping the output to Select-String. 
Before I began using PowerShell, I had been using a small cmd file called ff.cmd that used the following: 
<font face="Consolas" size="2">findstr /p /s /i /c:%1 %2</font> 
Then I could type things like: 
<font face="Consolas" size="2">ff "<em>text to search for</em>" .\*.*</font> 
But PowerShell is so much cooler now :-)

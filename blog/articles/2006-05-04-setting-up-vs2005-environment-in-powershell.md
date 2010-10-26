
title: "Setting up VS2005 environment in PowerShell"
author: David
date: 2006/05/04

Many thanks to <a href="http://et.cairene.net/">Robert W. Anderson</a> for this solution.<br /><br />In his post <a href="http://et.cairene.net/2006/05/02/vs2005-powershell-prompt/">VS2005 PowerShell Prompt</a>, Robert details how to create your PowerShell profile script which will add the VS2005 environment variables to the PowerShell process. Quite nifty.<br /><br />As a note, after setting this up, you may get a message about how your script isn't signed so it won't run. One solution is to run "Set-ExecutionPolicy RemoteSigned". I wouldn't recommend going farther than that, though. It will allow local scripts to run unsigned and will warn you if a script that was downloaded tries to run. There are still vulnerabilities, so be careful. The other alternative is to sign your script.<br />
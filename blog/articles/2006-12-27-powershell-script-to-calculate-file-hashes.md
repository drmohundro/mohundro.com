
title: "PowerShell script to calculate file hashes"
author: David
date: 2006/12/27

<p><strong>UPDATE NUMBER 2:</strong></p> <p>Kevin commented about a flaw in my script wherein it would keep files open until the PowerShell process was closed - a scenario I should've tested but, in all of the excitement (ha),&nbsp;I missed. You won't believe what the problem was, either. I forgot parentheses on my $inStream.Close() method (it looked like $inStream.Close instead of $inStream.Close<strong>()</strong> ). The reason the trap { } script block didn't catch it is because the statement was still valid... it would just display the MethodInfo like below:</p><pre style="font-family: consolas">MemberType          : Method
OverloadDefinitions : {System.Void Close()}
TypeNameOfValue     : System.Management.Automation.PSMethod
Value               : System.Void Close()
Name                : Close
IsInstance          : True
</pre>
<p>The [void] statement before it prevented the output from displaying, hence me not catching the bug. The script has now been fixed (hopefully). Thanks for the catch Kevin!</p>
<p><strong>UPDATE:</strong></p>
<p>Ignore my script. Go download the <a href="http://www.codeplex.com/Wiki/View.aspx?ProjectName=PowerShellCX">PowerShell Community Extensions</a> instead. It has a great Get-Hash script that does everything that my script does and more. I wish I had downloaded it sooner :-)</p>
<p>&nbsp;</p>
<p>Jeffrey Snover posted a suggestion on the <a href="http://blogs.msdn.com/powershell/">PowerShell blog</a> recently to <a href="http://blogs.msdn.com/powershell/archive/2006/12/27/resolve-to-blog-your-automation.aspx">post automation scripts people have written</a> in PowerShell that they use. Well, here is a script I wrote that I also submitted for the <a href="http://blogs.msdn.com/powershell/archive/2006/12/01/powershell-scripting-contest-2-weeks-left.aspx">PowerShell Scripting Contest</a> a few weeks back. The script is quite basic and is based on <a href="http://blogs.msdn.com/powershell/archive/2006/04/25/583225.aspx">other code I found</a>, but I added a little bit to it to handle some of my own needs. It calculates file hashes based on a specified hash algorithm (i.e. SHA1, MD5, etc). I like to use it to determine if a large file I've downloaded (like an ISO from MSDN) is a good file or if it was corrupted during the download.</p>
<p>Here is Calc-Hash.ps1:</p><pre style="font-family: consolas">param (
	[string] $inFile = $(throw "Usage: Calc-Hash.ps1 file.txt [sha1|md5] "),
	[string] $hashType = "sha1"
)

function Main
{
	if ($hashType -eq "")
	{
		throw "Usage: Calc-Hash.ps1 file.txt [sha1|md5] "
	}
	
	if ($hashType -eq "sha1")
	{
		$provider = New-Object System.Security.Cryptography.SHA1CryptoServiceProvider
	}
	elseif ($hashType -eq "md5")
	{
		$provider = New-Object System.Security.Cryptography.MD5CryptoServiceProvider
	}
	else
	{
		throw "Unsupported hash type $hashType"
	}
		
	$inFileInfo = New-Object System.IO.FileInfo($inFile)
	if (-not $inFileInfo.Exists)
	{
		# If the file can't be found, try looking for it in the current directory.
		$inFileInfo = New-Object System.IO.FileInfo("$pwd\$inFile")
		if (-not $inFileInfo.Exists)
		{
			throw "Can't find $inFileInfo"
		}
	}

	$inStream = $inFileInfo.OpenRead()
	$hashBytes = $provider.ComputeHash($inStream)
	[void] $inStream.Close()
	
	trap
	{
		if ($inStream -ne $null)
		{
			[void] $inStream.Close()
		}
		break
	}
	
	foreach ($byte in $hashBytes)
	{
		Write-Host -NoNewLine $byte.ToString("X2")
	}
	
	Write-Host
}

. Main
</pre>

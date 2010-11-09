
title: "Quickly Extract Files with PowerShell"
author: David
date: 2009/03/31
categories: powershell

This is just a quick post to share a *very* simple PowerShell script I wrote to extract files from a compressed file (zip, 7z, whatever). When downloading utilities that don't have installers, like Sysinternals tools, I typically extract them to a Utils directory that is in my PATH. Previously, I would always do this by right-clicking, choosing the 7-Zip context menu option and then extracting to to c:\Utils. Another common option would be to extract to a folder of the same name. 

![7-Zip Extracting Files](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/QuicklyExtractFileswithPowerShell_13450/image_2.png)

I had tried in the past to use the 7-Zip command line tool, but the arguments were not very intuitive or consistent with other command line tools (Windows, Unix, PowerShell or otherwise). So, I got fed up and wrote a script to do it for me. It just shells out to the 7-Zip command line app, but it saves me some time. 

The script assumes that you've aliased 'zip' to the 7z.exe command line executable.

    [1] » ls alias:zip

    CommandType     Name       Definition
    -----------     ----       ----------
    Alias           zip        7z

    [2] » get-command 7z

    CommandType     Name       Definition
    -----------     ----       ----------
    Application     7z.exe     C:\Utils\7z.exe

Here's the script:

    param (
        [string]$file,
        [string]$outputDir = ''
    )

    if (-not (Test-Path $file)) {
        $file = Resolve-Path $file
    }

    if ($outputDir -eq '') {
        $outputDir = [System.IO.Path]::GetFileNameWithoutExtension($file)
    }

    zip e "-o$outputDir" $file

Like I said, pretty basic. If you don't specify an output directory, it uses the name of the file.

Other people have written scripts that do this, too, but I needed an excuse to publish something on my blog for March :-)



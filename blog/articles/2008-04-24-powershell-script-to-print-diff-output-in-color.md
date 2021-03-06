
title: "Powershell script to print diff output in color"
author: David
date: 2008/04/24
categories: powershell;utilities
guid: 7c9325a0-6fd1-4e44-82fc-2aa2fe526e6b

Here is a simple script I wrote which was inspired by [this post on terminal color highlighting](http://www.pixelbeat.org/docs/terminal_colours/) and by [ColorDiff](http://colordiff.sourceforge.net/) that does essentially the same thing.

```powershell
# Out-ColorDiff.ps1
Process {
    if ($_) {
        foreach ($line in $_) {
            if ($line -match '^[<|-]') {
                Write-Host -ForegroundColor red $line
            }
            elseif ($line -match '^[>|+]') {
                Write-Host -ForegroundColor green $line
            }
            else {
                Write-Host $line
            }
        }
    }
} 
```

Here is a screenshot of sample output from the script:

![Out-ColorDiff](https://s3.amazonaws.com/mohundro/blog/WindowsLiveWriter/Powershellscripttoprintdiffoutputincolor_99AD/image_2.png) 

You can use it by piping the diff output to the script, like `svn diff somefile | out-colordiff` or if you're stuck using something like MKS, you can use `si diff somefile | out-colordiff`. 

Possible (and easy) additions would be to add direct parsing of a file instead of taking an argument off of the pipeline. This is all I need currently, but if you wish to add more features, feel free to leave them in the comments.



title: "Powershell script to print diff output in color"
author: David
date: 2008/04/23

Here is a simple script I wrote which was inspired by [this post on terminal color highlighting](http://www.pixelbeat.org/docs/terminal_colours/) and by [ColorDiff](http://colordiff.sourceforge.net/) that does essentially the same thing.
<pre># Out-ColorDiff.ps1<br>Process {<br>    if ($_) {<br>        foreach ($line in $_) {<br>            if ($line -match '^[&lt;|-]') {<br>                Write-Host -ForegroundColor red $line<br>            }<br>            elseif ($line -match '^[&gt;|+]') {<br>                Write-Host -ForegroundColor green $line<br>            }<br>            else {<br>                Write-Host $line<br>            }<br>        }<br>    }<br>} 
</pre>

Here is a screenshot of sample output from the script:

[<img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="274" alt="image" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Powershellscripttoprintdiffoutputincolor_99AD/image_thumb.png" width="512" border="0">](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Powershellscripttoprintdiffoutputincolor_99AD/image_2.png) 

You can use it by piping the diff output to the script, like '<span style="font-family: monospace">svn diff somefile | out-colordiff</span>' or if you're stuck using something like MKS, you can use '<span style="font-family: monospace">si diff somefile | out-colordiff</span>'. 


Possible (and easy) additions would be to add direct parsing of a file instead of taking an argument off of the pipeline. This is all I need currently, but if you wish to add more features, feel free to leave them in the comments.


title: "Simple PowerShell script to generate thumbnails"
author: David
date: 2008/10/10

<p>I was working with a lot of images for a website today and I needed to quickly create thumbnails for each one. I did a quick Google search on PowerShell and creating thumbnails, but I gave up after about a minute… yeah, I probably got impatient, but oh well.</p> <p>Anyway, here it is:</p> <p style="font-size: 12pt; font-family: consolas, monospace">get-childitem *.jpg | foreach { <br>&nbsp;&nbsp;&nbsp; $full = [System.Drawing.Image]::FromFile("$(resolve-path $_)"); <br>&nbsp;&nbsp;&nbsp; $thumb = $full.GetThumbnailImage(72, 72, $null, [intptr]::Zero); <br>&nbsp;&nbsp;&nbsp; $thumb.Save("$(resolve-path $_).thumb.jpg" ); <br>&nbsp;&nbsp;&nbsp; $full.Dispose(); <br>&nbsp;&nbsp;&nbsp; $thumb.Dispose(); <br>} </p> <p>Obviously, you likely wouldn’t hardcode the height and width for the thumbnail, but would probably base it off of the original image (i.e. varying it off of whether the image was wide or tall). But, I didn’t need to. That’s up to you to figure out :-)</p>

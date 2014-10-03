
title: "Why I love PowerShell part... I don't know..."
author: David
date: 2006/06/21
categories: programming
guid: c190b806-daf6-4be7-9dcd-86fc582050cd

Check out this snippet:

```powershell
dir -recurse -include tempproj.proj | foreach { rm $_ }
```

Awesome!

Recursively removing files!


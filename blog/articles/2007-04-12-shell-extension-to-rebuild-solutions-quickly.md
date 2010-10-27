
title: "Shell extension to rebuild solutions quickly"
author: David
date: 2007/04/12

Ever want to build Visual Studio solutions quickly, but without having to open Visual Studio or pulling up a command prompt and typing msbuild on the solution? You know, like right-clicking and choosing a build option? 
Like this? 
<img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="366" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Shellextensiontorebuildsolutionsquickly_C534/msbuildshellext4.png" width="200" border="0"> 
Just copy and paste the following into a file (msbuild.reg) and run it: <p style="font-family: consolas, monospace">Windows Registry Editor Version 5.00 <br>[HKEY_CLASSES_ROOT\VisualStudio.Launcher.sln\shell\msbuild] <br>[HKEY_CLASSES_ROOT\VisualStudio.Launcher.sln\shell\msbuild\command]<br>@="\"C:\\WINDOWS\\Microsoft.NET\\Framework\\v2.0.50727\\MSBuild.exe\" /target:Rebuild \"%1\"" 
Remember that this will only work on Visual Studio 2005 solutions. Because solution files go through a launcher to decide whether or not to open in Visual Studio 2003 or Visual Studio 2005, I don't know if you could specify for this to only apply to 2005 solutions. 
Any ideas?


title: "The _NT_SYMBOL_PATH settings with the .NET Framework reference source"
author: David
date: 2008/01/16

I couldn't find this information anywhere (yet), so I thought I'd share this. If you're already using the _NT_SYMBOL_PATH setting to download symbols from Microsoft and you want to download the symbols and source for the .NET Framework, you can set the environment variable up like so: 

Variable name:<br />
\_NT\_SYMBOL_PATH 

Variable value:<br />
srv\*c:\symbols\*__http://referencesource.microsoft.com/symbols__\*http://msdl.microsoft.com/download/symbols 

Replace "c:\symbols" with whatever path you want your symbols to be downloaded to. The key here is that the reference source path exists first. Otherwise, the PDBs will be downloaded with the source information stripped. 

The rest of the settings should match what [Shawn Burke shared in his post on the reference source release](http://blogs.msdn.com/sburke/archive/2008/01/16/configuring-visual-studio-to-debug-net-framework-source-code.aspx). 

Hope this helps.

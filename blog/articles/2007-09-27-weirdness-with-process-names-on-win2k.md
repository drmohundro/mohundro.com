
title: "Weirdness with process names on Win2K"
author: David
date: 2007/09/27

One of the banes of my existence (okay, not that bad but fun to say) is supporting Windows 2000 at work. Yes, there are still Win2K machines out there - not many, but enough to make a difference. One problem is that .NET 3.0/3.5 isn't supported on Win2K, so we're limited in what we can do, at least on the client-side. Another problem is just strange issues with the framework. 99% of the stuff we write works great, but there are a few things that don't. 
Here is one that caused mass confusion recently. 
Check out the code for this incredibly simple console application that I wrote: <div style="border-right: rgb(221,221,221) 1px dotted; padding-right: 4px; border-top: rgb(221,221,221) 1px dotted; padding-left: 4px; font-size: small; background: rgb(60,60,60); padding-bottom: 4px; margin: 4px; border-left: rgb(221,221,221) 1px dotted; color: rgb(255,255,255); padding-top: 4px; border-bottom: rgb(221,221,221) 1px dotted; font-family: consolas,'Courier New',courier,monospace">
<span style="color: #fef1a9">Module</span> <span style="color: white">Module1</span><br><br><span style="color: #fef1a9">Sub</span> <span style="color: white">Main</span>()<br><br><span style="color: white">Console</span>.<span style="color: white">WriteLine</span>(<span style="background: #515151; color: lime">"&gt;&gt;Environment.CommandLine = {0}"</span>, <span style="color: white">Environment</span>.<span style="color: white">CommandLine</span>)<br><span style="color: white">Console</span>.<span style="color: white">WriteLine</span>(<span style="background: #515151; color: lime">"&gt;&gt;Environment.GetCommandLineArgs()(0) = {0}"</span>, <span style="color: white">Environment</span>.<span style="color: white">GetCommandLineArgs</span>()(<span style="background: #515151; color: yellow">0</span>))<br><br><span style="color: #fef1a9">Dim</span> <span style="color: white">commandLineFileName</span> <span style="color: #fef1a9">As</span> <span style="color: #fef1a9">String</span> = <span style="color: white">System</span>.<span style="color: white">IO</span>.<span style="color: white">Path</span>.<span style="color: white">GetFileName</span>(<span style="color: white">Environment</span>.<span style="color: white">GetCommandLineArgs</span>()(<span style="background: #515151; color: yellow">0</span>))<br><span style="color: white">Console</span>.<span style="color: white">WriteLine</span>(<span style="background: #515151; color: lime">"&gt;&gt;commandLineFileName = {0}"</span>, <span style="color: white">commandLineFileName</span>)<br><br><span style="color: white">Console</span>.<span style="color: white">WriteLine</span>(<span style="background: #515151; color: lime">"&gt;&gt;ProcessName = {0}"</span>, <span style="color: white">Process</span>.<span style="color: white">GetCurrentProcess</span>.<span style="color: white">ProcessName</span>)<br><br><span style="color: white">Console</span>.<span style="color: white">WriteLine</span>(<span style="background: #515151; color: lime">"Press enter to continue...."</span>)<br><span style="color: white">Console</span>.<span style="color: white">ReadLine</span>()<br><br><span style="color: #fef1a9">End</span> <span style="color: #fef1a9">Sub</span><br><br><span style="color: #fef1a9">End</span> <span style="color: #fef1a9">Module</span><br>
</div> 
What would you expect the output to be? 
Here's what it does on Windows XP:
<pre style="font-size: small; background: rgb(60,60,60); color: rgb(255,255,255); font-family: consolas,'Courier New',courier,monospace">&gt;&gt;Environment.CommandLine = ConsoleApplication1.exe
&gt;&gt;Environment.GetCommandLineArgs()(0) = ConsoleApplication1.exe
&gt;&gt;commandLineFileName = ConsoleApplication1.exe
&gt;&gt;ProcessName = ConsoleApplication1
Press enter to continue.... 
</pre>

On Windows 2000, it does the same thing. Super.

Let's change the name of the executable to ThisIsALongNameForAnExe.exe and run it again.
<pre style="font-size: small; background: rgb(60,60,60); color: rgb(255,255,255); font-family: consolas,'Courier New',courier,monospace">&gt;&gt;Environment.CommandLine = ThisIsALongNameForAnExe.exe
&gt;&gt;Environment.GetCommandLineArgs()(0) = ThisIsALongNameForAnExe.exe
&gt;&gt;commandLineFileName = ThisIsALongNameForAnExe.exe
&gt;&gt;ProcessName = ThisIsALongNameForAnExe
Press enter to continue.... 
</pre>

Once again, Windows 2000 behaves the same way. Great. 


Let's try one more thing. Let's change the name of the executable to This.Is.A.Long.Name.For.An.Exe.exe and run it one last time. 


Windows XP looks like this:
<pre style="font-size: small; background: rgb(60,60,60); color: rgb(255,255,255); font-family: consolas,'Courier New',courier,monospace">&gt;&gt;Environment.CommandLine = This.Is.A.Long.Name.For.An.Exe.exe
&gt;&gt;Environment.GetCommandLineArgs()(0) = This.Is.A.Long.Name.For.An.Exe.exe
&gt;&gt;commandLineFileName = This.Is.A.Long.Name.For.An.Exe.exe
&gt;&gt;ProcessName = This.Is.A.Long.Name.For.An.Exe
Press enter to continue.... 
</pre>

However, Windows 2000 looks like this:
<pre style="font-size: small; background: rgb(60,60,60); color: rgb(255,255,255); font-family: consolas,'Courier New',courier,monospace">&gt;&gt;Environment.CommandLine = This.Is.A.Long.Name.For.An.Exe.exe
&gt;&gt;Environment.GetCommandLineArgs()(0) = This.Is.A.Long.Name.For.An.Exe.exe
&gt;&gt;commandLineFileName = This.Is.A.Long.Name.For.An.Exe.exe
&gt;&gt;ProcessName = This.Is.A.Long
Press enter to continue.... 
</pre>

Can you tell the difference? System.Diagnostics.Process.ProcessName is truncated when running on Win2K. The only thing I can tell is that the periods in the process name throw it off. Granted, hopefully you don't have anything secure relying on the name of your process (cough, rename, cough), but it still came across as very unexpected.

Note - the results can be different depending on how you actually execute the program. The command line and command line arguments are literally what was typed when the program is executed.

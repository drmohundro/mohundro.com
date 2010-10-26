
title: "Quickly get the command line arguments from processes with Powershell"
author: David
date: 2010/02/04

<p>I’m sure I’m the only person in the world who ever wants to know what the command line arguments for running processes is, but in the remote chance that someone else out there might need this some day, here you go.</p> <p>We’ve got a few programs at work that do a lot of interprocess communication (IPC). They initialize the IPC communication in a variety of different ways, but one way is by command line arguments that were passed to them. From a debugging standpoint, it is <em>very</em> useful to be able to determine what the command line arguments were that were passed to the process.</p> <p>The easiest way to get this information is with <a href="http://technet.microsoft.com/en-us/sysinternals/bb896653.aspx">Process Explorer</a>. You can either right click the process and select its properties, or you can add a custom column with the command line. What you’ll get is something like this:</p> <p><a href="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Quicklygetthecommandlineargumentsfrompro_BAE3/image_4.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Quicklygetthecommandlineargumentsfrompro_BAE3/image_thumb_1.png" width="417" height="484"></a> </p> <p>You can see that I passed “haha.txt” into GVim.</p> <p>Sometimes, though, I want that information faster. Why not from Powershell? The System.Diagnostics.Process object doesn’t provide any means (that I’m aware of) to retrieve the command line arguments from an already running process. Yes, there is the StartInfo.Arguments property, but it is only there for letting you pass arguments to a process that you’re going to start. It doesn’t populate that information from a running process.</p> <p>You can get it from WMI, though, using a command like this:</p> <p>Get-WmiObject win32_process -Filter "name like '%vim.exe'"</p> <p>You can grab the command line from it by doing this:</p> <p>Get-WmiObject win32_process -Filter "name like '%vim.exe'" | select commandline</p> <p>So yeah, that works. It sure isn’t quite as easy as typing this, though:</p> <p>ps *vim | select commandline</p> <p>Sure wish I could do that. Sure glad that I can! Powershell has the ability for you to tack on your properties. It isn’t quite monkey patching like in Ruby, but it’s close. Here’s how to do it.</p> <p>You’ll first need a ps1xml file to contain this information. I put mine in ~/Documents/WindowsPowerShell/TypeData/System.Diagnostics.Process.ps1xml. It will look like this:</p><pre class="brush: ps1;">&lt;?xml version="1.0"?&gt;
&lt;Types&gt;
    &lt;Type&gt; 
        &lt;Name&gt;System.Diagnostics.Process&lt;/Name&gt; 
        &lt;Members&gt; 
            &lt;ScriptProperty&gt; 
                &lt;Name&gt;CommandLine&lt;/Name&gt; 
                &lt;GetScriptBlock&gt; 
                    $id = $this.Id
                    $result = Get-WmiObject win32_process -Filter "ProcessId = $id"
                    $result.CommandLine
                &lt;/GetScriptBlock&gt; 
            &lt;/ScriptProperty&gt; 
        &lt;/Members&gt; 
    &lt;/Type&gt;
&lt;/Types&gt;
</pre>
<p>What this does is tell Powershell that, for every System.Diagnostics.Process instance it sees, add a new ScriptProperty to it with the name CommandLine. The GetScriptBlock section defines how to actually retrieve the value for the new property. In there, you just put Powershell code. So, I’m doing almost the same WMI query as before except that I’m searching by ID instead. It’s faster that way.</p>
<p>To inform Powershell about this, just run this:</p>
<p>Update-TypeData ~/Documents/WindowsPowerShell/TypeData/System.Diagnostics.Process.ps1xml</p>
<p>You’ll probably want to put that in your profile so that it runs every time you start Powershell. Here’s a screenshot of it in action:</p>
<p><a href="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Quicklygetthecommandlineargumentsfrompro_BAE3/image_6.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Quicklygetthecommandlineargumentsfrompro_BAE3/image_thumb_2.png" width="644" height="156"></a></p>

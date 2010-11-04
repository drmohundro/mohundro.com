
title: "Quickly get the command line arguments from processes with Powershell"
author: David
date: 2010/02/05
categories: powershell

I'm sure I'm the only person in the world who ever wants to know what the command line arguments for running processes is, but in the remote chance that someone else out there might need this some day, here you go. 

We've got a few programs at work that do a lot of interprocess communication (IPC). They initialize the IPC communication in a variety of different ways, but one way is by command line arguments that were passed to them. From a debugging standpoint, it is *very* useful to be able to determine what the command line arguments were that were passed to the process. 

The easiest way to get this information is with [Process Explorer](http://technet.microsoft.com/en-us/sysinternals/bb896653.aspx). You can either right click the process and select its properties, or you can add a custom column with the command line. What you'll get is something like this: 

![Process Properties](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Quicklygetthecommandlineargumentsfrompro_BAE3/image_4.png)  

You can see that I passed "haha.txt" into GVim. 

Sometimes, though, I want that information faster. Why not from Powershell? The System.Diagnostics.Process object doesn't provide any means (that I'm aware of) to retrieve the command line arguments from an already running process. Yes, there is the StartInfo.Arguments property, but it is only there for letting you pass arguments to a process that you're going to start. It doesn't populate that information from a running process. 

You can get it from WMI, though, using a command like this: 

    Get-WmiObject win32_process -Filter "name like '%vim.exe'" 

You can grab the command line from it by doing this: 

    Get-WmiObject win32_process -Filter "name like '%vim.exe'" | select commandline 

So yeah, that works. It sure isn't quite as easy as typing this, though: 

    ps *vim | select commandline 

Sure wish I could do that. Sure glad that I can! Powershell has the ability for you to tack on your properties. It isn't quite monkey patching like in Ruby, but it's close. Here's how to do it. 

You'll first need a ps1xml file to contain this information. I put mine in ~/Documents/WindowsPowerShell/TypeData/System.Diagnostics.Process.ps1xml. It will look like this:

    <?xml version="1.0"?>
    <Types>
        <Type> 
            <Name>System.Diagnostics.Process</Name> 
            <Members> 
                <ScriptProperty> 
                    <Name>CommandLine</Name> 
                    <GetScriptBlock> 
                        $id = $this.Id
                        $result = Get-WmiObject win32_process -Filter "ProcessId = $id"
                        $result.CommandLine
                    </GetScriptBlock> 
                </ScriptProperty> 
            </Members> 
        </Type>
    </Types>

What this does is tell Powershell that, for every System.Diagnostics.Process instance it sees, add a new ScriptProperty to it with the name CommandLine. The GetScriptBlock section defines how to actually retrieve the value for the new property. In there, you just put Powershell code. So, I'm doing almost the same WMI query as before except that I'm searching by ID instead. It's faster that way.

To inform Powershell about this, just run this:

    Update-TypeData ~/Documents/WindowsPowerShell/TypeData/System.Diagnostics.Process.ps1xml

You'll probably want to put that in your profile so that it runs every time you start Powershell. Here's a screenshot of it in action:

![Command Line Arguments from Get-Process](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/Quicklygetthecommandlineargumentsfrompro_BAE3/image_6.png)


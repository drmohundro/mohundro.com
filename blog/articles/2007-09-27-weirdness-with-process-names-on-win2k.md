
title: "Weirdness with process names on Win2K"
author: David
date: 2007/09/27

One of the banes of my existence (okay, not that bad but fun to say) is supporting Windows 2000 at work. Yes, there are still Win2K machines out there - not many, but enough to make a difference. One problem is that .NET 3.0/3.5 isn't supported on Win2K, so we're limited in what we can do, at least on the client-side. Another problem is just strange issues with the framework. 99% of the stuff we write works great, but there are a few things that don't. 

Here is one that caused mass confusion recently. 

Check out the code for this incredibly simple console application that I wrote:

    Module Module1

      Sub Main()

        Console.WriteLine(">>Environment.CommandLine = {0}", Environment.CommandLine)
        Console.WriteLine(">>Environment.GetCommandLineArgs()(0) = {0}", Environment.GetCommandLineArgs()(0))

        Dim commandLineFileName As String = System.IO.Path.GetFileName(Environment.GetCommandLineArgs()(0))
        Console.WriteLine(">>commandLineFileName = {0}", commandLineFileName)

        Console.WriteLine(">>ProcessName = {0}", Process.GetCurrentProcess.ProcessName)

        Console.WriteLine("Press enter to continue....")
        Console.ReadLine()

      End Sub

    End Module

What would you expect the output to be? 

Here's what it does on Windows XP:

    >>Environment.CommandLine = ConsoleApplication1.exe
    >>Environment.GetCommandLineArgs()(0) = ConsoleApplication1.exe
    >>commandLineFileName = ConsoleApplication1.exe
    >>ProcessName = ConsoleApplication1
    Press enter to continue.... 

On Windows 2000, it does the same thing. Super.

Let's change the name of the executable to ThisIsALongNameForAnExe.exe and run it again.

    >>Environment.CommandLine = ThisIsALongNameForAnExe.exe
    >>Environment.GetCommandLineArgs()(0) = ThisIsALongNameForAnExe.exe
    >>commandLineFileName = ThisIsALongNameForAnExe.exe
    >>ProcessName = ThisIsALongNameForAnExe
    Press enter to continue.... 

Once again, Windows 2000 behaves the same way. Great. 

Let's try one more thing. Let's change the name of the executable to This.Is.A.Long.Name.For.An.Exe.exe and run it one last time. 

Windows XP looks like this:

    >>Environment.CommandLine = This.Is.A.Long.Name.For.An.Exe.exe
    >>Environment.GetCommandLineArgs()(0) = This.Is.A.Long.Name.For.An.Exe.exe
    >>commandLineFileName = This.Is.A.Long.Name.For.An.Exe.exe
    >>ProcessName = This.Is.A.Long.Name.For.An.Exe
    Press enter to continue.... 

However, Windows 2000 looks like this:

    >>Environment.CommandLine = This.Is.A.Long.Name.For.An.Exe.exe
    >>Environment.GetCommandLineArgs()(0) = This.Is.A.Long.Name.For.An.Exe.exe
    >>commandLineFileName = This.Is.A.Long.Name.For.An.Exe.exe
    >>ProcessName = This.Is.A.Long
    Press enter to continue.... 

Can you tell the difference? System.Diagnostics.Process.ProcessName is truncated when running on Win2K. The only thing I can tell is that the periods in the process name throw it off. Granted, hopefully you don't have anything secure relying on the name of your process (cough, rename, cough), but it still came across as very unexpected.

Note - the results can be different depending on how you actually execute the program. The command line and command line arguments are literally what was typed when the program is executed.

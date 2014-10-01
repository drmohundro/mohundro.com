---
title: Digging into the ASP.NET vNext Environment
date: 2014/05/29

__DISCLAIMER__: I'm still digging and learning about the new .NET bits... this blog post is just what I've learned on my own thus far. If I say something incorrect, let me know. I'm just a frozen caveman after all...

So, I've been playing around with ASP.NET vNext... which sounds funny, because I haven't actually written any ASP.NET code yet. It's all been straight console applications so far. I guess it'd be more fair to say that I've been digging into the new [KRuntime](https://github.com/aspnet/kruntime) that ASP.NET vNext will be running on.

If you haven't yet read [Graeme Christie's blog post regarding ASP.NET vNext on OSX and Linux](http://graemechristie.github.io/graemechristie/blog/2014/05/26/asp-dot-net-vnext-on-osx-and-linux/), it'd be good to check it out, even if you're primarily on Windows. Why, you may ask? Because it does a good job of showing off the new KRuntime (including kvm, kpm, etc.). To be honest, while reading the post, one of my first thoughts was that "kpm" was a mistype of "npm" and I was looking at a blog post about [node](http://nodejs.org/) and [node package manager](https://www.npmjs.org/). The new project type is even a JSON format instead of an XML format (again, just like node). It's pretty wild.

I followed Graeme's instructions and ended up getting Mono 3.4.1 set up on my MacBook Pro in OSX. I figured I'd test this new version in a completely new environment. Once that was done, I got kvm set up and created my first Hello World, which you can see below.

![ASP.NET vNext Hello World](https://s3.amazonaws.com/mohundro/blog/2014-05-29-aspnet-vnext-hello-world.png)

With that done, I wanted to dig a little deeper... you know, find out just what assemblies are loaded and so on. I ended up writing the below application to try some things out:

```cs
using System;
using System.Reflection;

class Program {
  public static void Main() {
    DumpEnvironment();
  }

  private static void DumpEnvironment() {
    Console.WriteLine("-- Environment --");
    Console.WriteLine("Environment.OSVersion: {0}", Environment.OSVersion);
    Console.WriteLine("Environment.Version: {0}", Environment.Version);
    Console.WriteLine();

    Console.WriteLine("-- Executing Assembly --");
    Console.WriteLine("Assembly.GetExecutingAssembly():");
    DumpAssembly(Assembly.GetExecutingAssembly());
    Console.WriteLine("-- Entry Assembly --");
    Console.WriteLine("Assembly.GetEntryAssembly()");
    DumpAssembly(Assembly.GetEntryAssembly());

    Console.WriteLine("-- AppDomain Details --");
    Console.WriteLine("AppDomain.CurrentDomain: {0}", AppDomain.CurrentDomain);
    Console.WriteLine("AppDomain.CurrentDomain.GetAssemblies():");

    foreach (var asm in AppDomain.CurrentDomain.GetAssemblies()) {
      DumpAssembly(asm);
    }
  }

  private static void DumpAssembly(Assembly asm) {
    Console.WriteLine("  FullName: {0}", asm.FullName);
    Console.WriteLine("  Location: {0}", asm.Location);
    Console.WriteLine();
  }
}
```

Below is the output from a run of this program (using `k run`).

```no-highlight
-- Environment --
Environment.OSVersion: Unix 13.2.0.0
Environment.Version: 4.0.30319.17020

-- Executing Assembly --
Assembly.GetExecutingAssembly():
  FullName: aspnetvnext, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

-- Entry Assembly --
Assembly.GetEntryAssembly()
  FullName: klr.mono.managed, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location: /Users/mo/.kre/packages/KRE-mono45-x86.0.1-alpha-build-0475/bin/klr.mono.managed.dll

-- AppDomain Details --
AppDomain.CurrentDomain: klr.mono.managed.dll
AppDomain.CurrentDomain.GetAssemblies():
  FullName: mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089
  Location: /usr/local/lib/mono/4.5/mscorlib.dll

  FullName: klr.mono.managed, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location: /Users/mo/.kre/packages/KRE-mono45-x86.0.1-alpha-build-0475/bin/klr.mono.managed.dll

  FullName: System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089
  Location: /usr/local/lib/mono/gac/System/4.0.0.0__b77a5c561934e089/System.dll

  FullName: System.Core, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089
  Location: /usr/local/lib/mono/gac/System.Core/4.0.0.0__b77a5c561934e089/System.Core.dll

  FullName: klr.host, Version=0.1.0.0, Culture=neutral, PublicKeyToken=null
  Location: /Users/mo/.kre/packages/KRE-mono45-x86.0.1-alpha-build-0475/bin/klr.host.dll

  FullName: Microsoft.Framework.Runtime.Infrastructure.CallContextServiceLocator, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Microsoft.Framework.Runtime.Infrastructure.IServiceProviderLocator, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Microsoft.Framework.Runtime.AssemblyNeutralAttribute, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Microsoft.Framework.Runtime.IHost, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Microsoft.Framework.Runtime.IAssemblyLoaderEngine, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Microsoft.Framework.Runtime.IHostContainer, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Microsoft.Framework.Runtime.IApplicationEnvironment, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Microsoft.Framework.ApplicationHost, Version=0.1.0.0, Culture=neutral, PublicKeyToken=null
  Location: /Users/mo/.kre/packages/KRE-mono45-x86.0.1-alpha-build-0475/bin/Microsoft.Framework.ApplicationHost.dll

  FullName: Microsoft.Framework.Runtime, Version=0.1.0.0, Culture=neutral, PublicKeyToken=null
  Location: /Users/mo/.kre/packages/KRE-mono45-x86.0.1-alpha-build-0475/bin/Microsoft.Framework.Runtime.dll

  FullName: Microsoft.Framework.Runtime.IFileMonitor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Microsoft.Framework.Runtime.ISourceFileReference, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Microsoft.Framework.Runtime.ISourceReference, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Microsoft.Framework.Runtime.IMetadataFileReference, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Microsoft.Framework.Runtime.IMetadataReference, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Microsoft.Framework.Runtime.ILibraryManager, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Microsoft.Framework.Runtime.ILibraryInformation, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Microsoft.Framework.Runtime.ILibraryExport, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Microsoft.Framework.Runtime.ILibraryExportProvider, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Microsoft.Framework.Runtime.IApplicationShutdown, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Newtonsoft.Json, Version=4.5.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed
  Location: /Users/mo/.kre/packages/KRE-mono45-x86.0.1-alpha-build-0475/bin/Newtonsoft.Json.dll

  FullName: System.Numerics, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089
  Location: /usr/local/lib/mono/gac/System.Numerics/4.0.0.0__b77a5c561934e089/System.Numerics.dll

  FullName: WindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35
  Location: /usr/local/lib/mono/gac/WindowsBase/4.0.0.0__31bf3856ad364e35/WindowsBase.dll

  FullName: System.IO.Compression, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089
  Location: /usr/local/lib/mono/gac/System.IO.Compression/4.0.0.0__b77a5c561934e089/System.IO.Compression.dll

  FullName: System.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089
  Location: /usr/local/lib/mono/gac/System.Xaml/4.0.0.0__b77a5c561934e089/System.Xaml.dll

  FullName: System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089
  Location: /usr/local/lib/mono/gac/System.Xml/4.0.0.0__b77a5c561934e089/System.Xml.dll

  FullName: Mono.Security, Version=4.0.0.0, Culture=neutral, PublicKeyToken=0738eb9f132ed756
  Location: /usr/local/lib/mono/gac/Mono.Security/4.0.0.0__0738eb9f132ed756/Mono.Security.dll

  FullName: System.Xml.Linq, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089
  Location: /usr/local/lib/mono/gac/System.Xml.Linq/4.0.0.0__b77a5c561934e089/System.Xml.Linq.dll

  FullName: System.Configuration, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a
  Location: /usr/local/lib/mono/gac/System.Configuration/4.0.0.0__b03f5f7f11d50a3a/System.Configuration.dll

  FullName: Microsoft.Framework.Runtime.Roslyn, Version=0.1.0.0, Culture=neutral, PublicKeyToken=null
  Location: /Users/mo/.kre/packages/KRE-mono45-x86.0.1-alpha-build-0475/bin/Microsoft.Framework.Runtime.Roslyn.dll

  FullName: Microsoft.Framework.Runtime.IRoslynMetadataReference, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:

  FullName: Microsoft.CodeAnalysis, Version=41.41.41.41, Culture=neutral, PublicKeyToken=31bf3856ad364e35
  Location: /Users/mo/.kre/packages/KRE-mono45-x86.0.1-alpha-build-0475/bin/Microsoft.CodeAnalysis.dll

  FullName: Microsoft.CodeAnalysis.CSharp, Version=41.41.41.41, Culture=neutral, PublicKeyToken=31bf3856ad364e35
  Location: /Users/mo/.kre/packages/KRE-mono45-x86.0.1-alpha-build-0475/bin/Microsoft.CodeAnalysis.CSharp.dll

  FullName: System.Collections.Immutable, Version=1.1.20.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a
  Location: /Users/mo/.kre/packages/KRE-mono45-x86.0.1-alpha-build-0475/bin/System.Collections.Immutable.dll

  FullName: System.Runtime, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a
  Location: /usr/local/lib/mono/4.5/Facades/System.Runtime.dll

  FullName: System.Resources.ResourceManager, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a
  Location: /usr/local/lib/mono/4.5/Facades/System.Resources.ResourceManager.dll

  FullName: System.Collections, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a
  Location: /usr/local/lib/mono/4.5/Facades/System.Collections.dll

  FullName: System.Linq, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a
  Location: /usr/local/lib/mono/4.5/Facades/System.Linq.dll

  FullName: System.Globalization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a
  Location: /usr/local/lib/mono/4.5/Facades/System.Globalization.dll

  FullName: System.Runtime.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a
  Location: /usr/local/lib/mono/4.5/Facades/System.Runtime.Extensions.dll

  FullName: System.Reflection.Metadata, Version=1.0.11.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a
  Location: /Users/mo/.kre/packages/KRE-mono45-x86.0.1-alpha-build-0475/bin/System.Reflection.Metadata.dll

  FullName: System.IO, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a
  Location: /usr/local/lib/mono/4.5/Facades/System.IO.dll

  FullName: System.Reflection, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a
  Location: /usr/local/lib/mono/4.5/Facades/System.Reflection.dll

  FullName: System.Text.Encoding, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a
  Location: /usr/local/lib/mono/4.5/Facades/System.Text.Encoding.dll

  FullName: System.Threading, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a
  Location: /usr/local/lib/mono/4.5/Facades/System.Threading.dll

  FullName: System.Runtime.InteropServices, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a
  Location: /usr/local/lib/mono/4.5/Facades/System.Runtime.InteropServices.dll

  FullName: System.Reflection.Primitives, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a
  Location: /usr/local/lib/mono/4.5/Facades/System.Reflection.Primitives.dll

  FullName: aspnetvnext, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
  Location:
```

What's interesting to me is to see the wide variety of assemblies loaded along with their locations, especially the ones that have blank locations. [Scott Hanselman's introductory post to ASP.NET vNext](http://www.hanselman.com/blog/IntroducingASPNETVNext.aspx) mentions that "the assemblies never exist on disk...because it's actually faster and easier to have the compiler do all the work in memory." This is all thanks to Roslyn. It's pretty awesome.

I have yet to try this same app out on Windows (not Mono) to see how different the assembly list is. (quick note - assembly loading is defered until the assembly is actually used, so those assemblies weren't actually all in memory then) Obviously some of the mono assemblies won't be on a Windows run, but there are a lot of new Microsoft ones - just take a look at all of the ones that have ".kre" in their path. I count 10 in my run.

Here are some of the questions I've got given this first run.

1. Is KRuntime just a new host for the application or is it replacing the CLR as the runtime?
2. Given the answer to the first question, there could be implications for non-ASP.NET apps. If it is just a host, then it could be seen as a smarter w3wp (IIS worker process) running on top of the CLR with a smaller subset of assemblies. If it replaces the CLR, then it really is changing *everything*.
3. There is already work to get Microsoft Update to support Nuget packages... will we see .NET Framework security patches coming in via Nuget even more often?

To be honest, I've got a lot more questions, but I'm still trying to put them into words. I'm very excited with what I'm seeing, though.

Let me know if you have any corrections, insights, or questions.

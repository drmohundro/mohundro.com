
title: "Extending MSBuild with custom tasks"
author: David
date: 2006/04/10

MSBuild is a great tool. If you're not familiar with it, it is Microsoft's new build engine which was released with .NET 2.0. Visual Studio 2005 uses it behind the scenes. If you'd like to see it in action, pull up a VS2005 Command Prompt and type "msbuild YourSolution.sln" and watch the magic. It provides a much faster way of recompiling solutions and projects than reopening Visual Studio.

MSBuild runs off XML files. If you'd like to see one, just open up one of your vbproj or csproj files. Visual Studio projects default to the MSBuild format. Unfortunately, the solution files still aren't in an XML format. Because it uses XML, you can extend a build to do any number of tasks. I'll walk you through a very simple example.

My task is a Replace task that simple takes an input string (likely a file path or assembly name), an old value, and a new value and returns a value with all old values replaced with new values. It works exactly like the Replace method off of String objects.

First off, create a new Class Library project in Visual Studio. You'll need to add a reference to Microsoft.Build.Framework and to Microsoft.Build.Utilities. Next, for your class, inherit from Microsoft.Build.Utilities.Task. You'll be forced to override an Execute method. That's really all it takes to get a custom task. Everything else is driven off of public properties that are described by specific MSBuild attributes like "Required" or "Output".

Here's the source for my Replace task:

    using Microsoft.Build.Framework;
    using Microsoft.Build.Utilities;

    using System;
    using System.Collections.Generic;
    using System.Text;

    namespace Tasks
    {
      /// <summary>
      /// Custom MSBuild task to perform String replacement. Primarily used for
      /// Namespace to directory replacement (DTC.NRA.App -> DTC\NRA\App).
      /// </summary>
      public class Replace : Task
      {
        string _input;
        [Required]
        public string Input
        {
          get { return _input; }
          set { _input = value; }
        }

        string _oldValue;
        [Required]
        public string OldValue
        {
          get { return _oldValue; }
          set { _oldValue = value; }
        }

        string _newValue;
        [Required]
        public string NewValue
        {
          get { return _newValue; }
          set { _newValue = value; }
        }

        string _results;
        [Output]
        public string Results
        {
          get { return _results; }
          set { _results = value; }
        }

        public override bool Execute()
        {
          bool success = true;
          try
          {
            Results = Input.Replace(OldValue, NewValue);
          }
          catch (Exception e)
          {
            Log.LogErrorFromException(e);
          }
          return success;
        }
      }
    }

The XML below is how I'm currently using this task.

    <UsingTask TaskName="Tasks.Replace" AssemblyFile="C:\Development\References\MSBuildTasks.dll" />
    <PropertyGroup>
    <RootDirectory>C:\Development\Build\</RootDirectory>
    </PropertyGroup>
    <Target Name="AfterBuild">
    <Replace Input="$(RootNamespace)" OldValue="." NewValue="\">
    <Output TaskParameter="Results" PropertyName="NamespaceDirectories" />
    </Replace>
    <CreateItem Include="$(OutputPath)\**\*.*">
    <Output TaskParameter="Include" ItemName="FilesToArchive" />
    </CreateItem>
    <Copy SourceFiles="@(FilesToArchive)" DestinationFolder="$(RootDirectory)$(NamespaceDirectories)\%(FilesToArchive.RecursiveDir)" />
    </Target>

As you can see, I've got the UsingTask which references the assembly I built. Then you can use the Replace task like any other provided task. The above exactly can be copied into a Visual Studio project and it will copy the output files from your build into the RootDirectory you specify with the root namespace making up the folders beneath it (i.e. give the namespace System.Windows.Forms, this will copy your compiled assemblies to c:\Development\Build\System\Windows\Forms\*).

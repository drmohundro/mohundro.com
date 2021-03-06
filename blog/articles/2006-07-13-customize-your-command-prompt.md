
title: "Customize your command prompt!"
author: David
date: 2006/07/13
categories: .net;powershell;utilities
guid: 0e6ee3d7-bb6c-4061-8134-c6cc82cc729b

Yesterday, I [downloaded the Developer Productivity Tools video](http://www.wrox.com/WileyCDA/Section/id-292091.html) from the [Wrox](http://www.wrox.com/) website that [Scott Hanselman](http://www.hanselman.com/blog) did for [one of his presentations with a user group](http://www.hanselman.com/blog/ScottHanselmanDeveloperProductivityToolsVideoPart1.aspx). He had a lot of great resources in the video but the command prompt tips he had were new to me. I've done some work with the console, but I've only recently been using it more, particularly with PowerShell coming along. 

Scott's tip about customizing your prompt (from c:\dir\&gt; to whatever) was really cool ([also posted here](http://www.hanselman.com/blog/PromptsAlongWithPushDAndPopD.aspx)). I knew that the prompt could be customized, but at the time I saw someone do it, I didn't have a good grasp of environment variables so it didn't really make sense what was going on, but Scott's video and his post have helped out a lot. They also prompted me to want to do the same with my PowerShell prompt!

The PROMPT environment variable trick doesn't work for the PowerShell prompt, but after a little digging around with Google, I discovered [this post from Lee Holmes](http://www.leeholmes.com/blog/GettingStartedCustomizeYourPrompt.aspx) about the prompt function. If you have a function named prompt declared, PowerShell will use the value returned by that function to alter the display of your prompt. Here's my prompt function, which I have saved in PowerShell profile so that it will load every time (mine is located here C:\Documents and Settings\David\My Documents\PSConfiguration\Microsoft.PowerShell_profile.ps1)

    # Initialize custom prompt
    function prompt
    {
      "PS " + (get-location).Path + [System.Environment]::NewLine + ">".PadLeft((get-location -stack).Count + 1, "+")
    }

The only thing I haven't figured out yet is how to get a visual indication of how far in the stack you are (by using pushd and popd). Once I figure that out, I'll have a PowerShell prompt customized just like my cmd prompt!

**UPDATE:** I did some more research and discovered get-location -stack which will return everything on the pushd/popd stack. I've updated my prompt function accordingly. Now it matches my cmd prompt in every way!</font>


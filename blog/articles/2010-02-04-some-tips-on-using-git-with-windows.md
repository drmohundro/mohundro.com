
title: "Some tips on using git with Windows"
author: David
date: 2010/02/04
categories: utilities
guid: 30d2af92-322a-4efe-89d1-07d824eac432

The .NET open source community has really started to embrace [git](http://www.git-scm.com/) in the past few months. [Ayende](http://github.com/ayende) has moved pretty much all of his open source work over to [github](http://github.com/), [Fluent NHibernate is there](http://github.com/jagregory/fluent-nhibernate), [FubuMVC is there](http://github.com/DarthFubuMVC/fubumvc), the list just goes on. If you haven't had a chance to delve into git (or other [distributed SCM](http://en.wikipedia.org/wiki/Distributed_revision_control) tools like mercurial), you should definitely check one of them out. 

If you're like most .NET developers, chances are quite high that you're developing on Windows. In case you're unaware, git was originally written to manage the Linux source code. What this means is that it has a very different philosophy than your standard Windows application. For one, it is primarily used from the command line. And yes, I realize that a plethora of various GUI tools for git exist. The only one I personally use is gitk, though, and only then to get a high level view of the repository. The rest of the time, I use it entirely from the command line (Powershell actually). I wanted to share some tips on using git in Windows and making the experience better. (note that this isn't a "git tutorial," it's a "setting git up on Windows tutorial.") 

#### Install MSysgit

First off, you have two options for running git in Windows - [msysgit](http://code.google.com/p/msysgit/) or [cygwin](http://www.cygwin.com/). I've used both, but I currently prefer using msysgit, mainly because when I'm on Windows, I want to use Powershell. Most posts you'll read from Windows users using git actually use Git Bash that ships with msysgit, though. I've used this option as well, but as I said, I like my Powershell. If you want to use git from any command prompt (including cmd, git bash, or powershell), you'll want to choose the option to add the git directory to your path when you install msysgit. (you might have to restart before the PATH changes are effective) 

After the install, you can verify things are set up correctly by pulling up powershell and typing get-command git. If everything was installed correctly, you should see something like this: 

![Get-Command git](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/SometipsonusinggitwithWindows_BECE/image_2.png)

You can now type "git --version" to verify that the install worked. Mine outputs "git version 1.6.5.1.msysgit.1". 

#### Use Console2

The next step is one of the most important ones in my opinion. Don't use the default cmd.exe. Use a better one. I recommend [Console2](http://sourceforge.net/projects/console/). It's a tabbed console host for windows. You can use it to host the standard cmd prompt, powershell, cygwin, git bash, etc. It has *much* better font and color support, too. None of this [adding fonts to the registry so that cmd.exe can use Consolas mess](http://www.google.com/search?q=cmd.exe%20consolas). Here's what mine looks like: 

![Console2](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/SometipsonusinggitwithWindows_BECE/image_4.png)

I've customized my colors so that the black is more of a dark gray and some of the other colors aren't quite as bold. I've changed my font to Consolas, I've got the menu, toolbar and status bar hidden, I have copy on cursor select checked, and more. Some people don't care about aesthetics when coding or using the command prompt, but I do.

#### Enable color with git

Speaking of aesthetics, I cringe every time I see someone run git status and see no color. I don't think I knew how big of a difference existed until I ran git on an Ubuntu VM where color support is enabled out of the box. Here, I'll just show you a couple screenshots for comparison. 

Without color...
 
![Without color](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/SometipsonusinggitwithWindows_BECE/image_8.png)  

With color! 

![With color!](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/SometipsonusinggitwithWindows_BECE/image_10.png)  

Now, if you've used git, you may be aware of the git config option (or see ~/.gitconfig) to turn color on. I actually have mine set to auto. This means that git tries to determine, based on your terminal, if it thinks you can handle color or not. It doesn't think Windows can handle color very well, so auto on Windows means no color. So, if I'm not using the global color option, what am I doing to tell git to use color anyway? I'm using an environment variable tweak that I learned about via one of the msysgit issues (see [http://code.google.com/p/msysgit/issues/detail?id=326&q=color&colspec=ID%20Type%20Status%20Priority%20Component%20Owner%20Summary#c5](http://code.google.com/p/msysgit/issues/detail?id=326&q=color&colspec=ID%20Type%20Status%20Priority%20Component%20Owner%20Summary#c5)). Here's the line from my powershell profile:

    $env:TERM = 'cygwin'
    $env:LESS = 'FRSX'

This line basically lies about the running terminal - "hi git, my terminal isn't actually powershell or cmd.exe or console2, it's actually cygwin." The second line provides arguments to less (the default git pager) on how to render its output. 

Here's how this changes things...

Before: 

![Before the ENV variables](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/SometipsonusinggitwithWindows_BECE/image_16.png)

After! 

![After the ENV variables](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/SometipsonusinggitwithWindows_BECE/image_18.png)

It's pretty clear now what's changed.

#### What's could still improve?

The only thing I'm currently missing from git when using it via Powershell now is the tab completion. Git provides a bash_completion script so that you can tab complete all of the various commands, the branch names when switching between branches, the various file names when adding or removing, etc. I've started to create my own version of tab completion when using Powershell by tweaking PowerTab (Gaurav Sharma started the initial research to do this... check out his post at [http://techblogging.wordpress.com/2008/10/13/context-sensitive-auto-completion-using-powershell-powertab-and-git/](http://techblogging.wordpress.com/2008/10/13/context-sensitive-auto-completion-using-powershell-powertab-and-git/)) but it isn't yet nearly as powerful as what the bash_completion script provides when using a bash terminal. I'm hopeful that future versions of Powershell will provide a better (easier?) way to hook tab completion up, particularly for utilities that aren't Powershell-aware. The TabExpansion function is a little too global for my taste - unless I'm missing something, if you want to add to the tab completion functionality that already exists, you pretty much have to re-implement all of the tab completion functionality. 
 
That's pretty much it. Don't be afraid of the command line and don't be afraid of command line tools. 

**EDIT:** added the $env:LESS setting - just setting TERM doesn't seem to work in all cases.


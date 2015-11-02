---
title: Finding Text in Files Revisited
date: 2014/10/04

If your career is anything like mine, you've dealt with a wide array of various code bases across multiple technologies. Some web, some client, etc. With varying technologies, the tools change, the languages change, everything changes.

A few things have remained relatively constant, though, such as a command line.

And war... war never changes... (that's a [Fallout reference](http://fallout.wikia.com/wiki/Fallout_intro)!)

![War Never Changes](https://s3.amazonaws.com/mohundro/blog/2014-10-04-fallout.gif)

But I digress.

Given my love of all things command line, I still greatly prefer searching over the wide variety of code bases I've worked with from the terminal. I've blogged about this before and have even written a PowerShell script to help with this. Today, there are so many options available for text searching that I thought I'd share an updated list to help you decide how best to find text in your source code.

My test case will be simple... recursively search for the term "jQuery" across the current directory, optionally specifying the files to search in. Also, ideally show 3 lines of context after the match if possible.

## The Old Standards

First off, I want to share the tools of the trade that have existed for years... decades even.

### grep (cross platform)

[Grep](http://en.wikipedia.org/wiki/Grep) is the go to tool here. It's been around since at least the early 70s.

Often, you'll see `grep` used in conjuction with other tools, like `ps` to search for specific processes or other command line tools. By default, it just returns any lines that match the search term from stdin.

```bash
# use in conjunction with the find command
find "directory" -name "*.js" | xargs grep "jQuery"

# or more succinctly without find usage
# options:
#   -r        = recursive
#   -n        = line numbers
#   -w        = match whole word
#   --include = to specify files to search (like *.js)
#   -e        = search term
#   -A        = context lines to show (after match)
#   -B        = context lines to show (before match)
#   -C        = context lines to show (before and after match)
grep -rnw "directory" --include "*.js" -e "jQuery" -A 3

# look in current directory for jQuery across all files
grep -rnw . -e jQuery -A 3
```

To install `grep`, you either have it installed already because you're on a *nix platform or you can install it via [Grep for Windows](http://gnuwin32.sourceforge.net/packages/grep.htm).

### findstr (Windows)

Windows doesn't come with `grep` installed by default, but it does come with [findstr](http://technet.microsoft.com/en-us/library/cc732459.aspx).

In my humble opinion, while it can get the job done, you're much better off using one of the many other options out there. I don't believe it has any options to show context lines in its results.

Usage:

```dos
REM some relevant options:
REM   /p = skip files with non-printable characters
REM   /s = recursive searc
REM   /c = search term
findstr /p /s /c:"jQuery" *.js
```

No installation instructions - you're either on Windows and have it or you're not and don't need it.

## Replacing grep

In the last 10 years or so, there have been a few stand out tools that have attempted to dethrone grep from its top spot of text searching, at least in terms of searching for code.

### ack (cross platform)

`ack` is a perl script that whose original URL was actually "betterthangrep.com" - now it lives at [beyondgrep.com](http://beyondgrep.com/). Given the original URL, you can probably guess how it is positioned - it is "a tool like grep, optimized for programmers." One of the key things for it is that it was built specifically for searching over source code. Grep doesn't know to ignore VCS directories like ".git" or ".svn". You often have to specify quite a few options to get to what you need.

Usage:

```bash
# relevant options:
#   --smart-case   = if set, ignores case unless the search term contains any upper case
#   -A             = context lines to show (after match)
#   -B             = context lines to show (before match)
#   -C             = context lines to show (before and after match)
#
# see also --help-types to see which file type groups ack supports
#   like --js, --csharp, --ruby, etc.

ack --js jQuery -A 3
```

To install, I'd recommend one of the following:

* Windows?
	* Install [Chocolatey](http://chocolatey.org/)
	* Run `choco install ack`
* OSX?
	* Install [homebrew](http://brew.sh/)
	* Run `brew install ack`
* Linux?
	* See [list of packages](http://beyondgrep.com/install/)

### Find-String (Windows)

PowerShell was released in 2006. It shipped with a cmdlet called `Select-String` that provided grep-like functionality; however, it didn't support context matches until version 2. Multiple people built their own versions of wrappers around Select-String to make it more usable... I'm of course partial to my own [Find-String](https://github.com/drmohundro/find-string) project.

`ack` existed when I wrote `Find-String`, but it didn't perform as well for me at the time as using PowerShell (May 2009). Today, I'd guess `ack` and `Find-String` are fairly comparable in terms of performance.

Usage:

```powershell
# relevant options:
#   -context   = [x,y] where x is number of lines before and y is number of lines after
Find-String jQuery *.js -context 0,3
```

To install, I'd first install [PsGet](http://psget.net/) and then you can just run `Install-Module Find-String`.

## The New Players

In the last few years, there has been renewed interest in tools like `grep` and `ack`, but with speed as a big focus.

### The Silver Searcher (ag) (cross platform)

In 2011, the Silver Searcher (`ag`) was released. To my understanding, it was the first code search tool since `grep` that was written in C. As a result, it performed faster than *any* of the competition. In the Linux and OSX communities, it was quickly gaining ground over tools like `ack`. In Windows, however, it was far too difficult for most people to get to compile in Windows. I used it when I was working in OSX, but I stuck with `Find-String` when I worked in Windows. However, recently I discovered pre-built binaries of ag for Windows that work great and out-perform `Find-String` by quite a bit.

```bash
# relevant options:
#   --smart-case   = if set, ignores case unless the search term contains any upper case
#   -A             = context lines to show (after match)
#   -B             = context lines to show (before match)
#   -C             = context lines to show (before and after match)
#   -G             = only search files that match regex
ag jQuery -G "\.js$" -A 3

# or if you want to search all files... it is fast enough it likely won't matter!
ag jQuery -A 3
```

To install, I'd recommend one of the following:

* Windows?
	* Check out [Krzysztof Kowalczyk's pre-built binaries](http://blog.kowalczyk.info/software/the-silver-searcher-for-windows.html)
* OSX?
	* Install [homebrew](http://brew.sh/)
	* Run `brew install the_silver_searcher`
* Linux?
	* See [main project for details](https://github.com/ggreer/the_silver_searcher)

### The Platinum Searcher (pt) (cross platform)

The final one I'd like to share is the Platinum Searcher (`pt`). It is *very* new, only having been released in early 2014. It is unique in that it is the only one written in [Go](https://golang.org/). Go is nice in that it has the performance characteristics of C while also being cross platform. Per the project site, it can search just as fast as `ag`.

You may notice that the command line options are almost identical to `ag`, which is nice.

```bash
# relevant options:
#   --smart-case   = if set, ignores case unless the search term contains any upper case
#   -A             = context lines to show (after match)
#   -B             = context lines to show (before match)
#   -C             = context lines to show (before and after match)
#   -G             = only search files that match regex
pt jQuery -G "\.js$" -A 3

# or if you want to search all files... it is fast enough it likely won't matter!
pt jQuery -A 3
```

To install, you can just grab one of the [pre-built releases](https://github.com/monochromegane/the_platinum_searcher/releases) or run `brew install pt` on OSX.

## What do I recommend?

Today, you have a lot of options with which to search... I'm not even going to try to mention all of the options you have if you include GUI tools! I do have my favorites, though.

You might think I'd stick with `Find-String` given that I wrote it, but you'd be mistaken. I definitely keep it around, but my go to at the moment is `pt`. Thus far, it is the fastest tool I've found at searching and it works across every OS I use. I still fall back to `Find-String` in some cases, because I like having PowerShell and objects in the pipeline, but for straight digging through code, `pt` wins hands down.

If you spot any inaccuracies or have other thoughts, let me know!

![Enjoy Your Stay!](https://s3.amazonaws.com/mohundro/blog/2014-10-04-fallout-enjoy-your-stay.gif)

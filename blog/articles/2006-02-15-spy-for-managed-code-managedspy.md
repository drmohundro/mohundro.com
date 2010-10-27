
title: "Spy++ for Managed Code: ManagedSpy!"
author: David
date: 2006/02/15

Benjamin Wulfe wrote [an article for the April issue of MSDN magazine](http://msdn.microsoft.com/msdnmag/issues/06/04/ManagedSpy/default.aspx) about a utility called ManagedSpy, which is basically the managed version of Spy++. If you're unfamiliar with Spy++, it will let you look at running Windows processes and see messages, classes, and other WinAPI-related information. As the article notes, from a managed Windows Forms perspective, that isn't exactly where we typically work. ManagedSpy uses a TreeView and a Properties window to display controls and layout in a managed form. It can also listen and log events raised from the form and its controls.

One of the particularly interesting things to me is the ControlProxy, which is exposed from a managed C++ library called ManagedSpyLib. There is discussion about how to use Windows hooks to get to other windows currently running and even a section on using ManagedSpyLib for unit testing, because it has the ability to send Windows messages to other processes.

Check it out!

(via [jfo's coding](http://blogs.msdn.com/jfoscoding/archive/2006/02/15/532839.aspx))

**UPDATE:** As an aside, be careful with this tool. I tried running it while [RssBandit](http://www.rssbandit.org/) was running (which is a managed Windows application... and it blew up. Hard. As in, let's take them BOTH down. Luckily, it does come with code, so you can have fun with it. After all, I would like to learn some Managed C++ :).

--- 
title: //BUILD/ Windows Conference
date: 2011/10/14

So, a few weeks ago I was able to attend the BUILD Windows conference in
Anaheim. I'm guessing you heard something about it. The last time Microsoft
held a conference at the convention center in Anaheim was when it announced
Windows 95 \- this conference was an attempt to show that Windows was going to
revolutionize things again. I've got a lot of thoughts that I want to talk
about, so I'll probably have to break this into multiple posts.

## The conference itself...

Because I have lots to talk about, I am going to go into more detail about
various topics. This post is just going to be a general conference overview
about some of the various sessions I attended. I'm planning on digging into
more detail about more specifics like what I think about the Win8 tablet and
more. If you're interested in watching any of the sessions, the full list is
at the [buildwindows.com site](http://www.buildwindows.com/Sessions/Schedule).

So, the conference...

## Preconference...? Nerd Dinner!!!

If you attended the conference or at least visited the BUILD site, you likely
saw that there was a preconference slot on the calendar. So, my group all got
flights for Sunday so that we would be there for the preconference sessions...
which were all canceled. So, we just walked around Anaheim all day Monday. It
was a little annoying given that it would have cost a lot of money to change
travel plans and all that, but it turned out alright. We spent most of the day
coding and discussing future development options. We had planned on attempting
to build a Windows Phone 7 application, but it took forever to actually get the
Windows Phone 7 SDK installed. Oh well. We did end up walking around the area
and into Downtown Disney and, later that night, a group of people all went to
the Cheesecake factory for a [nerddinner](http://www.nerddinner.com/5027).
You'll note that while only 2 people RSVP'd on the site, at least 15-20 people
showed up!

## Keynotes galore...

So, the conference actually began on Tuesday. Because the entire event was
shrouded in secrecy (even though everyone knew that there would be Win8
tablets being handed out). To give you an idea of the amount of secrecy, the
session lists pretty much just said "Sessions: 8 to 5" for the entire week.
There was no session planning until after the first keynote. And even then,
the entire first day was just one keynote after another. Even on Wednesday,
the morning was full of keynotes! Thankfully, the keynotes were pretty good...
far better than the keynotes that I saw at TechEd a few years back.

So, [the Windows 8 tablet
reveal](http://channel9.msdn.com/events/BUILD/BUILD2011/KEY-0001). I'll admit,
it at least demos *really* well. I don't think it is stretching anything to
say that people were excited. There were a few people who currently have iPads
that were showing a lot of interest in the Windows 8 tablet. Something
interesting for me was that, at least for the first day, the attendees were
not the primary audience. The BUILD conference keynotes for day 1 really
served as marketing for consumers and tech enthusiasts. My take is that this
is Microsoft trying to take back some of the consumer appeal that Apple has
been able to win over the last few years.

I'll put up a separate post about my actual hands-on experience with the
tablets that they've gave the attendees, but from the perspective of just
watching the keynotes, I was impressed. The promise of being able to dock your
tablet, use it as a real PC and then take it with you as a tablet is quite
nice.

[Jensen Harris did give a keynote presentation on the traits of a great Metro
style application](http://channel9.msdn.com/events/BUILD/BUILD2011/BPS-1004)
that was good. My take on the presentation is that it was more of a demo on how
to actually *use* Windows 8 from a usability perspective. I believe that is
where the term "Charms" showed up, which is just an awful name in my opinion.
I'm all for getting away from the really technical names for things (think
Control Panel, System Tray, etc.), but *Charms*? How many Lucky Charms jokes
are we going to hear? Also, I do have some concerns about the usability of
parts of Windows 8. For example, the app bar can only be shown if you swipe
from the top or bottom. If you're aware of the functionality, then it makes
sense I guess, but if you were to just walk up to one of these devices in a
store, would you know to do that? At least with all of the iDevices out there,
the primary functionality for applications is almost all visible. Sure, there
are often gestures like holding down on icons to move or delete applications,
but this isn't a *common action* for users. In Metro Internet Explorer,
browsing *is a common action*, but you have to pull up the app bar to type in a
new address.  I'm planning on a separate post for Windows 8, so I better stop
:-)

The other two presentations of the day were [Platform for Metro style
apps](http://channel9.msdn.com/events/BUILD/BUILD2011/BPS-1005) and [Tools for
building Metro style
apps](http://channel9.msdn.com/events/BUILD/BUILD2011/BPS-1006). I enjoyed
both of these sessions quite a bit, because they got a little more technical.
We were seeing a lot of this for the first time, so it was nice to begin to
get an idea of what building applications for this platform was going to be
like.

We actually didn't get to pick up our tablets until the end of the day, so
every session after the morning keynote made some mention of them standing
between us and our tablets. Oh, and viva la COM I guess. I'll talk more about
that in a little bit.

## Sessions... and some more keynotes...

Wednesday morning was [all keynote presentations
again](http://channel9.msdn.com/events/BUILD/BUILD2011/KEY-0002), though it
was more of a stream of shorter presentations. We got to see Visual Studio 11,
ScottGu finally came on stage and we saw a lot more about the developer side
of Windows 8. It was more appropriate for developers than the first day was. I
thought that Steve Ballmer's closing words went over well - he even gave an
homage to his famous "Developers, developers, developers" thing from a few
years back.

With the morning keynote over, the afternoon finally began the traditional
sessions. In the interest of actually getting my post uploaded, I've decided
to only share my thoughts on the really interesting sessions that I attended.
Obviously check out the [full session list
online](http://www.buildwindows.com/Sessions/Schedule), because there were a
ton of WinRT sessions that will be valuable to you if you're interested in
building Metro applications.

  * [Windows Server 8](http://channel9.msdn.com/events/BUILD/BUILD2011/SAC-973F)
    * This was a good session because it was really sort of a good overview of
      everything coming in Server 8. There were parts on Hyper-V enhancements,
      new PowerShell features and more. It wasn't a groundbreaking session by
      any means, but given that I do spend quite a bit of time working on
      Server 2008, I figured it would be good to learn more. Feel free to skip
      this one if you only deal with client-side applications, though.

  * [Future directions for C# and Visual
    Basic](http://channel9.msdn.com/events/BUILD/BUILD2011/TOOL-816T)
    * Ander's presentation was likely one of my favorite of the entire week.
      Obviously, he spent a lot of time talking about the new async features
      in C# - that wasn't particularly exciting, because we've at least seen
      that with preview builds for a while now. In fact, [Eric Lippert did a
      great series on the new async features that began almost a year
      ago](http://blogs.msdn.com/b/ericlippert/archive/2010/10/28/asynchrony-in-c-5-part-one.aspx).
      The really exciting announcement from my perspective was Roslyn,
      otherwise known as "Compiler as a Service" for C#. There has been talk
      about having the C# compiler as a service *forever* so it is nice to
      finally have this. The Visual Studio support for it seemed great. At the
      time of this writing, it doesn't appear that the Roslyn CTP has released
      yet, but I imagine it will soon. I did want to point out that [the Mono
      team got the C# Compiler as a Service working
      first](http://www.mono-project.com/CsharpRepl)!

  * [What's new in .NET Framework 4.5](http://channel9.msdn.com/events/BUILD/BUILD2011/TOOL-834T)
    * As a .NET developer, this talk was obviously of interest to me. The 4.5
      version the .NET Framework will be an inplace upgrade, which means it
      will be an upgrade to the current CLR version as opposed to a
      side-by-side release like .NET 4.0 is to .NET 2.0. So, thus far, still 3
      major versions of the CLR (1.1, 2.0 and 4.0 - remember that 3.0 and 3.5
      just run on top of 2.0... yay for confusing version numbers). If you're
      doing any development in .NET, you'll probably be interested in this
      session.

  * [Windows Runtime internals: understanding "Hello World"](http://channel9.msdn.com/events/BUILD/BUILD2011/PLAT-875T)
    * The WinRT internals session is the only one that possibly rivaled
      Ander's session in my mind. It is also the session that showed that COM
      is still alive and well! Okay, maybe not COM, but some iteration of COM.
      I would say that Metro apps are closer to COM than .NET is. This session
      digs into the hosting model for Metro apps, the registry lookup that
      occurs for WinRT types, and more. I'm sure there are some developers out
      there that are quite annoyed that COM is still alive and well, but the
      thing is, this stuff has *always been there*. Welcome to Windows. .NET
      is built on COM. .NET objects all have a GUID... just like COM objects.
      I'm actually a big fan of how the WinRT types are exposed as .NET
      metadata (winmd files). You can actually open them in ILDASM. [Miguel de
      Icaza has a really good post that goes into WinRT as well that I'd
      recommend you check
      out.](http://tirania.org/blog/archive/2011/Sep-15.html). If you're
      interested in getting even *more* deep into how WinRT works, though,
      check out Ian Griffiths' posts on WinRT (see [Real Native WinRT
      Development](http://www.interact-sw.co.uk/iangblog/2011/09/16/real-native-winrt)
      and [Native WinRT
      Inheritance](http://www.interact-sw.co.uk/iangblog/2011/09/25/native-winrt-inheritance)).

## Thoughts on the tablet or Windows 8?

So, enough about the conference, though... *how's the tablet*? It's hard to
say. The most important thing to remember about Windows 8 is that it is a
developer preview - __NOT__ a beta. Betas are occasionally buggy. Developer
previews are... more than occasionally buggy. I let my wife try out the
tablet and she was so annoyed that she stopped using it. My favorite
application so far is OneNote, simply because I'm finally getting to try a
stylus and see how the Ink support is... and that has nothing at all to do
with Windows 8. It's almost too early to say. There aren't any really
substantial applications yet. I think Microsoft really needs to build some
real applications in Metro before most people will be sold.

I'm planning another post at some point to talk about Windows 8 and Metro in
more detail, but I'm still trying to gather my thoughts together. Have you had
a chance to use Windows 8 yet? Any thoughts?

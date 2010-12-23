
title: "Another year, another devLink (part 3)"
author: David
date: 2009/08/26
categories: conferences
guid: e9661fd6-c7f8-48fd-bd49-8e703001d8d1

So, it didn't occur to me until today that I was creating a trilogy here.

If I had thought about it ahead of time, I would've given my titles more
creative names like
["devLink"](/blog/2009/08/24/another-year-another-devlink-part-1/), ["devLink
Strikes Back"](/blog/2009/08/25/another-year-another-devlink-part-2/) and "the
Return of devLink." The true test will be to see if the second post is
everyone's favorite. 

![Obligatory Ewoks for the 3rd movie... errr post.](https://s3.amazonaws.com/mohundro/blog/WindowsLiveWriter/AnotheryearanotherdevLinkpart3_BC80/image_3.png)

Oh well. Maybe next year. 

## Managed Rootkits

The first session I went to on Saturday was an Open Spaces session on Managed
Rootkits convened by [Bill Sempf](http://www.sempf.net/). 

Before I continue, read that sentence again. Didn't see it yet? Here's a hint:
*Managed* Rootkits. You know, managed... as in managed langauges... like .NET.
Get your attention yet? It did mine, which is why I showed up! Of course, I
expected to be completely lost because, in my mind,
[rootkits](http://en.wikipedia.org/wiki/Rootkit) are hard stuff that take a
[computer genius to find and
fix](http://blogs.technet.com/markrussinovich/archive/2005/10/31/sony-rootkits-and-digital-rights-management-gone-too-far.aspx).
Surprisingly though, the concept behind managed rootkits is easy. 

But first, some background. [Bill had attended
Defcon](http://www.sempf.net/post/Defcon-Recap.aspx) which is where he had
originally heard about managed rootkits in the first place (note that his post
[links to a page that includes a
demonstration](http://www.applicationsecurity.co.il/english/NETFrameworkRootkits/tabid/161/Default.aspx)).
That's how the entire session came to be. 

So, wanna know how to hack the framework? 

First, take mscorlib. (that's the primary .NET assembly by the way) 

Next, take
[ildasm](http://msdn.microsoft.com/en-us/library/f7dy01k1%28VS.80%29.aspx).
(that's the MSIL Disassembler - the built-in
[Reflector](http://www.red-gate.com/products/reflector/) if you will) 

Disassemble mscorlib into IL. 

Write your own IL and paste it in the IL you got from disassembling mscorlib. 

Find [ilasm](http://msdn.microsoft.com/en-us/library/496e4ekx%28VS.80%29.aspx)
on your machine. (you guessed it, that's the .NET Assembler) 

Assemble your modified IL into a new mscorlib. 

Drop it in the GAC. 

You L33T hacker you. 

The entire reason this works is because, once an assembly has been installed
into the GAC, the framework doesn't run additional checks to verify that the
assembly matches the hash in its strong name. So yeah, strong naming doesn't
protect assemblies. 

Once we were all up to speed on the logistics, we discussed if this was, in
fact, a [zero day exploit](http://en.wikipedia.org/wiki/Zero_day_attack). It's
not. Why? Because you still have to have administrative privileges to modify
any files in the GAC. As Raymond Chen points out, ["if you have full trust,
then you can do
anything."](http://blogs.msdn.com/oldnewthing/archive/2009/01/21/9353310.aspx) 

Anyway, it was a *very* interesting conversation. I made the point that, even
if it isn't a security vulnerability, there is the whole user perception issue.
For example, if an assembly that your application uses is modified so that it
posts your credit card information out on the internet, network trace tools are
going to show that it is *your* application that is connecting to the internet.
If your computer were already infiltrated to the point that someone could
modify mscorlib on your machine, though, managed rootkits likely aren't your
biggest concern. Oh well, it sounded like a good argument at the time.

## Domain Driven Design

The next session I attended was on [Domain Driven
Design](http://domaindrivendesign.org/) with [Craig
Berntson](http://www.craigberntson.com/blog). Here's [the synopsis from his
blog](http://www.craigberntson.com/blog/2009/03/speaking-at-devlink.asp): 

> Domain Driven Design is a way to design and develop enterprise applications
> so that they are easier to maintain, enhance, and extend. DDD is overkill for
> many of the applications we develop today, but still has principles that can
> be applied to most of the apps we write. In this session, you will learn to
> apply these concepts.

My personal feelings regarding this talk was that he did an excellent job at
actually communicating DDD. He contrasted the typical data-driven design for
applications to driving the design of the system from the business domain. He
also did a good job of explaining it in terms that everyone could understand.
It was a very good talk.

## Lunch over Open Spaces

Over lunch, I went back to the Open Spaces area to see if there were any
sessions going on then. A group of people were all sitting in one area so I
assumed it was going to be a great conversation. It certainly was, but it
wasn't a planned session. It wasn't even technical in nature at times... I
remember discussing favorite Family Guy episodes at one point...

## Architecting Architectural Stuff

My last session was on Architecting Modern Distributed Applications with [Clint
Edmonson](http://www.notsotrivial.net/blog/). He has [posted his slides and
thoughts on the conference on his
blog](http://www.notsotrivial.net/blog/post/2009/08/17/DevLink-Decompression.aspx).
He shared a diagram that he had seen at an internal Microsoft presentation that
showed the various architectural layers in typical applications and showed how
you could use the diagram to help make decisions like self-hosting versus
hosted solutions versus moving entirely to the cloud. A comment he made in
passing but that I thought had a lot of merit was adding in a ping operation to
all of your services so that you can quickly and easily determine the state of
what is working and what isn't. I know hardware almost always has this, but I
hadn't really considered putting it in software. I know, you've probably been
doing it for years. 

## Closing Circle

At the end of the day, I went to the Open Spaces closing circle where we went
over the week, discussed how we could more effectively publicize Open Spaces to
the rest of the conference attendees, and other things related to the
conference. I was a jerk and had to leave early, but it was all positive while
I was in the room. I'm pretty sure it didn't erupt or anything after I left :-) 

Once again, kudos to [John Kellar](http://www.johnkellar.com/) and team for
planning another amazing devLink. If you're interested in seeing more and
better pictures than I'll ever be able to take, [David
Giard](http://www.davidgiard.com/) has [posted a link to his pictures on his
blog](http://www.davidgiard.com/2009/08/23/DevLinkAndLinkWray.aspx). If you
weren't able to attend this year, go next year.


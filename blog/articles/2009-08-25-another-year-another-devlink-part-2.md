
title: "Another year, another devLink (part 2)"
author: David
date: 2009/08/25
categories: conferences

Yesterday, [I blogged about the first day of devLink](http://www.mohundro.com/blog/2009/08/24/AnotherYearAnotherDevLinkPart1.aspx) - today, I'll continue the recap with, you guessed it, day 2. 

The Open Spaces side of devLink started on day two, so that's where I went. Like last year, [Alan Stevens](http://netcave.org/) kicked everything off with the opening circle. (if you're unclear on the Open Spaces concept, I gave it more time in [my post from last year](http://www.mohundro.com/blog/2008/08/27/devLink2008Recap.aspx))

#### Convening my first open space session

Last year, I didn't have the guts to jump out there and provide a topic that I wanted to convene. This year, though, I thought I'd give it a try. So, I threw out [Event Driven Architecture](http://en.wikipedia.org/wiki/Event-driven_architecture) using tools like [MassTransit](http://code.google.com/p/masstransit/) or [nServiceBus](http://www.nservicebus.com/). Of course, when I brought it forward, I only said MassTransit and a few people came up to ask if I was referring to "mass transit" as in buses or trains. I guess I could've been more clear in my explanation. My *primary* purpose in picking this topic was entirely selfish - I hoped that someone would show up who knew more about it and they could do most of the talking!

Let's just say it didn't quite work out that way :-) 

I still think it went well. I ended up going over the very basics of EDA and MassTransit and having a discussion about how EDA can vastly decrease coupling in applications as well as how it also completely changes the way a system is architected over all. Interestingly enough, [Maggie Longshore](http://maggieplusplus.com/) mentioned that, in embedded software development, messaging was the norm instead of the typical "call a webservice and wait" that is typical of .NET code. I also spoke about the similarities between EDA and UI patterns like the [event aggregator](http://martinfowler.com/eaaDev/EventAggregator.html). I mentioned [Udi Dahan's domain events post](http://www.udidahan.com/2009/06/14/domain-events-salvation/) as well. During our discussion, [Jim Wooley](http://www.thinqlinq.com/) mentioned Linq to Events (or the Rx Framework) and pointed everyone to [an introductory article on the Rx Framework](http://themechanicalbride.blogspot.com/2009/07/introducing-rx-linq-to-events.html). I'm still trying to wrap my head around that post! 

Towards the end, the conversation drifted off into... just about everything else. We spoke about adding scripting functionality to applications (using tools like PowerShell, IronRuby or IronPython). As the convener, it was my role to ensure the conversation stayed on topic, but I was having fun just jumping around to different topics at the end. I think it went well.

#### jQuery Plugins are cool

Next, I went to an "eyes front" session from [Elijah Manor](http://elijahmanor.com/) on writing jQuery plugins. He has posted [the slides from his presentation on his blog](http://elijahmanor.com/2009/08/14/HowToCreateYourOwnJQueryPlugin.aspx). Having read ["the world's most misunderstood programming language"](http://www.crockford.com/javascript/javascript.html) from [Douglas Crockford](http://www.crockford.com/), I now consider myself somewhat of a JavaScript fanboy so I really enjoyed the talk. My hands-on experience with jQuery has been fairly limited up to this point and really only included using the Lightbox plugin and a few other tools, so the session was an eye opener. Probably one of my favorite parts of the talk was when Elijah shared [some must have developer bookmarklets](http://elijahmanor.com/2009/08/19/12MustHaveWebDeveloperBookmarklets.aspx). I had heard of Firebug Lite before, but the jQuery specific bookmarklets were new to me.

#### Mono is cool, too

After Elijah's talk, I went to [Sarah Dutkiewicz's](http://www.codinggeekette.com/) talk on cross platform C# using Mono. I've been following Mono from a distance for a few years, so it was good to hear Sarah's talk. After her presentation, we spoke about things like [MonoDevelop](http://monodevelop.com/), [Banshee](http://banshee-project.org/) and other open source things. I wasn't able to keep up entirely because my Mono experience thus far includes opening MonoDevelop and building Hello World, reading [Miguel de Icaza's blog](http://tirania.org/blog/), and listening to the [Hanselminutes episode on Mono and Banshee](http://www.hanselminutes.com/default.aspx?showID=186).

// TODO: Add Mono to the list of cool things to look at some day!

#### Learning Rails in the hallway

On the way back to the Open Spaces room, I ran into a group of people learning Rails from Leon in the hallway. Note that this wasn't a planned session - it just happened. Two or three people were sitting on a bench in the hall while everyone else was sitting in the floor. Most had laptops, but a few were looking over shoulders. If I can find a picture, I'll post it - a picture would communicate this a lot better than I can. 

![Impromptu Rails Session](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/AnotheryearanotherdevLinkpart2_F5A9/image_3.png)

UPDATE: thanks to [Matt Brewer](http://mattbrewer.mp/) for providing a link to the above picture of the impromptu Rails learning session with Leon - and thanks to [John Kellar](http://www.johnkellar.com/) for posting it to his Facebook photo album!

#### Final Open Spaces Session on... I'm not entirely sure

I was convinced that the final session of the day was on distributed source control. Later, I think I heard it was on DSLs (domain specific languages). In either case, it turned into another fun and random conversation. 

I'll finish up the devLink review covering day 3 soon!


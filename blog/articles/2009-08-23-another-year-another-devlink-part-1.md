
title: "Another year, another devLink (part 1)"
author: David
date: 2009/08/23

I’ve now attended [devLink](http://devlink.net) three times, with each time getting progressively better. This year marked the first time for devLink to be split across three days (from Thursday, August 13 through Saturday, August 15). Day one included preconference-like sessions that were longer in length with days two and three more closely resembling prior years. Like last year, this year also included Open Spaces, which ran over days two and three. <h4>Ruby Enlightenment</h4> 
My first session of devLink was with [Leon Gersing](http://fallenrogue.com/) covering Ruby-Koans: Path to Ruby Enlightenment. Let me start this way – I have never been to a session that was presented in quite the way that Leon gave this presentation. Let me give my alternate title for this presentation: “Learning Ruby through Pair Programming using Test Driven Development.” It was amazing. The guys at EdgeCase have created an open source library called [Ruby Koans](http://github.com/edgecase/ruby_koans/tree/master). From the project’s README: <blockquote> 
The Ruby Koans walk you along the path to enlightenment in order to learn Ruby. The goal is to learn the Ruby language, syntax, structure, and some common functions and libraries. We also teach you culture. Testing is not just something we pay lip service to, but something we live. It is essential in your quest to learn and do great things in the language.
</blockquote> 
Leon helped everyone get Ruby othat was done, we broke up into pairs and went through the koans. Leon walked around the room and helped whenever someone ran into a question or a problem. 
Let me share the first koan with you as an example. Pull up your favorite command prompt and go to the directory where you extracted ruby_koans. Once in that directory, run rake (rake is to ruby as make is to C or as nant/msbuild is to C#/VB.NET). 
<img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="Running Ruby Koans" border="0" alt="Running Ruby Koans" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/AnotheryearanotherdevLinkpart1_94E1/image_8.png" width="450" height="354"> 
The rake file changes the directory to the koans directory and then executes the various ruby files in it, which are unit tests. The first test fails in the ./about_basics.rb file on line 10. Here is what that file looks like: 
<img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="Ruby Koan 1" border="0" alt="Ruby Koan 1" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/AnotheryearanotherdevLinkpart1_94E1/image4.png" width="671" height="81"> 
You don’t really even have to know programming to see what you should do here. Just change the false to be true to get your test to pass. Once that is done, move to the next test and so on. 
The koans start at the simplest level and then move up to higher levels of complexity to expose you the Ruby language. 
Thanks to Leon for sharing this with us and helping to bring us all closer to Ruby enlightenment! 
<img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="Ruby Koans session" border="0" alt="Ruby Koans session" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/AnotheryearanotherdevLinkpart1_94E1/image_7.png" width="644" height="432"> 
(thanks to the [devLink](http://devlink.net) site for the above picture of the Ruby Koans session) <h4>Closures Explained</h4> 
The next session was with [Chris Smith](http://blogs.msdn.com/chrsmith/) on closures, lambda calculus, and functional programming with both C# and F#. I already had a basic understanding of closures, but I got a lot more from this talk. Surprisingly, lambda calculus’s name is far more complex than the actual concepts that it introduces. Unfortunately, I still can’t read more than half of the F# examples out there. I seriously need to try it out on some personal projects to understand it. Luckily, the ideas behind it are more solid now. Great job Chris! <h4>The Lost Art of Simplicity</h4> 
The opening keynote was presented by [Josh Holmes](http://www.joshholmes.com/blog/) on [the Lost Art of Simplicity](http://www.joshholmes.com/blog/2009/04/29/TheLostArtOfSimplicity.aspx). He posted the slides from when he gave his presentation earlier in the year, so I won’t spend a lot of time speaking on it. I do want to share a few thoughts that I got from it, though.  
Josh brought up the thinking that a lot of developers have when they see an application or other project: “I could build that in a weekend.” I saw this thinking <em>a lot</em> from people when stackoverflow.com was built. Josh pointed out the disconnect between this and then explaining to our users that a new feature will take eight months.  
That sort of hit me in the gut :-)  
He’s right, of course – we do this all the time, particularly in “enterprise” development. 
Another comment he brought up that was both true and funny at the same time is that we as developers don’t speak human, we speak geek. How right he is. 
  
And now for something completely different… <h4>Lunch boxes do more than carry food</h4> 
They carry code. Below is a picture that [Micky McQuade](http://twitter.com/mmcquade) took of me trying to explain closures of all things to [Anthony Ford](http://twitter.com/anthonyford). My communication skills were lacking at the time, so I decided to try to communicate with code and, seeing as how the lunch box was the closest writing medium I could find, I used it. 
<img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="Me writing on a lunch box" border="0" alt="Me writing on a lunch box" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/AnotheryearanotherdevLinkpart1_94E1/photo_3.jpg" width="363" height="484"> 
The code snippet below is approximately something like:
<pre>void Foo()
{
   var x = 5;
   var nums = new List<int> { 1, 2, 3 };
   nums.ForEach(n =&gt; Console.WriteLine(x));
}</int></pre>

I wanted to show how, if the lambda were moved out to its own function, it wouldn’t be able to access the x variable. 


<img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="Code on a lunch box" border="0" alt="Code on a lunch box" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/AnotheryearanotherdevLinkpart1_94E1/photo2.jpg" width="363" height="484">

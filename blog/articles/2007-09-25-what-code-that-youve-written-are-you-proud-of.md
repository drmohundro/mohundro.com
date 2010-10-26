
title: "What code that you've written are you proud of?"
author: David
date: 2007/09/25

<p>Yesterday, I had a somewhat strange experience. I was helping someone with a problem they were having and, almost as a side note, this individual thought he would share some code with me that he was particularly proud of. He even prefaced the story with the "not to brag or anything" phrase. He had written some custom code to help text boxes grow or shrink depending on how the user resized the window. If you know anything about WinForms, you'll know that some simple anchoring techniques and good use of the SplitContainer will solve this problem for you - please, please, please don't go writing custom mathematical equations when the framework can take care of it for you.</p> <p>At the time, I was pretty annoyed with it, because this individual was bragging about something that I considered "the wrong way to do it." In retrospect, this probably was the wrong response. Why? Because he was proud of some of the code he had written. He actually cared about it enough to not just treat it as something to toss off on to someone else when he moved to the next project. </p> <p>The projects that have turned out best that I've worked on the ones where I was really proud of the code. That doesn't mean I did it the right way. I'm thinking of one example where I wrote this crazy elaborate dynamic menu system in JavaScript. It even worked in both Firefox and Internet Explorer. It had a full blown object model and made use of closures and more - it was great. Here's a complete example of usage of the menu:</p> <div style="border-right: rgb(221,221,221) 1px dotted; padding-right: 4px; border-top: rgb(221,221,221) 1px dotted; padding-left: 4px; font-size: small; background: rgb(60,60,60); padding-bottom: 4px; margin: 4px; border-left: rgb(221,221,221) 1px dotted; color: rgb(255,255,255); padding-top: 4px; border-bottom: rgb(221,221,221) 1px dotted; font-family: consolas,'Courier New',courier,monospace"><span style="color: #8fb5d3">&lt;!DOCTYPE</span> <span style="color: #7ec12f">html</span> <span style="color: #7ec12f">PUBLIC</span> <span style="color: #f17d47">"-//W3C//DTD XHTML 1.0 Transitional//EN"</span> <span style="color: #f17d47">"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"</span><span style="color: #8fb5d3">&gt;</span><br><span style="color: #8fb5d3">&lt;html&gt;</span><br>&nbsp;&nbsp; <span style="color: #8fb5d3">&lt;head&gt;</span><br>&nbsp;&nbsp;&nbsp; &nbsp; <span style="color: #8fb5d3">&lt;title&gt;</span>clsNavBar<span style="color: #8fb5d3">&lt;/title&gt;</span><br>&nbsp;&nbsp;&nbsp; &nbsp; <span style="color: #8fb5d3">&lt;script</span> <span style="color: #7ec12f">language</span><span style="color: #8fb5d3">=</span><span style="color: #f17d47">"JavaScript"</span> <span style="color: #7ec12f">src</span><span style="color: #8fb5d3">=</span><span style="color: #f17d47">"clsMenu.js"</span><span style="color: #8fb5d3">&gt;&lt;/script&gt;</span><br>&nbsp;&nbsp;&nbsp; &nbsp; <span style="color: #8fb5d3">&lt;link</span> <span style="color: #7ec12f">href</span><span style="color: #8fb5d3">=</span><span style="color: #f17d47">"styles.css"</span> <span style="color: #7ec12f">rel</span><span style="color: #8fb5d3">=</span><span style="color: #f17d47">"stylesheet"</span> <span style="color: #7ec12f">type</span><span style="color: #8fb5d3">=</span><span style="color: #f17d47">"text/css"</span><span style="color: #8fb5d3">&gt;</span><br>&nbsp;&nbsp; <span style="color: #8fb5d3">&lt;/head&gt;</span><br>&nbsp;<br>&nbsp;&nbsp; <span style="color: #8fb5d3">&lt;body&gt;</span><br>&nbsp;&nbsp;&nbsp; &nbsp; <span style="color: #8fb5d3">&lt;script</span> <span style="color: #7ec12f">language</span><span style="color: #8fb5d3">=</span><span style="color: #f17d47">"JavaScript"</span><span style="color: #8fb5d3">&gt;</span><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <span style="color: #fef1a9">var</span> <span style="color: white">nav</span> = <span style="color: #fef1a9">new</span> <span style="color: white">clsMenu</span>();<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <span style="color: white">nav</span>.<span style="color: white">setContainer</span>(<span style="color: white">document</span>.<span style="color: white">body</span>);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <span style="color: white">nav</span>.<span style="color: white">setXMLUrl</span>(<span style="background: #515151; color: lime">"NavBar.xml"</span>);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <span style="color: silver">//nav.setHorizontal(false)</span><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <span style="color: white">nav</span>.<span style="color: white">buildMenu</span>();<br>&nbsp;&nbsp;&nbsp; &nbsp; <span style="color: #8fb5d3">&lt;/script&gt;</span><br>&nbsp;&nbsp; <span style="color: #8fb5d3">&lt;/body&gt;</span><br><span style="color: #8fb5d3">&lt;/html&gt;</span><br></div> <p>It had one problem. Maintenance. Maintenance on the system will be nigh impossible for the next guy. From the very beginning, I should have used CSS for the entire menu structure. When and if someone ever decides to change the way the menus look, well... good luck. However, it was still a good experience. I learned more about the inner workings of JavaScript from working with that than I did from any blog post or book I've ever looked at. I would have never learned what exactly 'this' references in JavaScript without that example (see <a href="http://www.fitzblog.com/tabid/17782/bid/2127/Nine-Javascript-Gotchas.aspx">this post on JavaScript gotchas</a> and refer to the section on 'this').</p> <p>In all of this, I have learned to be very careful of the code I'm proud of. Inevitably, if you're growing as a developer&nbsp;by "<a href="http://www.codinghorror.com/blog/archives/000530.html">sucking less every year</a>," you're not going to be too proud of your code in a year or two anyway.</p> <p>Do you have any code you're particularly proud of? If it turned out to be the "wrong way to do it" but you learned a lot from the experience, you get bonus points.</p>
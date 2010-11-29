
title: "Mass confusion! (aka the Story About how I Thought my Feed had Died)"
author: David
date: 2006/03/31
categories: general;visual studio
guid: 946b5b37-7054-4d05-931c-3c9362bbed18

Yesterday afternoon, I posted on [ShellExecuteEx and executing files with unknown file extensions](/blog/2006/03/31/opening-files-that-dont-have-associated-programs/). I was really confused, though, because my feed just wouldn't show up in my aggregator ([RSS Bandit](http://www.rssbandit.org)). I knew it wasn't my reader, though, because I had navigated to my feed's address ([http://feeds.feedburner.com/DavidMohundro](http://feeds.feedburner.com/DavidMohundro)) and it wasn't displaying my added post. I threw a few test posts out there but nothing would show up. I'll admit, I couldn't help but wonder if something had happened with FeedBurner. I shouldn't have doubted, though. It was indirectly my fault.

You see, FeedBurner has a nice report called FeedMedic (located under their Troubleshootize tab). I hadn't found that report until this afternoon. It informed me that my source feed was too large. 

Wha??? 

Apparently, my last post on file extensions was too big. I ended up editing the last post and taking out a lot of the unnecessary HTML that came out of my code to HTML addin. I ended up using [Jeff Atwood](http://www.codinghorror.com/blog/)'s great [FormatToHtml VS2005 macro](http://www.codinghorror.com/blog/archives/000429.html). The HTML it generates is a lot simpler, but also a lot cleaner. That solution alone dropped my post under the "large" size. Now everyone can happily see my posts again!


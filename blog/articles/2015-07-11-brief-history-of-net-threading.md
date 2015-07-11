---
title: Brief History of (.NET) Threading
date: 2015/07/11

I just wrapped up my CodeStock presentation on a Brief History of (.NET) Threading. I attempted to cover the last 10 years of threading in .NET starting from .NET 1.0 all the way to today. So, think `Thread`, `BackgroundWorker`, `ThreadPool`, `IAsyncResult` moving forward to `Task` and `async`/`await`.

It's a ton of things to cover, so it was pretty fast paced. I had to skip 99% of the synchronization mechanisms and all of the ways to handle state - that would have been a separate talk entirely on its own!

If you're interested in the slides and content, I've posted them on GitHub.

* [View the presentation online](http://drmohundro.github.io/presentations/brief-history-of-threading/)
* [Source for slides and examples](https://github.com/drmohundro/presentations/tree/master/brief-history-of-threading)

Also, below are some other references that I mentioned:

* General
	* [Everything .NET Programmers know about Asynchronous Programming is Wrong (Hanselminutes)](http://hanselminutes.com/327/everything-net-programmers-know-about-asynchronous-programming-is-wrong)
* ASP.NET related
	* [How To Run Background Tasks in ASP.NET (Scott Hanselman)](http://www.hanselman.com/blog/HowToRunBackgroundTasksInASPNET.aspx)
* TPL and Async/Await
	* [Implementing a simple ForEachAsync](http://blogs.msdn.com/b/pfxteam/archive/2012/03/04/10277325.aspx)
	* [Implementing a simple ForEachAsync, part 2](http://blogs.msdn.com/b/pfxteam/archive/2012/03/05/10278165.aspx)
* JavaScript notes (language parallels with C# development)
	* [Task.js](http://taskjs.org/)
	* [Async Proposal for ES7](https://github.com/lukehoban/ecmascript-asyncawait) (this is usable with [BabelJS](https://babeljs.io) if you [enable experimental support](https://babeljs.io/docs/advanced/transformers/#es7-experimental-))

I hope everyone enjoyed it!


title: "XmlSerializer and &quot;why is my application kicking off the C# compiler?&quot;"
author: David
date: 2007/03/26

<p>Lately, I've been working on performance enhancements to one of the projects at work. Our users had all mentioned that the application's startup time was pretty slow and wanted to know if we could do anything to speed it up. Of course, when all of your users have been using&nbsp;green screen applications, even native C applications will likely seem slow to them... but anyway. We started digging in and found a few places where we could optimize our code&nbsp;but our form still took a while to load. </p> <p>While testing, I happened to have Process Explorer up and noticed that our process was kicking off csc.exe, which is the C# compiler.</p> <p>This is one of those instances where some (if not all) of you will know what I was seeing here. You see, we were using XML serialization in our project. When you do XML serialization, some code-gen happens to make the serialization magic work. If you have FileMon or ProcMon up, you'll actually see a temporary C# file being written out and compiled. I might have remembered this (<a href="http://www.google.com/search?q=site%3Awww.hanselman.com+xmlserializer">Scott Hanselman has a lot of posts on the XmlSerializer</a>)&nbsp;if I had thought about the temp file aspect, but I was wondering more about the C# compiler.</p> <p>Anyway,&nbsp;the best way&nbsp;to avoid this&nbsp;precompilation step is to do the&nbsp;precompilation&nbsp;yourself using <a href="http://msdn2.microsoft.com/en-us/library/bk3w6240(vs.80).aspx">sgen</a>.&nbsp;Basically, if you give it an assembly named Foo.dll, you'll get back an assembly named Foo.XmlSerializers.dll.</p> <p>My only question regarding sgen is why standard compilation doesn't do this for you automatically. I'm sure there is some reason why, but I haven't thought of it yet. Regardless, I went ahead and added it to our build script and we've seen increased performance.</p> <p>As&nbsp;a side-note, Red Gate's ANTS Profiler is an awesome profiler tool to help you find bottlenecks in your code. It will put big red lines next to the code that takes&nbsp;a long time to run.</p>
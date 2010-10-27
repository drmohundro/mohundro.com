
title: "Blocked threads and transparent proxies"
author: David
date: 2007/08/01

<blockquote> 
(<strong>note</strong> - if you're reading this in a feed reader like Google Reader, sorry - the code snippets look awful... if anyone has any suggestions on good ways to get code to look good in the webpage <em>and</em> feed readers, I'd appreciate it)
</blockquote> 
Given this:
<pre style="background: rgb(60,60,60); font-family: consolas"><span style="color: rgb(224,224,224)">    <span style="color: rgb(254,241,169)">delegate</span><span style="color: rgb(224,224,224)"> </span><span style="color: rgb(254,241,169)">void</span><span style="color: rgb(224,224,224)"> </span><span style="color: rgb(199,199,241)">WorkDelegate</span><span style="color: rgb(224,224,224)">();
    </span><span style="color: rgb(254,241,169)">interface</span><span style="color: rgb(224,224,224)"> </span><span style="color: rgb(199,199,241)">ISomeInterface
</span><span style="color: rgb(224,224,224)">    {
        </span><span style="color: rgb(254,241,169)">void</span><span style="color: rgb(224,224,224)"> </span><span style="color: white">Execute</span><span style="color: rgb(224,224,224)">();
    }</span></span></pre>

 

What is the difference between this class
<pre style="background: rgb(60,60,60); font-family: consolas"><span style="color: rgb(224,224,224)">    <span style="color: rgb(254,241,169)">class</span><span style="color: rgb(224,224,224)"> </span><span style="color: rgb(199,199,241)">TestCaseOne
</span><span style="color: rgb(224,224,224)">    {
        </span><span style="color: rgb(199,199,241)">ISomeInterface</span><span style="color: rgb(224,224,224)"> </span><span style="color: white">something</span><span style="color: rgb(224,224,224)"> = </span><span style="color: rgb(199,199,241)">Activator</span><span style="color: rgb(224,224,224)">.</span><span style="color: white">GetObject</span><span style="color: rgb(224,224,224)">(</span><span style="color: rgb(254,241,169)">typeof</span><span style="color: rgb(224,224,224)">(</span><span style="color: white">ISomeInterface</span><span style="color: rgb(224,224,224)">), </span><span style="color: lime"></span><span style="background: rgb(81,81,81)">"http://some.url.com/"</span><span style="color: rgb(224,224,224)"></span><span style="background: rgb(60,60,60)">) </span><span style="color: rgb(254,241,169)">as</span><span style="color: rgb(224,224,224)"> </span><span style="color: white">ISomeInterface</span><span style="color: rgb(224,224,224)">;

        </span><span style="color: rgb(254,241,169)">public</span><span style="color: rgb(224,224,224)"> </span><span style="color: white">TestCaseOne</span><span style="color: rgb(224,224,224)">()
        {
            </span><span style="color: rgb(199,199,241)">BackgroundWorker</span><span style="color: rgb(224,224,224)"> </span><span style="color: white">wkr</span><span style="color: rgb(224,224,224)"> = </span><span style="color: rgb(254,241,169)">new</span><span style="color: rgb(224,224,224)"> </span><span style="color: rgb(199,199,241)">BackgroundWorker</span><span style="color: rgb(224,224,224)">();
            </span><span style="color: white">wkr</span><span style="color: rgb(224,224,224)">.</span><span style="color: white">DoWork</span><span style="color: rgb(224,224,224)"> += </span><span style="color: rgb(254,241,169)">new</span><span style="color: rgb(224,224,224)"> </span><span style="color: rgb(199,199,241)">DoWorkEventHandler</span><span style="color: rgb(224,224,224)">(</span><span style="color: white">wkr_DoWork</span><span style="color: rgb(224,224,224)">);
            </span><span style="color: white">wkr</span><span style="color: rgb(224,224,224)">.</span><span style="color: white">RunWorkerAsync</span><span style="color: rgb(224,224,224)">();
        }

        </span><span style="color: rgb(254,241,169)">void</span><span style="color: rgb(224,224,224)"> </span><span style="color: white">wkr_DoWork</span><span style="color: rgb(224,224,224)">(</span><span style="color: rgb(254,241,169)">object</span><span style="color: rgb(224,224,224)"> </span><span style="color: white">sender</span><span style="color: rgb(224,224,224)">, </span><span style="color: rgb(199,199,241)">DoWorkEventArgs</span><span style="color: rgb(224,224,224)"> </span><span style="color: white">e</span><span style="color: rgb(224,224,224)">)
        {
            </span><span style="color: white">something</span><span style="color: rgb(224,224,224)">.</span><span style="color: white">Execute</span><span style="color: rgb(224,224,224)">();
        }
    }</span></span></pre>

and this class?
<pre style="background: rgb(60,60,60); font-family: consolas"><span style="color: rgb(224,224,224)">    <span style="color: rgb(254,241,169)">class</span><span style="color: rgb(224,224,224)"> </span><span style="color: rgb(199,199,241)">TestCaseTwo
</span><span style="color: rgb(224,224,224)">    {
        </span><span style="color: rgb(199,199,241)">ISomeInterface</span><span style="color: rgb(224,224,224)"> </span><span style="color: white">something</span><span style="color: rgb(224,224,224)"> = </span><span style="color: rgb(199,199,241)">Activator</span><span style="color: rgb(224,224,224)">.</span><span style="color: white">GetObject</span><span style="color: rgb(224,224,224)">(</span><span style="color: rgb(254,241,169)">typeof</span><span style="color: rgb(224,224,224)">(</span><span style="color: rgb(199,199,241)">ISomeInterface</span><span style="color: rgb(224,224,224)">), </span><span style="color: lime"></span><span style="background: rgb(81,81,81)">"http://some.url.com/"</span><span style="color: rgb(224,224,224)"></span><span style="background: rgb(60,60,60)">) </span><span style="color: rgb(254,241,169)">as</span><span style="color: rgb(224,224,224)"> </span><span style="color: rgb(199,199,241)">ISomeInterface</span><span style="color: rgb(224,224,224)">;

        </span><span style="color: rgb(254,241,169)">public</span><span style="color: rgb(224,224,224)"> </span><span style="color: white">TestCaseTwo</span><span style="color: rgb(224,224,224)">()
        {</span><span style="color: rgb(224,224,224)">
            </span><span style="color: rgb(199,199,241)">WorkDelegate</span><span style="color: rgb(224,224,224)"> </span><span style="color: white">dlg</span><span style="color: rgb(224,224,224)"> = </span><span style="color: rgb(254,241,169)">new</span><span style="color: rgb(224,224,224)"> </span><span style="color: rgb(199,199,241)">WorkDelegate</span><span style="color: rgb(224,224,224)">(</span><span style="color: white">something</span><span style="color: rgb(224,224,224)">.</span><span style="color: white">Execute</span><span style="color: rgb(224,224,224)">);
            </span><span style="color: white">dlg</span><span style="color: rgb(224,224,224)">.</span><span style="color: white">BeginInvoke</span><span style="color: rgb(224,224,224)">(</span><span style="color: white">MyCallback</span><span style="color: rgb(224,224,224)">, </span><span style="color: rgb(254,241,169)">new</span><span style="color: rgb(224,224,224)"> </span><span style="color: rgb(254,241,169)">object</span><span style="color: rgb(224,224,224)">[] { </span><span style="color: white">dlg</span><span style="color: rgb(224,224,224)"> });
        }

        </span><span style="color: rgb(254,241,169)">private</span><span style="color: rgb(224,224,224)"> </span><span style="color: rgb(254,241,169)">void</span><span style="color: rgb(224,224,224)"> </span><span style="color: white">MyCallback</span><span style="color: rgb(224,224,224)">(</span><span style="color: rgb(199,199,241)">IAsyncResult</span><span style="color: rgb(224,224,224)"> </span><span style="color: white">iar</span><span style="color: rgb(224,224,224)">)
        {
            </span><span style="color: rgb(254,241,169)">object</span><span style="color: rgb(224,224,224)">[] </span><span style="color: white">asyncState</span><span style="color: rgb(224,224,224)"> = </span><span style="color: white">iar</span><span style="color: rgb(224,224,224)">.</span><span style="color: white">AsyncState</span><span style="color: rgb(224,224,224)"> </span><span style="color: rgb(254,241,169)">as</span><span style="color: rgb(224,224,224)"> </span><span style="color: rgb(254,241,169)">object</span><span style="color: rgb(224,224,224)">[];
            </span><span style="color: rgb(199,199,241)">WorkDelegate</span><span style="color: rgb(224,224,224)"> </span><span style="color: white">dlg</span><span style="color: rgb(224,224,224)"> = </span><span style="color: white">asyncState</span><span style="color: rgb(224,224,224)">[</span><span style="color: yellow"></span><span style="background: rgb(81,81,81)">0</span><span style="color: rgb(224,224,224)"></span><span style="background: rgb(60,60,60)">] </span><span style="color: rgb(254,241,169)">as</span><span style="color: rgb(224,224,224)"> </span><span style="color: rgb(199,199,241)">WorkDelegate</span><span style="color: rgb(224,224,224)">;

            </span><span style="color: white">dlg</span><span style="color: rgb(224,224,224)">.</span><span style="color: white">EndInvoke</span><span style="color: rgb(224,224,224)">(</span><span style="color: white">iar</span><span style="color: rgb(224,224,224)">);
        }
    }</span></span></pre>

 

Both classes have a field named something that is a reference to an HTTP remoting proxy that has been published at [http://some.url.com](http://some.url.com). Let's assume that the the HTTP Remoting configuration has already been set up. Both call the Execute method defined on the interface, but one is using a BackgroundWorker for threading and the other is using the BeginInvoke/EndInvoke means of threading. Big deal, right?

There isn't a huge difference just looking at the code -- except that with TestCaseOne, the remoting call will result in a blocked thread whereas TestCaseTwo will not. In TestCaseOne, the background thread will block on the something.Execute() call and wait for it to return. In TestCaseTwo, the WorkDelegate BeginInvokes on the transparent remoting proxy. There isn't any code to block on. Instead, the framework will let you know when your remoting call returns.

Why does this matter? When you have a blocked thread, you basically have wasted CPU cycles where it is blocking instead of working. This likely won't matter much if you're not working with a lot of threads, but it can cause performance problems if you're working with a lot of threads.

On the other hand, when TestCaseTwo calls back to let you know the remoting call has completed, it will not call back on the calling thread. BackgroundWorker is smart enough to invoke back to the UI thread if needed. Both have their pluses and minuses. The BackgroundWorker component does make the code a little more easy to read and it handles invoking back to the UI thread. However, if you're working with a lot of threads, you might try using the delegate approach instead, so as to avoid any blocked threads.

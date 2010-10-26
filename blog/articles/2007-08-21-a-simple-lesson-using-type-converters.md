
title: "A simple lesson using type converters"
author: David
date: 2007/08/21

<p>I found myself writing the following code this evening:</p> <div class="csharpcode"><pre class="alt"><span class="kwrd">public</span> T GetItem&lt;T&gt;(<span class="kwrd">string</span> name)</pre><pre>{</pre><pre class="alt">    <span class="kwrd">string</span> result = node.SelectSingleNode(name).InnerText.Trim();</pre><pre>&nbsp;</pre><pre class="alt">    <span class="kwrd">return</span> (T)GetConverter(<span class="kwrd">typeof</span>(T)).ConvertFromString(result);</pre><pre>}</pre><pre class="alt">&nbsp;</pre><pre><span class="kwrd">private</span> TypeConverter GetConverter(Type objectType)</pre><pre class="alt">{</pre><pre>    <span class="kwrd">if</span> (objectType.Equals(<span class="kwrd">typeof</span>(<span class="kwrd">int</span>)))</pre><pre class="alt">        <span class="kwrd">return</span> <span class="kwrd">new</span> Int32Converter();</pre><pre>    <span class="kwrd">else</span> <span class="kwrd">if</span> (objectType.Equals(<span class="kwrd">typeof</span>(<span class="kwrd">bool</span>)))</pre><pre class="alt">        <span class="kwrd">return</span> <span class="kwrd">new</span> BooleanConverter();</pre><pre>    <span class="kwrd">else</span> <span class="kwrd">if</span> (objectType.Equals(<span class="kwrd">typeof</span>(<span class="kwrd">string</span>)))</pre><pre class="alt">        <span class="kwrd">return</span> <span class="kwrd">new</span> StringConverter();</pre><pre>    <span class="kwrd">else</span></pre><pre class="alt">        <span class="kwrd">throw</span> <span class="kwrd">new</span> ArgumentException(<span class="str">"Does not support casting to "</span> + objectType.Name);</pre><pre>}</pre></div>
<style type="text/css">.csharpcode, .csharpcode pre
{
	font-size: small;
	color: black;
	font-family: consolas, "Courier New", courier, monospace;
	background-color: #ffffff;
	/*white-space: pre;*/
}
.csharpcode pre { margin: 0em; }
.csharpcode .rem { color: #008000; }
.csharpcode .kwrd { color: #0000ff; }
.csharpcode .str { color: #006080; }
.csharpcode .op { color: #0000c0; }
.csharpcode .preproc { color: #cc6633; }
.csharpcode .asp { background-color: #ffff00; }
.csharpcode .html { color: #800000; }
.csharpcode .attr { color: #ff0000; }
.csharpcode .alt 
{
	background-color: #f4f4f4;
	width: 100%;
	margin: 0em;
}
.csharpcode .lnum { color: #606060; }
</style>

<p>Don't ever write code like this. <a href="http://msdn2.microsoft.com/en-us/library/system.componentmodel.booleanconverter.aspx">Read the documentation</a> which explicitly says that "you should never create an instance of a BooleanConverter". If you follow their advice, your code will become much cleaner. Like so:</p>
<div class="csharpcode"><pre class="alt"><span class="kwrd">public</span> T GetItem&lt;T&gt;(<span class="kwrd">string</span> name)</pre><pre>{</pre><pre class="alt">    <span class="kwrd">string</span> result = node.SelectSingleNode(name).InnerText.Trim();</pre><pre>    <span class="kwrd">return</span> (T)TypeDescriptor.GetConverter(<span class="kwrd">typeof</span>(T)).ConvertFromString(result);</pre><pre class="alt">}</pre></div>
<style type="text/css">.csharpcode, .csharpcode pre
{
	font-size: small;
	color: black;
	font-family: consolas, "Courier New", courier, monospace;
	background-color: #ffffff;
	/*white-space: pre;*/
}
.csharpcode pre { margin: 0em; }
.csharpcode .rem { color: #008000; }
.csharpcode .kwrd { color: #0000ff; }
.csharpcode .str { color: #006080; }
.csharpcode .op { color: #0000c0; }
.csharpcode .preproc { color: #cc6633; }
.csharpcode .asp { background-color: #ffff00; }
.csharpcode .html { color: #800000; }
.csharpcode .attr { color: #ff0000; }
.csharpcode .alt 
{
	background-color: #f4f4f4;
	width: 100%;
	margin: 0em;
}
.csharpcode .lnum { color: #606060; }
</style>

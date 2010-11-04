
title: "Syntax Highlighter for Windows Live Writer"
author: David
date: 2006/08/28
categories: 

Check out the [Syntax Highlighter plugin](http://www.codeplex.com/Project/ListForums.aspx?ProjectName=Highlight4Writer) for Windows Live Writer.
<pre><span style="color: #808080">///&lt;summary&gt;</span>
<span style="color: #808080">///A test for CreateGallery (string)</span>
<span style="color: #808080">///&lt;/summary&gt;</span>
[TestMethod(), ExpectedException(<span style="color: #0000ff">typeof</span>(ArgumentNullException))]
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> CreateGallery_TestNull()
{
    GalleryHelper target = <span style="color: #0000ff">new</span> GalleryHelper();

    <span style="color: #0000ff">string</span> imageDirectory = <span style="color: #0000ff">null</span>;

    target.CreateGallery(imageDirectory);
}</pre>

Works just like you'd expect! If it had a few more niceties like taking out leading spaces, it'd be even better!


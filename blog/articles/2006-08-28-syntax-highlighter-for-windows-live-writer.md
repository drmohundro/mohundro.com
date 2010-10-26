
title: "Syntax Highlighter for Windows Live Writer"
author: David
date: 2006/08/28

<p>Check out the <a href="http://www.codeplex.com/Project/ListForums.aspx?ProjectName=Highlight4Writer">Syntax Highlighter plugin</a> for Windows Live Writer.</p><pre><span style="color: #808080">///&lt;summary&gt;</span>
<span style="color: #808080">///A test for CreateGallery (string)</span>
<span style="color: #808080">///&lt;/summary&gt;</span>
[TestMethod(), ExpectedException(<span style="color: #0000ff">typeof</span>(ArgumentNullException))]
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> CreateGallery_TestNull()
{
    GalleryHelper target = <span style="color: #0000ff">new</span> GalleryHelper();

    <span style="color: #0000ff">string</span> imageDirectory = <span style="color: #0000ff">null</span>;

    target.CreateGallery(imageDirectory);
}</pre>
<p>Works just like you'd expect! If it had a few more niceties like taking out leading spaces, it'd be even better!</p>

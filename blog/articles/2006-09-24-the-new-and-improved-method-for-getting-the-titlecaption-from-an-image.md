
title: "The New and Improved Method for getting the title/caption from an image"
author: David
date: 2006/09/24

<p>Last month (almost two months ago!), <a href="http://www.mohundro.com/blog/PermaLink,guid,4a32de3b-297a-49bd-be6f-0e568fc26dc2.aspx">I posted on how to programmatically get the caption for an image</a> in C#. I haven't posted much more on the subject lately, because I've been busy with other things like playing with Vista RC1 and different unit testing frameworks. I also have learned a lot more about the different methods for storing metadata in images. My previous method ONLY works for images where the metadata is in the <a href="http://en.wikipedia.org/wiki/EXIF">EXIF format</a>. There are a variety of different metadata formats available and I discovered that not all of my digital pictures use EXIF. In other words, my previous post DOES NOT WORK for those images. I also discovered that there is no reason to use my previous method, because <a href="http://www.shahine.com/omar/">Omar Shahine</a> has already done all of the hard work here.</p> <p>If you're interested in EXIF metadata, use his <a href="http://wiki.shahine.com/default.aspx/MyWiki.PhotoLibrary">PhotoLibrary</a>. It is a very well designed library for setting and retrieving EXIF metadata on images. I really wish I had known about it a couple of months ago, but at least I learned some stuff on my own. That's always nice. The problem is, once again, that it only works with EXIF metadata. Basically, I wanted a solution that gave me the same results that Windows Explorer file properties provides. I wanted the caption regardless of the metadata format.</p> <p>The solution? Windows Presentation Foundation!!! WPF provides a completely new way to look at images. There is a great overview in the MSDN documentation <a href="http://windowssdk.msdn.microsoft.com/en-us/library/ms748873.aspx">here</a>.</p> <p>The short of it is that you can write code like this, though:</p><pre><p>ImageSource src = this.image1.Source; </p><p>BitmapMetadata bm = ((BitmapMetadata)this.image1.Source.Metadata); 
<p>MessageBox.Show(bm.Title); </p></pre>
<p>Neat, eh? What's even better is that it works for every image I've tested with it so far. The only other code in my small example is some XAML to get an image loaded and the code to get a click event handler so I could see the results of my test.</p>
<p>Nice!</p>
<p>I guess my new Gallery Manager application will target the .NET 3.0 Framework!</p>
<p><strong>Note</strong> - for uncommon metadata attributes, there is a GetQuery property that BitmapMetadata provides. I haven't looked into much, but it looks like it covers many of the various metadata formats available. You just have to know the query syntax... which I currently don't. If anyone knows of any good resources on this, please let me know!</p>
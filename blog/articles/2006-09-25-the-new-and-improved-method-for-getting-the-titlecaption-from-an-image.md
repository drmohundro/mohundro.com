
title: "The New and Improved Method for getting the title/caption from an image"
author: David
date: 2006/09/25
categories: .net;programming
guid: 6c4b3264-5264-4046-9487-c3396bf3b6c8

Last month (almost two months ago!), [I posted on how to programmatically get the caption for an image](/blog/2006/08/21/getting-the-caption-of-an-image-programatically/) in C#. I haven't posted much more on the subject lately, because I've been busy with other things like playing with Vista RC1 and different unit testing frameworks. I also have learned a lot more about the different methods for storing metadata in images. My previous method ONLY works for images where the metadata is in the [EXIF format](http://en.wikipedia.org/wiki/EXIF). There are a variety of different metadata formats available and I discovered that not all of my digital pictures use EXIF. In other words, my previous post DOES NOT WORK for those images. I also discovered that there is no reason to use my previous method, because [Omar Shahine](http://www.shahine.com/omar/) has already done all of the hard work here. 

If you're interested in EXIF metadata, use his [PhotoLibrary](http://wiki.shahine.com/default.aspx/MyWiki.PhotoLibrary). It is a very well designed library for setting and retrieving EXIF metadata on images. I really wish I had known about it a couple of months ago, but at least I learned some stuff on my own. That's always nice. The problem is, once again, that it only works with EXIF metadata. Basically, I wanted a solution that gave me the same results that Windows Explorer file properties provides. I wanted the caption regardless of the metadata format. 

The solution? Windows Presentation Foundation!!! WPF provides a completely new way to look at images. There is a great overview in the MSDN documentation [here](http://windowssdk.msdn.microsoft.com/en-us/library/ms748873.aspx). 
The short of it is that you can write code like this, though:

    ImageSource src = this.image1.Source; 
    BitmapMetadata bm = ((BitmapMetadata)this.image1.Source.Metadata); 

    MessageBox.Show(bm.Title);

Neat, eh? What's even better is that it works for every image I've tested with it so far. The only other code in my small example is some XAML to get an image loaded and the code to get a click event handler so I could see the results of my test.

Nice!

I guess my new Gallery Manager application will target the .NET 3.0 Framework!

**Note** - for uncommon metadata attributes, there is a GetQuery property that BitmapMetadata provides. I haven't looked into much, but it looks like it covers many of the various metadata formats available. You just have to know the query syntax... which I currently don't. If anyone knows of any good resources on this, please let me know!



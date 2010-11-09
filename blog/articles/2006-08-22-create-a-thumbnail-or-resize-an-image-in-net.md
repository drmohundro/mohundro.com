
title: "Create a thumbnail or resize an image in .NET!"
author: David
date: 2006/08/22
categories: .net;programming

(After [yesterday's post](http://www.mohundro.com/blog/PermaLink,guid,4a32de3b-297a-49bd-be6f-0e568fc26dc2.aspx) on getting metadata from images in .NET, I've decided to continue to post some of the information I find regarding working with images in .NET.) 
As I mentioned yesterday, I'm working on an application to export a folder of images over to a webpage or something (I haven't decided on the output format, whether to a database, XML, or what). I've been learning quite a bit about .NET image support (primarily from GDI+) and it really provides a lot right out of the box. Today's post is on resizing an image without losing too much quality in the process. 

The first resource I found was [System.Drawing.Image.GetThumbmailImage](http://msdn2.microsoft.com/en-us/library/system.drawing.image.getthumbnailimage.aspx). My first thought was, "Surely it isn't this easy!" I was right - it wasn't that easy. Check out this quote from the remarks section of the documentation: 

> The **GetThumbnailImage** method works well when the requested thumbnail image has a size of about 120 x 120 pixels. If you request a large thumbnail image (for example, 300 x 300) from an **Image** that has an embedded thumbnail, there could be a noticeable loss of quality in the thumbnail image.

My first test was resizing an image that was originally 2580 x 1932 down to 640 x 483. It looked quite nasty after trying to call GetThumbnailImage. Back to Google I went, but thankfully I soon hit paydirt. I found the ["Resizing a Photographic image width GDI+ for .NET" article](http://www.codeproject.com/csharp/imageresize.asp) by Joel Neubeck on [CodeProject](http://www.codeproject.com/). The meat of the functions he provides are that they give examples on how to carry the resolution of the original image over and also how to use bicubic interpolation. With his code, my 640 x 483 picture still looks great - just as good as Picasa does for its export code! 

I will say that I am still using the GetThumbnailImage method for what it was primarily designed for: thumbnails. As the documentation says, it works fine up to about 120 x 120. I'm personally using a max width/height of 90 for my thumbnails right now. Here's an example of a call to GetThumbnailImage just so we'll get some code in this post: 
 
    private static void CreateThumbnail(Image img, string path, Size imageSize)
    {
      // Only call this to create thumbnails smaller than 120 x 120! Otherwise, check out
      // http://www.codeproject.com/csharp/imageresize.asp.
      Image thumbnail = img.GetThumbnailImage(
        imageSize.Width, 
        imageSize.Height, 
        (delegate { return false; }), 
        IntPtr.Zero);
      thumbnail.Save(path);
    }

As you can see, I'm using an anonymous delegate for the 3rd parameter, which presumably only exists for backwards compability, because it isn't called. It makes more sense to me to do it this way than to add a function that won't even be called.



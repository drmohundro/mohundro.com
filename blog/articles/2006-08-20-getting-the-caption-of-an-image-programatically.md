
title: "Getting the caption of an image programatically"
author: David
date: 2006/08/20

<p>So, this is a little off-topic compared to some of the other posts I have done lately, but it was something new to me and I thought I'd share it for information... and as a means of helping me remember it later!</p> <p>At home, I have been using both Microsoft Digital Image Library 2006 and Picasa to manage my digital pictures because I like features in both. Microsoft's product provides some nice editing features and tagging while I've been using Picasa's export as a webpage in an XML format for mine and my wife's blog. One of the hassles between the two, though, is that they store captions for images differently. I was having to manually copy and paste captions between both programs, which is&nbsp;huge time waster.&nbsp;Because I wanted to continue using Digital Image Library, I decided to write a program to export the gallery. (I know there are programs out there that can do this for me... I've got the <a href="http://blogs.msdn.com/abhinaba/archive/2005/12/12/502661.aspx">programmers' disease</a>!)</p> <p>To write this program correctly, I wanted to still be able to pull out information like the captions I had set for each picture. I ended up digging around a little bit researching the different implementations for storing metadata in the files and it would appear that Microsoft's implementation seems more standard than that of Picasa. In fact, some digging in one of my pictures using&nbsp;a hex editor shows the proprietary &lt;picasastamp&gt; enclosing a &lt;caption&gt; tag. At least that means it will be easier to pull the caption out.</p> <p>Probably one of the best places to start for researching this is the <a href="http://msdn2.microsoft.com/en-us/library/xddt0dz7.aspx">MSDN how to: Read Image Metadata</a>. It details the <a href="http://msdn2.microsoft.com/en-us/library/system.drawing.imaging.propertyitem.aspx">PropertyItem</a> that you can get off of the System.Drawing.Image class. There is actually a collection of PropertyItem objects from the PropertyItems collection. Basically, you can loop through the collection and inspect each item's Id property until you find the one you are looking for. That's the easy part. The hard part is figuring out which Id you're interested in because they don't have user-friendly names like "Caption" or "Title" - they're in hex. Thanks to this sort of random <a href="http://www.planet-source-code.com/vb/Discussion/AskAProShowPost.asp?lngTopicId=36106&amp;TopicCategory=other&amp;Flag=2&amp;lngWId=10">post</a>, I was able to find out that the captions I was looking for were 0x9c9b.</p> <p>So, without further ado, here's a very simple GetCaption method that will return the caption/title based on an Image passed to you:</p><pre>public static string GetCaption(Image img)
{
    if (img == null) 
        throw new ArgumentNullException("img");

    Encoding enc = Encoding.UTF8;

    foreach (PropertyItem prop in img.PropertyItems)
    {
        if (prop.Id == 0x9c9b)
        {
            return enc.GetString(prop.Value).Replace("\0", "").Trim();
        }
    }

    return string.Empty;
}</pre>
<p>Let me know what you think!</p>
<p>If you're interested in more about the PropertyItem class, check out these pages&nbsp;- they've got some nice information on them as well.</p>
<p>- <a href="http://www.codeproject.com/cs/media/photoproperties.asp">http://www.codeproject.com/cs/media/photoproperties.asp</a><br>- <a href="http://www.pixvillage.com/blogs/devblog/archive/2005/03/27/176.aspx">http://www.pixvillage.com/blogs/devblog/archive/2005/03/27/176.aspx</a></p>


title: "More on the FlowLayoutPanel"
author: David
date: 2006/03/07

<P>I've blogged about the&nbsp;<A href="http://www.mohundro.com/blog/PermaLink,guid,7ae4fad5-87f5-43b6-b5a1-ec9623c17d7c.aspx">FlowLayoutPanel in the past</A>. It is a highly useful control in certain circumstances, but it doesn't behave as expected a lot of the time. In trying to better explain how it works, I created a small test program to show what it is doing. Here is what it looks like:</P>
<P><IMG alt="" hspace=0 src="http://www.mohundro.com/blog/content/binary/2006-03-08-FlowLayout.jpg" align=baseline border=0></P>
<P>It primarily demonstrates how FlowDirection and WrapContents affect controls in the FlowLayoutPanel, particularly dynamically added controls. If you click one of the dynamically added buttons, it will pull up that buttons PropertyGrid, which will allow you to edit its properties. This is useful to examine the effects of sizing, anchoring, and docking.</P>
<P>Here's the&nbsp;<A href="http://www.mohundro.com/blog/content/binary/flowpaneltesting.zip">link to the VS2005 solution</A> if you're interested in playing around with it. It's in C#. I wanted to play around with anonymous delegates :-)</P>

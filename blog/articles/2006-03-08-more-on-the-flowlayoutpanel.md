
title: "More on the FlowLayoutPanel"
author: David
date: 2006/03/08
categories: .net;programming;visual studio
guid: 6368c694-080e-4899-98ec-c7e140f3d0c2

I've blogged about the [FlowLayoutPanel in the past](/blog/2006/01/24/some-notes-on-the-flowlayoutpanel/). It is a highly useful control in certain circumstances, but it doesn't behave as expected a lot of the time. In trying to better explain how it works, I created a small test program to show what it is doing. Here is what it looks like:

<img alt="" hspace="0" src="https://s3.amazonaws.com/mohundro/blog/2006-03-08-FlowLayout.jpg" align="baseline" border="0">

It primarily demonstrates how `FlowDirection` and `WrapContents` affect controls in the `FlowLayoutPanel`, particularly dynamically added controls. If you click one of the dynamically added buttons, it will pull up that buttons `PropertyGrid`, which will allow you to edit its properties. This is useful to examine the effects of sizing, anchoring, and docking.

Here's the [link to the VS2005 solution](https://s3.amazonaws.com/mohundro/blog/FlowPanelTesting.zip) if you're interested in playing around with it. It's in C#. I wanted to play around with anonymous delegates :-)


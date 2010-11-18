
title: "Setting a focus on load"
author: David
date: 2006/03/06
categories: .net;programming
guid: 7cf60bdb-c3ad-45ee-98a8-b782da9bc3d9

This may not be new for everyone, but I just learned it today. In webpages, to set focus to a control after a page has loaded, you handle the body's onload event and then call the focus method off of the control.

In .NET, there is a focus method off of controls, but it doesn't work if the control isn't visible... i.e. in the constructor or in the Load event. To get around this, use the ActiveControl property off of the Form or UserControl, like so:

    Me.ActiveControl = Me.txtTo

Not too bad, eh? In this example, Me.txtTo will have focus when the Form or UserControl is displayed. Just make sure it is in the Load event. It didn't seem to work for me in the constructor (even after the InitializeComponent call). Of course, I only tried it once...

(Google'd and found via [here](http://www.devnewsgroups.net/group/microsoft.public.dotnet.framework.windowsforms/topic39467.aspx))


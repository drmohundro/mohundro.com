
title: "Creating a custom control that allows dropping controls on it at design time"
author: David
date: 2006/08/18
categories: .net;programming;visual studio

This post is just as much for me as it is to share...

I was attempting to create a automatically resizing GroupBox control that would let users drop controls on it and it would grow as the controls dropped. I also wanted to offer a FlowLayoutPanel-like ability so that it would slide controls that were lower up if higher controls were hidden. Doesn't sound too bad and we would use it enough that it made sense to encapsulate it in a custom control. I started looking into inheriting from GroupBox and adding a FlowLayoutPanel to it's control collection. Then I hooked into the ControlAdded event for the GroupBox so that I could move the control from the GroupBox to the FlowLayoutPanel. I'm just walking you through the steps in my thinking process here... this apparently isn't how it should be done, because though it worked if controls were added at run-time, it gave me a weird designer error that said "'child' is not a child control of this parent" ([like these guys did](http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=155600&SiteID=1)).

What research I came up with looked like I would have to create my own custom designer to support code like this, that would also include code serialization into InitializeComponent. Yay. A little more research brought me this [link](http://blogs.msdn.com/subhagpo/archive/2005/03/21/399782.aspx), though. It details how to drop controls onto a UserControl at design time. It is a slightly different approach, but it provided what I needed. Basically, the solution also involves using a ControlDesigner, but the code seems much less involved than if I were handling code serialization.

Here's a code snippet to give you an idea of what I did:

    <Designer(GetType(AutoResizeGroupBoxDesigner))> _
    Public Class AutoResizeGroupBox
        <DesignerSerializationVisibility(DesignerSerializationVisibility.Content)> _
        Public ReadOnly Property FlowPanel() As FlowLayoutPanel
            Get
                ' Where _flowPanel has already been added to the designer
                Return _flowPanel
            End Get
        End Property

        ' code snipped...
    End Class

    Public Class AutoResizeGroupBoxDesigner
        Inherits ControlDesigner
        Public Overrides Sub Initialize(ByVal component As System.ComponentModel.IComponent)
            MyBase.Initialize(component)
            Dim autoGroupBox As AutoResizeGroupBox = DirectCast(component, AutoResizeGroupBox)
            EnableDesignMode(autoGroupBox.FlowPanel, "FlowPanel")
        End Sub
    End Class


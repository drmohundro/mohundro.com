
title: "More information on yesterday's VS2005 bug"
author: David
date: 2006/01/12
categories: visual studio

After some <strike>severe frustration</strike> research, I was able to discover how to repro the crash in Visual Studio 2005 yesterday. It is actually quite simple to do. You need a new VB.NET project and two With statements, one nested within the other. That's it. Then you click on the second With object.

Here, I'll show you how!

    Public Class Form1
      Public Shared Sub Main()
        Application.Run(New Form1)
      End Sub

      Public Sub New()
        ' This call is required by the Windows Form Designer.
        InitializeComponent()
        ' Add any initialization after the InitializeComponent() call.
        Dim p As New Person()
        With p
          ' CRASHHERE: If you want to crash, take your mouse and
          ' click inside .StreetAddress.... BOOM!
          With .StreetAddress
            .Street = "123 BOOM"
          End With
        End With
      End Sub

      Public Class Person
        Private _streetAddress As New Address
        Public ReadOnly Property StreetAddress() As Address
          Get
            Return _streetAddress
          End Get
        End Property
      End Class

      Public Class Address
        Private _street As String
        Public Property Street() As String
          Get
            Return _street
          End Get
          Set(ByVal value As String)
            _street = value
          End Set
        End Property
      End Class
    End Class

There, that was easy, huh? (In case you're not seeing it, look for the CRASHHERE note.)

Kids, don't try this at home.

Chances are, it will work for you anyway. I just checked with one of my co-workers and it works just fine for him. Great.


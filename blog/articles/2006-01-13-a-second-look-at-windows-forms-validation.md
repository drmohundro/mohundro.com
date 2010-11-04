
title: "A second look at Windows Forms validation"
author: David
date: 2006/01/13
categories: .net

Continuing on my thoughts from yesterday regarding Windows Forms validation, I first began using Michael Weinhardt's [validation library on MSDN](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnforms/html/winforms05182004.asp) after doing a project conversion from 1.1 to 2.0, but there were a few things that I personally wanted to do that weren't currently supported, like validation on controls like the DateTimePicker. It would have been quite easy to add support, but I began developing a picture in my mind of a slightly different approach to validation. His solution was very designer oriented, but I wanted a more code-centric approach.

What I came up with was basically a GroupValidator class that took a control and a delegate to a provided validation function. The class took care of calling the validation function by hooking into the Validating event and then setting the appropriate error message. It added the control and delegate to a collection which could then be looped through so that you could check to see if the entire group was valid. It is pretty basic, but it works quite well so far. I'd like to expand it a little bit to add more automation, but it gets the job done right now.

Here's an example of usage:

    Public Class Form1
      Private _validator As New GroupValidator()

      Public Sub New()
        ' This call is required by the Windows Form Designer.
        InitializeComponent()
        ' Add any initialization after the InitializeComponent() call.
        _validator.AddControl(Me.TextBox1, AddressOf IsTextValid, "Text not valid")
        _validator.AddControl(Me.TextBox2, AddressOf IsTextValid, "Test not valid2")
        _validator.AddControl(Me.TextBox3, AddressOf IsTextValid, "Enter something")
        _validator.AddControl(Me.TextBox4, AddressOf IsTextValid, "Please")
      End Sub

      Private Function IsTextValid(ByVal c As Control) As Boolean
        If c.Text.Length > 0 Then
          Return True
        Else
          Return False
        End If
      End Function

      Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        MessageBox.Show(_validator.IsValid.ToString)
      End Sub
    End Class

It is pretty simple as you can see. If you're interested in the code, drop a line and I'll email it or post it.


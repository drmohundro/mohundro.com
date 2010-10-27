
title: "DataBinding and Pointers, or \"Why is my DataBinding not working?\""
author: David
date: 2006/02/14

Let's say you have the following class:

    Public Class Person
      Private _name As String

      Public Event NameChanged As EventHandler

      Public Property Name() As String
        Get
          Return _name
        End Get
        Set(ByVal value As String)
          _name = value
          OnNameChanged(EventArgs.Empty)
        End Set
      End Property

      Protected Sub OnNameChanged(ByVal e As EventArgs)
        RaiseEvent NameChanged(Me, e)
      End Sub
    End Class

We've set up the [Property]Changed events so that DataBinding will work correctly. Now, let's assume you want to bind the name property over to the text property of your TextBox control. We'll go the simple data binding route here for simplicity.

    Public Class Form1
      Private txtName As New TextBox
      Private _person As New Person

      Public Sub New()
        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        Me.Controls.Add(txtName)

        _person.Name = "cool"
        txtName.DataBindings.Add("Text", _person, "Name")
      End Sub

      Private Sub Form_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Click
        _person.Name = "clicked"
      End Sub
    End Class

There! Now the txtName will display "clicked" whenever you click on the form. Magic! Now, let's change that Click event like so to see what happens:

    Private Sub Form_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Click
      Dim newPerson As New Person
      newPerson.Name = "new person"
      _person = newPerson
    End Sub

Why would I ever want to do is this way? Well, let's say you're remoting somewhere to get your data and your background thread returns a fully populated object. The easiest thing to do is to just point to the new object... except that it doesn't work.

All we did was change our instance over, but the textbox never changed. Why not? Because of REFERENCES, POINTERS, and MEMORY ADDRESSES! That's why! Check this out:

    Private Sub Form_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Click
      Dim newPerson As New Person
      newPerson.Name = "new person"

      Debug.WriteLine("Are references equal? " & Object.ReferenceEquals(txtName.DataBindings("Text").DataSource, _person))
      _person = newPerson
      Debug.WriteLine("Are references equal? " & Object.ReferenceEquals(txtName.DataBindings("Text").DataSource, _person))
    End Sub

Whoa! The first Debug.Writeline will give you TRUE, but the second will give you FALSE. You see, understanding how references and pointers work is important. The textbox's DataSource is holding onto a reference of the old Person instance. You now have two different instances in memory, whether you like it or not.

What do you do about it? Well, as far as I can tell, you can either update your DataSource reference (it did change after all) or you can move your properties over manually so that your references don't change. I'm open to suggestions on other methods here.


title: "Some notes on the FlowLayoutPanel"
author: David
date: 2006/01/23

I've been experimenting with the FlowLayoutPanel. There are a few catches to using it that can cause some confusion. In my case, the confusion came from anchoring and/or docking. I was dynamically adding some listviews to my panel to display results of data. There would be one to many listviews depending on the type of report the user requested. Having come from developing in ASP, it is still my first inclination to just create a table for each section and add it. The flow of the HTML would handle the rest. I figured I could get a FlowLayoutPanel and just add controls as needed and get similar functionality.

That was true to a degree; however, anchoring doesn't perform as you might think. If you anchor to the left and right after setting the width, if there is only one control in the panel, it will drop down to a zero width. The actual behavior is that, if you anchor to the left and right, it will assume the width of the widest control already on the FlowLayoutPanel. The same is true if you set the Dock property to Fill. Check out [this article](http://msdn2.microsoft.com/en-us/library/ms171633.aspx) on MSDN to see what I mean. The behavior also depends on the FlowDirection property.

Everything works great if your panel isn't going to resize itself. You can just set the first control's width to the width of the panel minus a few pixels and Dock.Fill everything else. If you want it to resize as you resize the form, though, it is looking like you'll have to handle some layout events.

Here's some code to get you started:

    Public Class Form1
      Private WithEvents flowPanel As New FlowLayoutPanel()

      Public Sub New()
        ' This call is required by the Windows Form Designer.
        InitializeComponent()
        ' Add any initialization after the InitializeComponent() call.
        ' DON'T FORGET THESE LINES!
        flowPanel.Dock = DockStyle.Fill
        flowPanel.FlowDirection = FlowDirection.TopDown
        Me.Controls.Add(flowPanel)
        AddListView()
        AddListView()
      End Sub

      Private Sub AddListView()
        Dim totalList As New ListView()
        totalList.View = View.Details

        ' If first control, then set a width; otherwise, Dock.Fill it.
        If Me.flowPanel.Controls.Count > 0 Then
          totalList.Dock = DockStyle.Fill
        Else
          totalList.Width = Me.flowPanel.Width - 10
        End If

        totalList.Columns.AddRange(New ColumnHeader() _
          {GetColumnHeader("Col 1"), _
          GetColumnHeader("Col 2"), _
          GetColumnHeader("Col 3")})

        Dim item As ListViewItem = totalList.Items.Add("Row 1")
        item.SubItems.Add("1234.00")
        item.SubItems.Add("5678.00")
        item = totalList.Items.Add("Row 1")
        item.SubItems.Add("1234.00")
        item.SubItems.Add("5678.00")
        item = totalList.Items.Add("Row 1")
        item.SubItems.Add("1234.00")
        item.SubItems.Add("5678.00")

        Me.flowPanel.Controls.Add(totalList)
      End Sub

      Private Function GetColumnHeader(ByVal text As String) As ColumnHeader
        Dim col As New ColumnHeader()
        col.Text = text
        Return col
      End Function

      Private Sub flow_Layout(ByVal sender As Object, _
        ByVal e As System.Windows.Forms.LayoutEventArgs) _
        Handles flowPanel.Layout

        Dim flowLayout As FlowLayoutPanel = DirectCast(sender, FlowLayoutPanel)
        If flowLayout.Controls.Count > 0 Then
          flowLayout.Controls(0).Width = flowLayout.Width - 10
        End If
      End Sub
    End Class

Here's MSDN [another article](http://msdn2.microsoft.com/en-us/library/z9w7ek2f.aspx) that gives some basic information on the FlowLayoutPanel.

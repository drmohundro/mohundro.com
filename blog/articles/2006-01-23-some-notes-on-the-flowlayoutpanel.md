
title: "Some notes on the FlowLayoutPanel"
author: David
date: 2006/01/23

I've been experimenting with the FlowLayoutPanel. There are a few catches to using it that can cause some confusion. In my case, the confusion came from anchoring and/or docking. I was dynamically adding some listviews to my panel to display results of data. There would be one to many listviews depending on the type of report the user requested. Having come from developing in ASP, it is still my first inclination to just create a table for each section and add it. The flow of the HTML would handle the rest. I figured I could get a FlowLayoutPanel and just add controls as needed and get similar functionality.<br><br>That was true to a degree; however, anchoring doesn't perform as you might think. If you anchor to the left and right after setting the width, if there is only one control in the panel, it will drop down to a zero width. The actual behavior is that, if you anchor to the left and right, it will assume the width of the widest control already on the FlowLayoutPanel. The same is true if you set the Dock property to Fill. Check out [this article](http://msdn2.microsoft.com/en-us/library/ms171633.aspx) on MSDN to see what I mean. The behavior also depends on the FlowDirection property.<br><br>Everything works great if your panel isn't going to resize itself. You can just set the first control's width to the width of the panel minus a few pixels and Dock.Fill everything else. If you want it to resize as you resize the form, though, it is looking like you'll have to handle some layout events.

Here's some code to get you started:
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; COLOR: navy; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">Public</span><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"> </font><span style="COLOR: navy">Class</span><font color="#000000"> Form1<?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" />
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">Private</span><font color="#000000"> </font><span style="COLOR: navy">WithEvents</span><font color="#000000"> flowPanel </font><span style="COLOR: navy">As</span><font color="#000000"> </font><span style="COLOR: navy">New</span><font color="#000000"> FlowLayoutPanel()
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
<font color="#000000"> </font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">Public</span><font color="#000000"> </font><span style="COLOR: navy">Sub</span><font color="#000000"> </font><span style="COLOR: navy">New</span><font color="#000000">()
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: green">' This call is required by the Windows Form Designer.
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>InitializeComponent()
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
<font color="#000000"> </font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: green">' Add any initialization after the InitializeComponent() call.
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; COLOR: green; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
</span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: green">' DON'T FORGET THESE LINES!
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>flowPanel.Dock = DockStyle.Fill
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>flowPanel.FlowDirection = FlowDirection.TopDown
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
<font color="#000000"> </font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">Me</span><font color="#000000">.Controls.Add(flowPanel)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
<font color="#000000"> </font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>AddListView()
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>AddListView()
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">Sub
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; COLOR: navy; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
</span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">Private</span><font color="#000000"> </font><span style="COLOR: navy">Sub</span><font color="#000000"> AddListView()
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">Dim</span><font color="#000000"> totalList </font><span style="COLOR: navy">As</span><font color="#000000"> </font><span style="COLOR: navy">New</span><font color="#000000"> ListView()
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>totalList.View = View.Details
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
<font color="#000000"> </font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: green">' If first control, then set a width; otherwise, Dock.Fill it.
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">If</span><font color="#000000"> </font><span style="COLOR: navy">Me</span><font color="#000000">.flowPanel.Controls.Count &gt; </font><span style="COLOR: red">0</span><font color="#000000"> </font><span style="COLOR: navy">Then
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">            </span>totalList.Dock = DockStyle.Fill
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">Else
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">            </span>totalList.Width = </font><span style="COLOR: navy">Me</span><font color="#000000">.flowPanel.Width - </font><span style="COLOR: red">10
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">If
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; COLOR: navy; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
</span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>totalList.Columns.AddRange(</font><span style="COLOR: navy">New</span><font color="#000000"> ColumnHeader() _
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">            </span>{GetColumnHeader(</font><span style="COLOR: maroon">"<?xml:namespace prefix = st1 ns = "urn:schemas-microsoft-com:office:smarttags" /><state w:st="on"><place w:st="on">Col</place></state> 1"</span><font color="#000000">), _
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">            </span>GetColumnHeader(</font><span style="COLOR: maroon">"<state w:st="on"><place w:st="on">Col</place></state> 2"</span><font color="#000000">), _
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">            </span>GetColumnHeader(</font><span style="COLOR: maroon">"<state w:st="on"><place w:st="on">Col</place></state> 3"</span><font color="#000000">)})
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
<font color="#000000"> </font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">Dim</span><font color="#000000"> item </font><span style="COLOR: navy">As</span><font color="#000000"> ListViewItem = totalList.Items.Add(</font><span style="COLOR: maroon">"Row 1"</span><font color="#000000">)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>item.SubItems.Add(</font><span style="COLOR: maroon">"1234.00"</span><font color="#000000">)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>item.SubItems.Add(</font><span style="COLOR: maroon">"5678.00"</span><font color="#000000">)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
<font color="#000000"> </font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>item = totalList.Items.Add(</font><span style="COLOR: maroon">"Row 1"</span><font color="#000000">)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>item.SubItems.Add(</font><span style="COLOR: maroon">"1234.00"</span><font color="#000000">)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>item.SubItems.Add(</font><span style="COLOR: maroon">"5678.00"</span><font color="#000000">)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
<font color="#000000"> </font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>item = totalList.Items.Add(</font><span style="COLOR: maroon">"Row 1"</span><font color="#000000">)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>item.SubItems.Add(</font><span style="COLOR: maroon">"1234.00"</span><font color="#000000">)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>item.SubItems.Add(</font><span style="COLOR: maroon">"5678.00"</span><font color="#000000">)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
<font color="#000000"> </font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">Me</span><font color="#000000">.flowPanel.Controls.Add(totalList)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">Sub
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; COLOR: navy; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
</span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">Private</span><font color="#000000"> </font><span style="COLOR: navy">Function</span><font color="#000000"> GetColumnHeader(</font><span style="COLOR: navy">ByVal</span><font color="#000000"> text </font><span style="COLOR: navy">As</span><font color="#000000"> </font><span style="COLOR: navy">String</span><font color="#000000">) </font><span style="COLOR: navy">As</span><font color="#000000"> ColumnHeader
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">Dim</span><font color="#000000"> col </font><span style="COLOR: navy">As</span><font color="#000000"> </font><span style="COLOR: navy">New</span><font color="#000000"> ColumnHeader()
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>col.Text = text
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">Return</span><font color="#000000"> col
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">Function
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; COLOR: navy; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
</span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">Private</span><font color="#000000"> </font><span style="COLOR: navy">Sub</span><font color="#000000"> flow_Layout(</font><span style="COLOR: navy">ByVal</span><font color="#000000"> sender </font><span style="COLOR: navy">As</span><font color="#000000"> </font><span style="COLOR: navy">Object</span><font color="#000000">, _
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">ByVal</span><font color="#000000"> e </font><span style="COLOR: navy">As</span><font color="#000000"> System.Windows.Forms.LayoutEventArgs) _
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">Handles</span><font color="#000000"> flowPanel.Layout
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
<font color="#000000"> </font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">Dim</span><font color="#000000"> flowLayout </font><span style="COLOR: navy">As</span><font color="#000000"> FlowLayoutPanel = </font><span style="COLOR: navy">DirectCast</span><font color="#000000">(sender, FlowLayoutPanel)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">If</span><font color="#000000"> flowLayout.Controls.Count &gt; </font><span style="COLOR: red">0</span><font color="#000000"> </font><span style="COLOR: navy">Then
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">            </span>flowLayout.Controls(</font><span style="COLOR: red">0</span><font color="#000000">).Width = flowLayout.Width - </font><span style="COLOR: red">10
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">If
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">Sub
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; COLOR: navy; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">End</span><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"> </font><span style="COLOR: navy">Class</span></span><br><br>Here's MSDN [another article](http://msdn2.microsoft.com/en-us/library/z9w7ek2f.aspx) that gives some basic information on the FlowLayoutPanel.<br>

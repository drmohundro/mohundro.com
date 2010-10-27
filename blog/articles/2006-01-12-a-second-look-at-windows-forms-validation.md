
title: "A second look at Windows Forms validation"
author: David
date: 2006/01/12

Continuing on my thoughts from yesterday regarding Windows Forms validation, I first began using Michael Weinhardt's [validation library on MSDN](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnforms/html/winforms05182004.asp) after doing a project conversion from 1.1 to 2.0, but there were a few things that I personally wanted to do that weren't currently supported, like validation on controls like the DateTimePicker. It would have been quite easy to add support, but I began developing a picture in my mind of a slightly different approach to validation. His solution was very designer oriented, but I wanted a more code-centric approach.

What I came up with was basically a GroupValidator class that took a control and a delegate to a provided validation function. The class took care of calling the validation function by hooking into the Validating event and then setting the appropriate error message. It added the control and delegate to a collection which could then be looped through so that you could check to see if the entire group was valid. It is pretty basic, but it works quite well so far. I'd like to expand it a little bit to add more automation, but it gets the job done right now.

Here's an example of usage:
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: navy; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">Public</span><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"> </font><span style="COLOR: navy">Class</span><font color="#000000"> Form1<?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" />
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">Private</span><font color="#000000"> _validator </font><span style="COLOR: navy">As</span><font color="#000000"> </font><span style="COLOR: navy">New</span><font color="#000000"> GroupValidator()
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
<font color="#000000"> </font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">Public</span><font color="#000000"> </font><span style="COLOR: navy">Sub</span><font color="#000000"> </font><span style="COLOR: navy">New</span><font color="#000000">()
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: green">' This call is required by the Windows Form Designer.
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>InitializeComponent()
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
<font color="#000000"> </font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: green">' Add any initialization after the InitializeComponent() call.
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>_validator.AddControl(</font><span style="COLOR: navy">Me</span><font color="#000000">.TextBox1, _
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">            </font></span><span style="COLOR: navy">AddressOf</span><font color="#000000"> IsTextValid, </font><span style="COLOR: maroon">"Text not valid"</span><font color="#000000">)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>_validator.AddControl(</font><span style="COLOR: navy">Me</span><font color="#000000">.TextBox2, _
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">            </font></span><span style="COLOR: navy">AddressOf</span><font color="#000000"> IsTextValid, </font><span style="COLOR: maroon">"Test not valid2"</span><font color="#000000">)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">    </span><span style="mso-spacerun: yes">    </span>_validator.AddControl(</font><span style="COLOR: navy">Me</span><font color="#000000">.TextBox3, _
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">            </font></span><span style="COLOR: navy">AddressOf</span><font color="#000000"> IsTextValid, </font><span style="COLOR: maroon">"Enter something"</span><font color="#000000">)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>_validator.AddControl(</font><span style="COLOR: navy">Me</span><font color="#000000">.TextBox4, _
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">            </font></span><span style="COLOR: navy">AddressOf</span><font color="#000000"> IsTextValid, </font><span style="COLOR: maroon">"Please"</span><font color="#000000">)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">Sub
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: navy; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
</span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">Private</span><font color="#000000"> </font><span style="COLOR: navy">Function</span><font color="#000000"> IsTextValid(</font><span style="COLOR: navy">ByVal</span><font color="#000000"> c </font><span style="COLOR: navy">As</span><font color="#000000"> Control) </font><span style="COLOR: navy">As</span><font color="#000000"> </font><span style="COLOR: navy">Boolean
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">If</span><font color="#000000"> c.Text.Length &gt; </font><span style="COLOR: red">0</span><font color="#000000"> </font><span style="COLOR: navy">Then
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">            </font></span><span style="COLOR: navy">Return</span><font color="#000000"> </font><span style="COLOR: navy">True
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">Else
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">            </font></span><span style="COLOR: navy">Return</span><font color="#000000"> </font><span style="COLOR: navy">False
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">If
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">Function
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: navy; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">
</span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">Private</span><font color="#000000"> </font><span style="COLOR: navy">Sub</span><font color="#000000"> Button1_Click(</font><span style="COLOR: navy">ByVal</span><font color="#000000"> sender </font><span style="COLOR: navy">As</span><font color="#000000"> System.Object, </font><span style="COLOR: navy">ByVal</span><font color="#000000"> e </font><span style="COLOR: navy">As</span><font color="#000000"> System.EventArgs) </font><span style="COLOR: navy">Handles</span><font color="#000000"> Button1.Click
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>MessageBox.Show(_validator.IsValid.ToString)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">Sub
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: navy; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">End</span><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"> </font><span style="COLOR: navy">Class
</span></span>




It is pretty simple as you can see. If you're interested in the code, drop a line and I'll email it or post it.

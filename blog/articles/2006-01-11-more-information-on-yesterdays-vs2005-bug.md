
title: "More information on yesterday's VS2005 bug"
author: David
date: 2006/01/11

After some <strike>severe frustration</strike> research, I was able to discover how to repro the crash in Visual Studio 2005 yesterday. It is actually quite simple to do. You need a new VB.NET project and two With statements, one nested within the other. That's it. Then you click on the second With object.

Here, I'll show you how!
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: navy; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes">Public</span><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><font color="#000000"> </font><span style="COLOR: navy">Class</span><font color="#000000"> Form1<?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" />
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">Public</span><font color="#000000"> </font><span style="COLOR: navy">Shared</span><font color="#000000"> </font><span style="COLOR: navy">Sub</span><font color="#000000"> <?xml:namespace prefix = st1 ns = "urn:schemas-microsoft-com:office:smarttags" /><place w:st="on">Main</place>()
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>Application.Run(</font><span style="COLOR: navy">New</span><font color="#000000"> Form1)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">Sub
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: navy; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes">
</span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">Public</span><font color="#000000"> </font><span style="COLOR: navy">Sub</span><font color="#000000"> </font><span style="COLOR: navy">New</span><font color="#000000">()
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: green">' This call is required by the Windows Form Designer.
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">        </span>InitializeComponent()
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes">
<font color="#000000"> </font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: green">' Add any initialization after the InitializeComponent() call.
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">Dim</span><font color="#000000"> p </font><span style="COLOR: navy">As</span><font color="#000000"> </font><span style="COLOR: navy">New</span><font color="#000000"> Person()
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">With</span><font color="#000000"> p
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">            </font></span><span style="COLOR: green"><strong>' CRASHHERE: If you want to crash, take your mouse and 
</strong></span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><strong><span style="mso-spacerun: yes"><font color="#000000">            </font></span><span style="COLOR: green">' click inside .StreetAddress.... BOOM!
</span></strong></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">            </font></span><span style="COLOR: navy">With</span><font color="#000000"> <strong>.StreetAddress
</strong></font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">                </span>.Street = </font><span style="COLOR: maroon">"123 BOOM"
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">            </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">With
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">With
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">Sub
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: navy; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes">
</span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">Public</span><font color="#000000"> </font><span style="COLOR: navy">Class</span><font color="#000000"> Person
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">Private</span><font color="#000000"> _streetAddress </font><span style="COLOR: navy">As</span><font color="#000000"> </font><span style="COLOR: navy">New</span><font color="#000000"> Address
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">Public</span><font color="#000000"> </font><span style="COLOR: navy">ReadOnly</span><font color="#000000"> </font><span style="COLOR: navy">Property</span><font color="#000000"> StreetAddress() </font><span style="COLOR: navy">As</span><font color="#000000"> Address
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">            </font></span><span style="COLOR: navy">Get
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">                </font></span><span style="COLOR: navy">Return</span><font color="#000000"> _streetAddress
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">            </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">Get
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">Property
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">Class
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: navy; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes">
</span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">Public</span><font color="#000000"> </font><span style="COLOR: navy">Class</span><font color="#000000"> Address
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">Private</span><font color="#000000"> _street </font><span style="COLOR: navy">As</span><font color="#000000"> </font><span style="COLOR: navy">String
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">Public</span><font color="#000000"> </font><street w:st="on"><address w:st="on">
<span style="COLOR: navy">Property</span><font color="#000000"> Street</font>
</address></street><font color="#000000">() </font><span style="COLOR: navy">As</span><font color="#000000"> </font><span style="COLOR: navy">String
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">            </font></span><span style="COLOR: navy">Get
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">                </font></span><span style="COLOR: navy">Return</span><font color="#000000"> _street
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">            </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">Get
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">            </font></span><span style="COLOR: navy">Set</span><font color="#000000">(</font><span style="COLOR: navy">ByVal</span><font color="#000000"> value </font><span style="COLOR: navy">As</span><font color="#000000"> </font><span style="COLOR: navy">String</span><font color="#000000">)
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-spacerun: yes">                </span>_street = value
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">            </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">Set
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">        </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">Property
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><span style="mso-spacerun: yes"><font color="#000000">    </font></span><span style="COLOR: navy">End</span><font color="#000000"> </font><span style="COLOR: navy">Class
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 10pt; BACKGROUND: white; COLOR: navy; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes">End</span><span style="FONT-SIZE: 10pt; BACKGROUND: white; FONT-FAMILY: Consolas; mso-highlight: white; mso-no-proof: yes"><font color="#000000"> </font><span style="COLOR: navy">Class
</span></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt">
<font face="Times New Roman" color="#000000" size="3"> </font>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt">
There, that was easy, huh? (In case you're not seeing it, look for the CRASHHERE note.)

Kids, don't try this at home.

Chances are, it will work for you anyway. I just checked with one of my co-workers and it works just fine for him. Great.

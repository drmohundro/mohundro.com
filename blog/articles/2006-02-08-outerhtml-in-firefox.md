
title: "outerHTML in Firefox"
author: David
date: 2006/02/08

<P>Now this is different, eh? A post on JavaScript instead of .NET! This is a little trick I came up with to add outerHTML functionality in Firefox. For those who aren't familiar with outerHTML, it is an IE addition to the DOM that will return the element's HTML PLUS it's innerHTML. Is it really needed? No, but it can help with debugging sometimes. Here's the code:</P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; COLOR: navy; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">if</SPAN><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><FONT color=#000000> (document.body.__defineGetter__) {<?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p></o:p></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><SPAN style="mso-tab-count: 1"><FONT color=#000000>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT></SPAN><SPAN style="COLOR: navy">if</SPAN><FONT color=#000000> (HTMLElement) {<o:p></o:p></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><SPAN style="mso-tab-count: 2"><FONT color=#000000>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT></SPAN><SPAN style="COLOR: navy">var</SPAN><FONT color=#000000> element = HTMLElement.prototype;<o:p></o:p></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><SPAN style="mso-tab-count: 2"><FONT color=#000000>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT></SPAN><SPAN style="COLOR: navy">if</SPAN><FONT color=#000000> (element.__defineGetter__) {<o:p></o:p></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><FONT color=#000000><SPAN style="mso-tab-count: 3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>element.__defineGetter__(</FONT><SPAN style="COLOR: maroon">"outerHTML"</SPAN><FONT color=#000000>,<o:p></o:p></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><SPAN style="mso-tab-count: 4"><FONT color=#000000>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT></SPAN><SPAN style="COLOR: navy">function</SPAN><FONT color=#000000> () {<o:p></o:p></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><SPAN style="mso-tab-count: 5"><FONT color=#000000>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT></SPAN><SPAN style="COLOR: navy">var</SPAN><FONT color=#000000> parent = </FONT><SPAN style="COLOR: navy">this</SPAN><FONT color=#000000>.parentNode;<o:p></o:p></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><SPAN style="mso-tab-count: 5"><FONT color=#000000>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT></SPAN><SPAN style="COLOR: navy">var</SPAN><FONT color=#000000> el = document.createElement(parent.tagName);<o:p></o:p></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><FONT color=#000000><SPAN style="mso-tab-count: 5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>el.appendChild(</FONT><SPAN style="COLOR: navy">this</SPAN><FONT color=#000000>);<o:p></o:p></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><SPAN style="mso-tab-count: 5"><FONT color=#000000>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT></SPAN><SPAN style="COLOR: navy">var</SPAN><FONT color=#000000> shtml = el.innerHTML;<o:p></o:p></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><FONT color=#000000><SPAN style="mso-tab-count: 5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>parent.appendChild(</FONT><SPAN style="COLOR: navy">this</SPAN><FONT color=#000000>);<o:p></o:p></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><SPAN style="mso-tab-count: 5"><FONT color=#000000>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT></SPAN><SPAN style="COLOR: navy">return</SPAN><FONT color=#000000> shtml;<o:p></o:p></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><FONT color=#000000><SPAN style="mso-tab-count: 4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>}<o:p></o:p></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><FONT color=#000000><SPAN style="mso-tab-count: 3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>);<o:p></o:p></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><FONT color=#000000><SPAN style="mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>}<o:p></o:p></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><FONT color=#000000><SPAN style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>}<o:p></o:p></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><SPAN style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><FONT color=#000000>}<o:p></o:p></FONT></SPAN></P>
<P>This entire thing revolves around the __defineGetter__ method off of objects. To be honest, I don't know if it is standard JavaScript or if it is just a Mozilla extension. It makes extending the DOM a lot easier, though. I probably wouldn't trust this in a production environment, but I wouldn't hesitate to use it for testing.</P>
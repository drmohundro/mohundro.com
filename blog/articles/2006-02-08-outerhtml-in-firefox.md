
title: "outerHTML in Firefox"
author: David
date: 2006/02/08

Now this is different, eh? A post on JavaScript instead of .NET! This is a little trick I came up with to add outerHTML functionality in Firefox. For those who aren't familiar with outerHTML, it is an IE addition to the DOM that will return the element's HTML PLUS it's innerHTML. Is it really needed? No, but it can help with debugging sometimes. Here's the code:
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; COLOR: navy; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes">if</span><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"> (document.body.__defineGetter__) {<?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" />
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-tab-count: 1"><font color="#000000">       </font></span><span style="COLOR: navy">if</span><font color="#000000"> (HTMLElement) {
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-tab-count: 2"><font color="#000000">              </font></span><span style="COLOR: navy">var</span><font color="#000000"> element = HTMLElement.prototype;
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-tab-count: 2"><font color="#000000">              </font></span><span style="COLOR: navy">if</span><font color="#000000"> (element.__defineGetter__) {
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-tab-count: 3">                     </span>element.__defineGetter__(</font><span style="COLOR: maroon">"outerHTML"</span><font color="#000000">,
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-tab-count: 4"><font color="#000000">                           </font></span><span style="COLOR: navy">function</span><font color="#000000"> () {
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-tab-count: 5"><font color="#000000">                                  </font></span><span style="COLOR: navy">var</span><font color="#000000"> parent = </font><span style="COLOR: navy">this</span><font color="#000000">.parentNode;
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-tab-count: 5"><font color="#000000">                                  </font></span><span style="COLOR: navy">var</span><font color="#000000"> el = document.createElement(parent.tagName);
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-tab-count: 5">                                  </span>el.appendChild(</font><span style="COLOR: navy">this</span><font color="#000000">);
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-tab-count: 5"><font color="#000000">                                  </font></span><span style="COLOR: navy">var</span><font color="#000000"> shtml = el.innerHTML;
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-tab-count: 5">                                  </span>parent.appendChild(</font><span style="COLOR: navy">this</span><font color="#000000">);
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><span style="mso-tab-count: 5"><font color="#000000">                                  </font></span><span style="COLOR: navy">return</span><font color="#000000"> shtml;
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-tab-count: 4">                           </span>}
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-tab-count: 3">                     </span>);
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-tab-count: 2">              </span>}
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000"><span style="mso-tab-count: 1">       </span>}
</font></span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; BACKGROUND: white; FONT-FAMILY: 'Courier New'; mso-highlight: white; mso-no-proof: yes"><font color="#000000">}
</font></span>

This entire thing revolves around the __defineGetter__ method off of objects. To be honest, I don't know if it is standard JavaScript or if it is just a Mozilla extension. It makes extending the DOM a lot easier, though. I probably wouldn't trust this in a production environment, but I wouldn't hesitate to use it for testing.

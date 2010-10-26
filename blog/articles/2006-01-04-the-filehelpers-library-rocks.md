
title: "The FileHelpers library ROCKS!"
author: David
date: 2006/01/04

<p>My post earlier today referred to the <a href="http://filehelpers.sourceforge.net/">FileHelpers</a> library by Marcos Meli.</p>
<p>Wow, do I wish I had known about this earlier. This thing is great! With a few easy attributes, you can use a business object as a layout for fixed-length files! Okay, I guess an example would help. Here's some VB code I whipped up to test this library out.</p>
<p>

</p><p class="MsoNormal" style=""><span style="background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: &quot;Courier New&quot;; color: navy; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;">Imports</span><span style="background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: &quot;Courier New&quot;; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;"> FileHelpers<o:p></o:p></span></p>









<p class="MsoNormal" style=""><span style="background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: &quot;Courier New&quot;; color: navy; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;">Public</span><span style="background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: &quot;Courier New&quot;; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;"> <span style="color: navy;">Class</span> MainForm<br><span style="">&nbsp;&nbsp;&nbsp; </span><span style="color: navy;">Private</span> <span style="color: navy;">Sub</span>
MainForm_Load(<span style="color: navy;">ByVal</span> sender <span style="color: navy;">As</span> <span style="color: navy;">Object</span>, _<br><span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="color: navy;">ByVal</span> e <span style="color: navy;">As</span>
System.EventArgs) <span style="color: navy;">Handles</span> <span style="color: navy;">Me</span>.Load<o:p><br></o:p></span></p>



<p class="MsoNormal" style=""><span style="background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: &quot;Courier New&quot;; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;"><span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="color: navy;">Dim</span> engine <span style="color: navy;">As</span> <span style="color: navy;">New</span> FileHelperEngine(<span style="color: navy;">GetType</span>(Record))<o:p><br></o:p></span></p>







<p class="MsoNormal" style=""><span style="background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: &quot;Courier New&quot;; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;"><span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="color: navy;">Dim</span> records() <span style="color: navy;">As</span>
Record = _<br><span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="color: navy;">DirectCast</span>(engine.ReadString(<span style="color: maroon;">"123456789<span style="">&nbsp; </span>2005-01-01"</span>), _<br><span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>Record())<o:p> <br></o:p></span></p>



<p class="MsoNormal" style=""><span style="background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: &quot;Courier New&quot;; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;"><span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>Debugger.Break()<o:p><br></o:p></span></p>



<p class="MsoNormal" style=""><span style="background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: &quot;Courier New&quot;; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;"><span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="color: navy;">Dim</span> res <span style="color: navy;">As</span> <span style="color: navy;">String</span> = engine.WriteString(records)<o:p><br></o:p></span></p>





<p class="MsoNormal" style=""><span style="background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: &quot;Courier New&quot;; color: navy; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;"><span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>Debugger.Break()<br><span style="">&nbsp;&nbsp;&nbsp; </span><span style="color: navy;">End</span> <span style="color: navy;">Sub</span><br>End</span><span style="background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: &quot;Courier New&quot;; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;"> <span style="color: navy;">Class<o:p></o:p></span></span></p>













<p class="MsoNormal" style=""><span style="background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: &quot;Courier New&quot;; color: navy; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;"><o:p></o:p>&lt;FixedLengthRecord()&gt; _<br>Public</span><span style="background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: &quot;Courier New&quot;; color: navy; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;"> <span style="color: navy;">Class</span> Record<o:p></o:p><br><span style="">&nbsp;&nbsp;&nbsp;
</span>&lt;FieldFixedLength(<span style="color: red;">11</span>)&gt; _<br><span style="">&nbsp;&nbsp;&nbsp; </span><span style="color: navy;">Public</span> BillNumber <span style="color: navy;">As</span> <span style="color: navy;">String</span><o:p> <br></o:p></span></p>







<p class="MsoNormal"><span style="background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: &quot;Courier New&quot;; color: navy; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;"><span style="">&nbsp;&nbsp;&nbsp;
</span>&lt;FieldFixedLength(<span style="color: red;">10</span>), _<br><span style="">&nbsp;&nbsp;&nbsp;
</span>FieldConverter(ConverterKind.Date, <span style="color: maroon;">"yyyy-MM-dd"</span>)&gt;
_<br><span style="">&nbsp;&nbsp;&nbsp; </span><span style="color: navy;">Public</span> BillDate <span style="color: navy;">As</span>
DateTime<br>End</span><span style="background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: &quot;Courier New&quot;; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;"> <span style="color: navy;">Class</span></span><span style="font-family: &quot;Courier New&quot;;"><o:p></o:p></span></p>


<p><span style="font-size: 11px; color: black; font-family: Courier New; background-color: transparent;"><span style="font-size: 11px; color: blue; font-family: Courier New; background-color: transparent;"><font color="#000000" face="Verdana" size="2">At each Debugger.Break line, I checked my values and this thing is great. records(0).BillNumber is "123456789&nbsp; " and records(0).BillDate is a converted&nbsp;DateTime set to 1/1/2005.</font></span></span></p>
<p><span style="font-size: 11px; color: black; font-family: Courier New; background-color: transparent;"><span style="font-size: 11px; color: blue; font-family: Courier New; background-color: transparent;"><font color="#000000" face="Verdana" size="2">If you deal with fixed-length or delimited files on a regular basis, this library might be a great option for you.</font></span></span></p>
<p><span style="font-size: 11px; color: black; font-family: Courier New; background-color: transparent;"><span style="font-size: 11px; color: blue; font-family: Courier New; background-color: transparent;"><font color="#000000" face="Verdana" size="2">Thanks Marcos!</font></span></span></p><p><span style="font-size: 11px; color: black; font-family: Courier New; background-color: transparent;"><span style="font-size: 11px; color: blue; font-family: Courier New; background-color: transparent;"><font color="#000000" face="Verdana" size="2"><font color="#ff0000">UPDATE: Version 1.3.1 was released recently, so I have updated my example code to use the new ReadString and WriteString methods.</font><br></font></span></span></p>

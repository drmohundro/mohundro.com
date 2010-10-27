
title: "The FileHelpers library ROCKS!"
author: David
date: 2006/01/04

My post earlier today referred to the [FileHelpers](http://filehelpers.sourceforge.net/) library by Marcos Meli.

Wow, do I wish I had known about this earlier. This thing is great! With a few easy attributes, you can use a business object as a layout for fixed-length files! Okay, I guess an example would help. Here's some VB code I whipped up to test this library out.




<p class="MsoNormal" style=""><span style='background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: "Courier New"; color: navy; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;'>Imports</span><span style='background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: "Courier New"; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;'> FileHelpers
</span>









<p class="MsoNormal" style=""><span style='background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: "Courier New"; color: navy; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;'>Public</span><span style='background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: "Courier New"; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;'> <span style="color: navy;">Class</span> MainForm<br><span style="">    </span><span style="color: navy;">Private</span> <span style="color: navy;">Sub</span>
MainForm_Load(<span style="color: navy;">ByVal</span> sender <span style="color: navy;">As</span> <span style="color: navy;">Object</span>, _<br><span style="">        </span><span style="color: navy;">ByVal</span> e <span style="color: navy;">As</span>
System.EventArgs) <span style="color: navy;">Handles</span> <span style="color: navy;">Me</span>.Load
<br></span>



<p class="MsoNormal" style=""><span style='background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: "Courier New"; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;'><span style="">        </span><span style="color: navy;">Dim</span> engine <span style="color: navy;">As</span> <span style="color: navy;">New</span> FileHelperEngine(<span style="color: navy;">GetType</span>(Record))
<br></span>







<p class="MsoNormal" style=""><span style='background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: "Courier New"; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;'><span style="">        </span><span style="color: navy;">Dim</span> records() <span style="color: navy;">As</span>
Record = _<br><span style="">            </span><span style="color: navy;">DirectCast</span>(engine.ReadString(<span style="color: maroon;">"123456789<span style="">  </span>2005-01-01"</span>), _<br><span style="">           
</span>Record())
<br></span>



<p class="MsoNormal" style=""><span style='background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: "Courier New"; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;'><span style="">       
</span>Debugger.Break()
<br></span>



<p class="MsoNormal" style=""><span style='background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: "Courier New"; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;'><span style="">        </span><span style="color: navy;">Dim</span> res <span style="color: navy;">As</span> <span style="color: navy;">String</span> = engine.WriteString(records)
<br></span>





<p class="MsoNormal" style=""><span style='background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: "Courier New"; color: navy; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;'><span style="">       
</span>Debugger.Break()<br><span style="">    </span><span style="color: navy;">End</span> <span style="color: navy;">Sub</span><br>End</span><span style='background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: "Courier New"; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;'> <span style="color: navy;">Class
</span></span>













<p class="MsoNormal" style=""><span style='background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: "Courier New"; color: navy; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;'>
&lt;FixedLengthRecord()&gt; _<br>Public</span><span style='background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: "Courier New"; color: navy; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;'> <span style="color: navy;">Class</span> Record

<br><span style="">   
</span>&lt;FieldFixedLength(<span style="color: red;">11</span>)&gt; _<br><span style="">    </span><span style="color: navy;">Public</span> BillNumber <span style="color: navy;">As</span> <span style="color: navy;">String</span>
<br></span>







<p class="MsoNormal"><span style='background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: "Courier New"; color: navy; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;'><span style="">   
</span>&lt;FieldFixedLength(<span style="color: red;">10</span>), _<br><span style="">   
</span>FieldConverter(ConverterKind.Date, <span style="color: maroon;">"yyyy-MM-dd"</span>)&gt;
_<br><span style="">    </span><span style="color: navy;">Public</span> BillDate <span style="color: navy;">As</span>
DateTime<br>End</span><span style='background: white none repeat scroll 0% 50%; font-size: 10pt; font-family: "Courier New"; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;'> <span style="color: navy;">Class</span></span><span style='font-family: "Courier New";'>
</span>



<span style="font-size: 11px; color: black; font-family: Courier New; background-color: transparent;"><span style="font-size: 11px; color: blue; font-family: Courier New; background-color: transparent;"><font color="#000000" face="Verdana" size="2">At each Debugger.Break line, I checked my values and this thing is great. records(0).BillNumber is "123456789  " and records(0).BillDate is a converted DateTime set to 1/1/2005.</font></span></span>

<span style="font-size: 11px; color: black; font-family: Courier New; background-color: transparent;"><span style="font-size: 11px; color: blue; font-family: Courier New; background-color: transparent;"><font color="#000000" face="Verdana" size="2">If you deal with fixed-length or delimited files on a regular basis, this library might be a great option for you.</font></span></span>

<span style="font-size: 11px; color: black; font-family: Courier New; background-color: transparent;"><span style="font-size: 11px; color: blue; font-family: Courier New; background-color: transparent;"><font color="#000000" face="Verdana" size="2">Thanks Marcos!</font></span></span>

<span style="font-size: 11px; color: black; font-family: Courier New; background-color: transparent;"><span style="font-size: 11px; color: blue; font-family: Courier New; background-color: transparent;"><font color="#000000" face="Verdana" size="2"><font color="#ff0000">UPDATE: Version 1.3.1 was released recently, so I have updated my example code to use the new ReadString and WriteString methods.</font><br></font></span></span>

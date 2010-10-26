
title: "Windows Forms Validation"
author: David
date: 2006/01/11

<P>I've been doing some research on best practices for validation in Windows Forms, and I came across a nice set of <A href="http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnforms/html/winforms05182004.asp">MSDN articles</A> by <A href="http://www.mikedub.net/">Michael Weinhardt</A>&nbsp;where he shows how to create a validation framework that is very similar to the validators found in ASP.NET (i.e. required field validator, regular expression validator, etc). It includes container and form validators that basically manage&nbsp;the control validators&nbsp;already on the form.&nbsp;The link to the articles is to the third article in the series, but the download contains all of the source. His code was apparently incorporated into the <A href="http://www.genghisgroup.com/">Genghis framework</A> as well.</P>
<P>I'm interested in something similar for 2.0, but I haven't found anything. I did see an older <A href="http://www.sellsbrothers.com/spout/#My_Product_Group_Fun:_2">post</A> from Chris Sells&nbsp;about moving Genghis over to 2.0, but I haven't seen any updates on that. I'm considering doing it myself, but if anyone has any better ideas, I'm open.</P>

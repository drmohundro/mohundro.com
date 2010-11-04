
title: "Windows Forms Validation"
author: David
date: 2006/01/12
categories: .net

I've been doing some research on best practices for validation in Windows Forms, and I came across a nice set of [MSDN articles](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnforms/html/winforms05182004.asp) by [Michael Weinhardt](http://www.mikedub.net/) where he shows how to create a validation framework that is very similar to the validators found in ASP.NET (i.e. required field validator, regular expression validator, etc). It includes container and form validators that basically manage the control validators already on the form. The link to the articles is to the third article in the series, but the download contains all of the source. His code was apparently incorporated into the [Genghis framework](http://www.genghisgroup.com/) as well.

I'm interested in something similar for 2.0, but I haven't found anything. I did see an older [post](http://www.sellsbrothers.com/spout/#My_Product_Group_Fun:_2) from Chris Sells about moving Genghis over to 2.0, but I haven't seen any updates on that. I'm considering doing it myself, but if anyone has any better ideas, I'm open.


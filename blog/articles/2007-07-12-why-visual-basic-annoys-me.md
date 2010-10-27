
title: "Why Visual Basic annoys me"
author: David
date: 2007/07/12

Visual Basic annoys me because of the way arrays are initialized. 
What's the semantic difference between the two lines of code below? 
C#
<pre>int[] test = new int[10];</pre>

VB.NET
<pre>Dim test(10) As Integer</pre>

Here's a hint - one array has ten items and one does not. The VB.NET array has <em>eleven</em> elements. When you declare an array in VB.NET, you're specifying the upper bounds of the array instead of the length. This drives me insane. We regularly go between C# and VB.NET and I am constantly bit by this one.

I was talking with a guy at work today and we discussed how we'd like to have another option setting (in addition to Option Strict and Option Explicit) available for VB.NET: 
<pre>Option OperateLikeAllOtherLanguages = True</pre>

This setting would allow VB.NET to initialize arrays like all other languages.

<strong>NOTE</strong>: This post is <em>satire</em>. I still like to program in VB.NET and C#. I do not want to get into which language is better. Both languages have their virtues. Learn them both. Then go learn Ruby.

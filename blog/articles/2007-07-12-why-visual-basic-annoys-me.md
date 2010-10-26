
title: "Why Visual Basic annoys me"
author: David
date: 2007/07/12

<p>Visual Basic annoys me because of the way arrays are initialized.</p> <p>What's the semantic difference between the two lines of code below?</p> <p>C#</p><pre>int[] test = new int[10];</pre>
<p>VB.NET</p><pre>Dim test(10) As Integer</pre>
<p>Here's a hint - one array has&nbsp;ten items and one does not. The VB.NET array has <em>eleven</em> elements. When you declare an array in VB.NET, you're specifying the upper bounds of the array instead of the length. This drives me insane.&nbsp;We regularly go between C# and VB.NET and I am constantly bit by this one.</p>
<p>I was talking with a guy at work today and we discussed how we'd like to have another option setting (in addition to Option Strict and Option Explicit)&nbsp;available for VB.NET: </p><pre>Option OperateLikeAllOtherLanguages = True</pre>
<p>This setting would allow VB.NET to initialize arrays like all other languages.</p>
<p><strong>NOTE</strong>: This post is <em>satire</em>. I still like to program in VB.NET and C#. I do not want to get into which language is better. Both languages have their virtues. Learn them both. Then go learn Ruby.</p>

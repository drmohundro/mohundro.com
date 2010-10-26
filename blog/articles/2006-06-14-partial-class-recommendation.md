
title: "Partial class recommendation"
author: David
date: 2006/06/14

<P>We were working with partial classes recently at work and we came up with a best practice usage for naming them, at lease for our needs, and I thought I would share it with you.</P>
<P>Basically, do it the way Visual Studio does. For example, with GUI components such as forms, VS2005 names the main class Form1.vb, while it names the partial class Form1.designer.vb. So, if you want to make your Shipment class have a partial piece, have a file that is Shipper.vb and Shipper.stuff.vb.</P>
<P>This way, it is clear by the naming that the files are related. Otherwise, I would think there would be a lot of confusion on how the files are related.</P>
<P>Any thoughts on this?</P>

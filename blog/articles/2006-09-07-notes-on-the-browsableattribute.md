
title: "Notes on the BrowsableAttribute"
author: David
date: 2006/09/07
categories: .net;visual studio
guid: ade0b965-1abd-4fde-ab2b-085aaf80f61d

When you're creating a GUI control in Visual Studio, your public properties will be displayed in the Property Grid and you can customize this by using attributes such as the Category attribute or the DisplayName attribute. Another nice attribute to use sometimes is the Browsable attribute. If you set the Browsable attribute to false (i.e. &lt;Browsable(False)&gt; in VB.NET), it won't be displayed in the property grid. I typically use this to hide properties that really have no function from the GUI side. 

Here's the point of the post though: even if you set a property's Browsable attribute to false, it will still be accessed by the designer. In other words, if you've got code like a Debug.Assert or something in there, it will still fire, regardless of the Browsable attribute's value. So, you might consider putting a DesignMode check around code like that because it will give you some weird behavior when running in the designer. 

**UPDATE:**

No one ever told me about the DesignerSerializationVisibilityAttribute! You can set DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden) on a property and it won't get serialized into code!


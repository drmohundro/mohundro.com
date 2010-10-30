
title: "What code that you've written are you proud of?"
author: David
date: 2007/09/25

Yesterday, I had a somewhat strange experience. I was helping someone with a problem they were having and, almost as a side note, this individual thought he would share some code with me that he was particularly proud of. He even prefaced the story with the "not to brag or anything" phrase. He had written some custom code to help text boxes grow or shrink depending on how the user resized the window. If you know anything about WinForms, you'll know that some simple anchoring techniques and good use of the SplitContainer will solve this problem for you - please, please, please don't go writing custom mathematical equations when the framework can take care of it for you. 

At the time, I was pretty annoyed with it, because this individual was bragging about something that I considered "the wrong way to do it." In retrospect, this probably was the wrong response. Why? Because he was proud of some of the code he had written. He actually cared about it enough to not just treat it as something to toss off on to someone else when he moved to the next project.

The projects that have turned out best that I've worked on the ones where I was really proud of the code. That doesn't mean I did it the right way. I'm thinking of one example where I wrote this crazy elaborate dynamic menu system in JavaScript. It even worked in both Firefox and Internet Explorer. It had a full blown object model and made use of closures and more - it was great. Here's a complete example of usage of the menu:

    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html>
    <head>
    <title>clsNavBar</title>
    <script language="JavaScript" src="clsMenu.js"></script>
    <link href="styles.css" rel="stylesheet" type="text/css">
    </head>

    <body>
    <script language="JavaScript">
    var nav = new clsMenu();
    nav.setContainer(document.body);
    nav.setXMLUrl("NavBar.xml");
    //nav.setHorizontal(false)
    nav.buildMenu();
    </script>
    </body>
    </html>

It had one problem. Maintenance. Maintenance on the system will be nigh impossible for the next guy. From the very beginning, I should have used CSS for the entire menu structure. When and if someone ever decides to change the way the menus look, well... good luck. However, it was still a good experience. I learned more about the inner workings of JavaScript from working with that than I did from any blog post or book I've ever looked at. I would have never learned what exactly 'this' references in JavaScript without that example (see [this post on JavaScript gotchas](http://www.fitzblog.com/tabid/17782/bid/2127/Nine-Javascript-Gotchas.aspx) and refer to the section on 'this'). 

In all of this, I have learned to be very careful of the code I'm proud of. Inevitably, if you're growing as a developer by "[sucking less every year](http://www.codinghorror.com/blog/archives/000530.html)," you're not going to be too proud of your code in a year or two anyway. 

Do you have any code you're particularly proud of? If it turned out to be the "wrong way to do it" but you learned a lot from the experience, you get bonus points.

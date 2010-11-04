
title: "outerHTML in Firefox"
author: David
date: 2006/02/09
categories: javascript

Now this is different, eh? A post on JavaScript instead of .NET! This is a little trick I came up with to add outerHTML functionality in Firefox. For those who aren't familiar with outerHTML, it is an IE addition to the DOM that will return the element's HTML PLUS it's innerHTML. Is it really needed? No, but it can help with debugging sometimes. Here's the code:

    if (document.body.__defineGetter__) {
      if (HTMLElement) {
        var element = HTMLElement.prototype;
        if (element.__defineGetter__) {
          element.__defineGetter__("outerHTML", function() {
            var parent = this.parentNode;
            var el = document.createElement(parent.tagName);
            el.appendChild(this);
            var shtml = el.innerHTML;
            parent.appendChild(this);
            return shtml;
          });
        }
      }
    }

This entire thing revolves around the __defineGetter__ method off of objects. To be honest, I don't know if it is standard JavaScript or if it is just a Mozilla extension. It makes extending the DOM a lot easier, though. I probably wouldn't trust this in a production environment, but I wouldn't hesitate to use it for testing.


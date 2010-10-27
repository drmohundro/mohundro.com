
title: "Designer and property fun!"
author: David
date: 2006/01/02

I ran into a strange situation this afternoon with visual inheritance and threading. I've created a master form for my area at work so that we can have a common menu in all of our applications. It also provides a public readonly property that has information about the currently logged on user. The user's information is pulled using a BackgroundWorker so that the form can display promptly.

Here's the situation, a few days ago, I added a ManualResetEvent so that, if access to the User property was attempted before the thread completed, a NullReferenceException wouldn't occur. I had already put code in so that the initial loading of the user's information would not fire in design mode. The problem that began happening was that, every time I tried to open a form that inherited from my master form, Visual Studio would lock up. I pulled up a second devenv to see where the hanging was occurring and, sure enough, it was sitting on my ManualResetEvent inside my user property. Why in the world was the designer accessing my user property?

The more astute (or experienced) of you will realize that I hadn't marked my property with that oh so important System.ComponentModel.Browsable(False) attribute! The designer was accessing the property so that it could display it in the Properties Window!

Let me be an example of what perils can occur when you play with visual inheritance and the designer!

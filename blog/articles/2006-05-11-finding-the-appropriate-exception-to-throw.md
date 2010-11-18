
title: "Finding the appropriate exception to throw..."
author: David
date: 2006/05/11
categories: .net;programming;visual studio
guid: 92d64c50-8ff9-489f-890f-8ac13799b7a7

Prompted primarily by [Karl Sequin](http://codebetter.com/blogs/karlseguin/default.aspx)'s excellent ["Understanding and Using Exceptions" post](http://codebetter.com/blogs/karlseguin/archive/2006/04/05/142355.aspx), I was recently attempting to clean up some of the generic exceptions being throw in some code and I was having trouble deciding which exception to use.

I had a BackgroundWorker that could potentially throw an exception (can't everything?) that was doing some remoting to another process. As additional information, the BackgroundWorker exposes any exceptions that might occur in the Error property off of the RunWorkerCompletedEventArgs. I didn't want to just throw e.Error because, as Karl points out, this modifies the call stack making it look my code was the source of the exception. At the same time, I couldn't just use throw, because the exception had basically already been caught and been given to me to handle.

I ended up pulling up the Object Browser in Visual Studio and filtered the list down by searching on "exception" - a nice trick to see all currently accessible exceptions. I ended up using the System.Runtime.Remoting.RemotingException, because it described exactly what I was looking at. Here's the description for it:

> Public Class RemotingException<br />
> Inherits System.SystemException<br />
> Member of: System.Runtime.Remoting<br />
> Summary:<br />
> The exception that is thrown when something has gone wrong during remoting.

If you exclude the "during remoting" part, it basically describes any exception that can be thrown. It's almost funny in a way, because that's exactly the type of thing I was looking for. I was able to set the InnerException to my e.Error which provided me with all the information I needed.


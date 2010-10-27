
title: "Finding the appropriate exception to throw..."
author: David
date: 2006/05/10

Prompted primarily by [Karl Sequin](http://codebetter.com/blogs/karlseguin/default.aspx)'s excellent ["Understanding and Using Exceptions" post](http://codebetter.com/blogs/karlseguin/archive/2006/04/05/142355.aspx), I was recently attempting to clean up some of the generic exceptions being throw in some code and I was having trouble deciding which exception to use.

I had a BackgroundWorker that could potentially throw an exception (can't everything?) that was doing some remoting to another process. As additional information, the BackgroundWorker exposes any exceptions that might occur in the Error property off of the RunWorkerCompletedEventArgs. I didn't want to just throw e.Error because, as Karl points out, this modifies the call stack making it look my code was the source of the exception. At the same time, I couldn't just use throw, because the exception had basically already been caught and been given to me to handle.

I ended up pulling up the Object Browser in Visual Studio and filtered the list down by searching on "exception" - a nice trick to see all currently accessible exceptions. I ended up using the System.Runtime.Remoting.RemotingException, because it described exactly what I was looking at. Here's the description for it:
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; COLOR: black; FONT-FAMILY: Tahoma">Public Class <b>RemotingException</b><?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" />
</span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; COLOR: black; FONT-FAMILY: Tahoma"><span style="mso-spacerun: yes">          </span>Inherits </span><b><u><span style="FONT-SIZE: 9pt; COLOR: #215dc6; FONT-FAMILY: Tahoma">System</span></u></b><span style="FONT-SIZE: 9pt; COLOR: black; FONT-FAMILY: Tahoma">.</span><b><u><span style="FONT-SIZE: 9pt; COLOR: #215dc6; FONT-FAMILY: Tahoma">SystemException</span></u></b><span style="FONT-SIZE: 9pt; COLOR: black; FONT-FAMILY: Tahoma">
</span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><span style="FONT-SIZE: 9pt; COLOR: black; FONT-FAMILY: Tahoma"><span style="mso-spacerun: yes">     </span>Member of: </span><b><u><span style="FONT-SIZE: 9pt; COLOR: #215dc6; FONT-FAMILY: Tahoma">System</span></u></b><span style="FONT-SIZE: 9pt; COLOR: black; FONT-FAMILY: Tahoma">.</span><b><u><span style="FONT-SIZE: 9pt; COLOR: #215dc6; FONT-FAMILY: Tahoma">Runtime</span></u></b><span style="FONT-SIZE: 9pt; COLOR: black; FONT-FAMILY: Tahoma">.</span><b><u><span style="FONT-SIZE: 9pt; COLOR: #215dc6; FONT-FAMILY: Tahoma">Remoting</span></u></b><span style="FONT-SIZE: 9pt; COLOR: black; FONT-FAMILY: Tahoma">
</span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt; mso-layout-grid-align: none"><b><span style="FONT-SIZE: 9pt; COLOR: black; FONT-FAMILY: Tahoma">Summary:</span></b><span style="FONT-SIZE: 9pt; COLOR: black; FONT-FAMILY: Tahoma">
</span>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt"><span style="FONT-SIZE: 9pt; COLOR: black; FONT-FAMILY: Tahoma">The exception that is thrown when something has gone wrong during remoting.</span>




If you exclude the "during remoting" part, it basically describes any exception that can be thrown. It's almost funny in a way, because that's exactly the type of thing I was looking for. I was able to set the InnerException to my e.Error which provided me with all the information I needed.

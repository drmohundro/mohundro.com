
title: "Neat LINQ statement to move newer files from the network"
author: David
date: 2008/12/03

<p>Thought I’d share the below LINQ statement I wrote recently:</p><pre class="brush: csharp;">var filesToBeMoved =  
    from networkFile in network  
    join localFile in local  
        on networkFile.Name equals localFile.Name into localToNetwork  
    from localMatchesNetwork in localToNetwork.DefaultIfEmpty()  
    // Handle files that are on the network but don't exist locally  
    where localMatchesNetwork == null  
          // Handle files that are newer on the network that they are locally  
          || (localMatchesNetwork.LastWriteTime &lt; networkFile.LastWriteTime)  
    select networkFile;  
  
foreach (var file in filesToBeMoved)  
    file.MoveTo(_directoryProvider.LocalDirectory);
</pre>
<p>In this case, the files that are being returned are actually IFileProvider instances, which are basically wrappers around the System.IO.File instances for testability.</p>
<p>Oh, and this post is an excuse to see if I set <a href="http://code.google.com/p/syntaxhighlighter/">SyntaxHighlighter</a> up correctly :-)</p>
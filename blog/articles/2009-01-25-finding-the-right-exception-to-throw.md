
title: "Finding the right exception to throw"
author: David
date: 2009/01/25

If you've been writing .NET applications for a while, you're likely aware that [you're not supposed to just throw Exception](http://msdn.microsoft.com/en-us/library/ms229021.aspx). Instead, if you're dealing with a null argument, you should be throwing an ArgumentNullException instead. FxCop warns against cases like this. 

My problem isn't knowing to not throw Exception. My problem is finding the appropriate exception to throw. 

Just about every time I need to throw an exception in code, I type something like throw new… then wait for intellisense, and then inevitably try to type something like \*Exception. Which fails of course. Then I do a google search for common exception types and will come across a post like [Brad Abram's Common Exception Types](http://blogs.msdn.com/brada/archive/2005/03/27/402801.aspx). Which is somewhat useful, except that his list only contains Exception names including Exceptions like the [InvalidProgramException](http://msdn.microsoft.com/en-us/library/system.invalidprogramexception.aspx), which has a description of "the exception that is thrown when a program contains invalid MSIL." Most likely not what I need :-) [Jeff Atwood has an older post about a console application he wrote to write out Exception types from assemblies](http://www.codinghorror.com/blog/archives/000115.html), but once again, it doesn't provide the description I needed to help make my decision, too. 

So, I decided to solve this problem myself. 

I liked Jeff's approach because it was lightweight and could be piped to programs like findstr so that I could look for certain types of exceptions. I essentially wanted what he had, but I wanted summary information as well. I ended up solving the problem with PowerShell. First, check out the output:

    [3] » Get-Exception Null | Format-List

    Name    : System.ArgumentNullException
    Summary : The exception that is thrown when a null reference (Nothing in Visual Basic) is passed to a method that does not
              accept it as a valid argument.

    Name    : System.NullReferenceException
    Summary : The exception that is thrown when there is an attempt to dereference a null object reference.

    Name    : System.Management.Automation.PSArgumentNullException
    Summary : No summary found.

    Name    : System.Data.NoNullAllowedException
    Summary : No summary found.

    Name    : System.Data.SqlTypes.SqlNullValueException
    Summary : No summary found.

As you can see, my script is called Get-Exception and it can handle searches. The results can be passed to the various formatting cmdlets like Format-List. You can also pipe the results to Select-String for further searching if you wish or just pipe it to a Where statement.

The script itself is fairly simple. The pulling of exception types is based entirely off of the following statement:

    $exceptions = [System.AppDomain]::CurrentDomain.GetAssemblies() | foreach {   
        $_.GetTypes() | where { $_.FullName -match "System$filter.*Exception$" }  
    }

To pull the summary documentation, I'm using the returned type's Assembly.Location property and checking for an XML file with the same name at the same location. This usually equates to an XML file in C:\windows\microsoft.net\framework\v2.0.50727. Then I use an XPath expression against it.

I've posted the script out on the [PowerShell Code Repository](http://poshcode.org/) at [http://poshcode.org/827](http://poshcode.org/827) if you're interested in downloading it and trying it out. There are a lot of other great scripts there as well.

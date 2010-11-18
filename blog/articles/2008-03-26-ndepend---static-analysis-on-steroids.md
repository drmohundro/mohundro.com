
title: "NDepend - Static analysis on steroids"
author: David
date: 2008/03/26
categories: .net;general;utilities
guid: c1eccfb3-6085-4469-83e0-01d2c630f4ca

If you've been working with the .NET Framework for a while, you're hopefully already using some form of static analysis to help you catch problems with your code. One of the most well known is Microsoft's [FxCop](http://msdn2.microsoft.com/en-us/library/bb429476(VS.80).aspx), which is now integrated as the Code Analysis feature in Visual Studio 2005 <sup>[1]</sup> and up. If you're not already using this tool, then please start because it can help you find problem areas like potential NullReferenceExceptions as well as globalization and security issues. 

However, while FxCop is great at catching small problems and details, it isn't the best tool to see the big picture regarding your software. Enter [NDepend](http://www.ndepend.com/) by [Patrick Smacchia](http://codebetter.com/blogs/patricksmacchia/). Chances are, you've already read [Scott Hanselman](http://www.hanselman.com/blog/)'s [great review of NDepend](http://www.hanselman.com/blog/ExitingTheZoneOfPainStaticAnalysisWithNDepend.aspx) a while back (or heard [his podcast on static analysis with NDepend](http://www.hanselman.com/blog/HanselminutesPodcast51StaticCodeAnalysisWithNDepend.aspx)). If you haven't read it, go ahead and check it out. Scott uses NDepend to analyze [dasBlog](http://dasblog.info/) (which I'm running), so you can get the general feel for working with NDepend and what the reports look like. 

I'd like to run through a few of the features of NDepend using [Rhino Mocks](http://www.ayende.com/projects/rhino-mocks/downloads.aspx) as the target of my static analysis. Rhino Mocks is a neat example because it is only one assembly, but it is the result of an ILMerge of quite a few different libraries, so we get to see how NDepend handles this. Here is NDepend's class browser showing Rhino Mocks: 

![NDepend Class Browser](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/NDependStaticanalysisonsteroids_E81A/image_6.png)

As you can see, it handles Rhino Mocks accurately. In fact, it almost feels like the class browser in Reflector, so that is already a plus. In fact, as you can see, the context menu supports jumping to Reflector for the selected type. 

The "Who is directly using me?" option is also pretty cool and highlights the extensive use of CQL in NDepend: 

![Who is directly using me?](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/NDependStaticanalysisonsteroids_E81A/image_8.png)

CQL, or [Code Query Language](http://www.ndepend.com/CQL.htm), is the centerpiece of NDepend and is how all of the analysis happens. You can think of it as SQL against IL. The massive benefit that NDepend has over FxCop <acronym title="in my humble opinion">IMHO</acronym> is that you can create your own analysis rules in CQL instead of having to write and compile a DLL to extend FxCop (for an example of this, check out [this FxCop rule that ensures that ArrayLists are List&lt;T&gt;s instead](http://www.binarycoder.net/fxcop/html/ar01s22.html)). Even better, NDepend provides a complete editor *with intellisense* that allows you to test your queries out against your assemblies. 

![NDepend Screenshot](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/NDependStaticanalysisonsteroids_E81A/image_14.png)

Take a look at this screenshot. You can see the intellisense at the bottom right hand of the screen. At the top left is the CQL Query Results. The top right is all of the types in the assemblies, but the highlighted ones in blue are those that were returned by the query. This all happened *as I typed the query in*. Actually, I got red when I typed it in the first time, because my query had some mistakes in it, but NDepend was very helpful in showing me how to correct my query. 

The query editor also has different types of intellisense depending on the value. 

![CQL Editor](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/NDependStaticanalysisonsteroids_E81A/image_16.png)

I'll admit that it might seem weird to have a slider when you're just typing a number in, but the cool part is when you change the value, the query results automatically change to reflect the new value. In this case, you can watch the results of the query to get a feel for which types have the most methods. 

From an agile coding perspective, NDepend ties in well with [Continuous Integration](http://www.altnetpedia.com/ContinuousIntegration.ashx). It ships with both a [NANT](http://nant.sourceforge.net/) and an [MSBuild](http://msdn2.microsoft.com/en-us/library/0k6kkbsd.aspx) task to run the NDepend console against an NDepend project file (which is just XML). The report that it provides is *insanely* detailed. I'd say this where the value of application-specific CQL queries would come in handy, because you can come up with some detailed queries that are run on every CI build to ensure that the code still matches whatever design criteria was decided upon when the queries were written. 

![CQL Warning Screenshot](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/NDependStaticanalysisonsteroids_E81A/image_18.png)

For future versions of the tool, I'd think it would be neat to have a lightweight version of the CQL tool that you could ad hoc queries against assemblies, like as a Reflector addin or something. That'd be cool. Or maybe a Powershell cmdlet/PSDrive provider so that you could do something like this:

    Get-ChildItem -Include *.dll -Recurse | Select-Cql -Top 10 -Methods -Where MethodCa -ge 5

Or maybe:

    Get-ChildItem -Include *.dll -Recurse | Select-Cql -Top 10 -Methods | Where { $_.MethodCa -ge 5 }

I'm not sure exactly how the syntax might look, but it would be really cool :-)

Hopefully, I've given you a good picture of the some of the features of NDepend. If your interest is at all piqued, there is a "Trial / Open Source / Academic Edition" that you can download for free. Its feature set isn't quite as broad as the Professional edition, but I've used it before and it still provides a lot of functionality. Check it out!

**Full Disclosure** - I used a review copy of NDepend for this post. My company is not (yet) using this tool, but I think that there is interest. I wasn't paid to do this. **&lt;kidding&gt;**If you, dear reader, would like to pay me, please contact me.**&lt;/kidding&gt;**

<sup>[1]</sup> I don't believe that all of the SKUs of Visual Studio have the Code Analysis feature.



title: ".NET 2.0 and COM Interoperability Gotcha"
author: David
date: 2006/01/20
categories: .net
guid: 832a0a32-c2b1-4a86-abbb-1bcdccc5183b

Here is a little gotcha with some changes to the way that .NET 2.0 handles COM interoperability. You probably won't run into this problem unless you're converting a project from 1.1 to 2.0.

We had a little command line application that took did some background processing for us that was written in 1.1. We moved it over to 2.0 because we wanted to take advantage of the new FTP capabilities in the 2.0 framework (see FtpWebRequest/FtpWebResponse). If you add a reference to a COM object in .NET 1.1, the typical object that you'll create on the managed side will have a "Class" suffix (i.e. MyCoolComObjectClass as opposed to MyCoolComObject). If you convert to 2.0, it doesn't change that code either...

However, you might see an exception like this if you start using it:

"System.InvalidCastException: Unable to cast COM object of type 'System.\_\_ComObject' to class type 'ComLibrary.MyCoolComObjectClass'. COM components that enter the CLR and do not support IProvideClassInfo or that do not have any interop assembly registered will be wrapped in the \_\_ComObject type. Instances of this type cannot be cast to any other class; however they can be cast to interfaces as long as the underlying COM component supports QueryInterface calls for the IID of the interface."

What do you do? Take the class off the end of your COM object (MyCoolComObject**Class** -&gt; MyCoolComObject).

That's it.

AUTOMAGICAL!

(Thanks to [this forum posting](http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=189133&SiteID=1) for the info!)


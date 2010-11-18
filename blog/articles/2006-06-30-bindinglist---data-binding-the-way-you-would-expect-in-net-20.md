
title: "BindingList - data binding the way you would expect in .NET 2.0!"
author: David
date: 2006/06/30
categories: .net;programming
guid: 5c3b06bd-9103-412d-b4b2-31c6927bb959

If anyone out there knew about the BindingList before today, I sure wish one of you would have told me. Now I know, if you had known I was looking for something like the BindingList, you would have told me, but still...

Okay, all joking aside, the BindingList is what I've been trying to find for a long time. With Visual Studio 2005, the option to bind to an object data source is now possible (see screenshot).

![Visual Studio Data Binding screenshot](http://www.mohundro.com/blog/content/binary/2006-06-30-object-datasource.png)

The typical usage scenario for me with this data binding option is that I have just used .NET remoting to pull a collection of business objects back from a remote server. After that, I usually want to bind this collection to a datagrid or something like. For the past few months, I had used the new BindingSource object and set its DataSource property to my collection (usually a System.Collections.Generic.List&lt;T&gt; or a System.Collections.ObjectModel.Collection&lt;T&gt;). The problem I had was that any changes to either of those collections later would not fire ListChanged events. I had settled myself to the fact that I would have to reset the binding everytime.

Well, not so!

[Dinesh Chandnani](http://blogs.msdn.com/dchandnani/) posted to his MSDN blog over a year ago about this subject. Too bad I didn't find it until today. In his [post](http://blogs.msdn.com/dchandnani/archive/2005/03/12/394438.aspx), he provides some very simple code examples, one of which details how to get a "DataGridView bound to business objects." __\*gasp!\*__ Where have I been? This is what his code looks like:

    DataGridView dgv = new DataGridView();
    BindingSource bs = new BindingSource();
    BindingList<Customer> bList = new BindingList<Customer>();
    // Fill bList with Customers
    bs.DataSource = bList;
    dgv.DataSource = bs;

I wish I known about the System.ComponentModel.BindingList&lt;T&gt; before now. It would've saved me so much time. If you're still trying to bind to a List or Collection like I was, take that guy out and bind to the BindingList instead! It really works the way you would expect it to!



title: "Who cares about predicates without closures?"
author: david
date: 2006/03/24
categories: .net;programming
guid: f6656e1f-2a92-4156-908e-3dc0f9256272

I've been using the System.Collections.Generic namespace an awful lot lately. I really like it, too. I use the List&lt;T&gt; collection all the time. It is so much better than inheriting from the CollectionBase to get a type-safe collection. I won't go into the reasons here, though. This post is about Predicates. If you have a List&lt;T&gt; collection, you'll notice it exposes a Find method that takes a Predicate as an argument. A Predicate is just a delegate that takes an object of type T and returns a boolean. When you call the Find method, it will call your Predicate for each object in its collection until your Predicate returns true. Looks like a nice, clean way to search collections, right?

Well, if you're using C# anyway.

Compare the following VB.NET code and C# code:

VB.NET :

    Module Module1
      Sub Main()
        Dim tests As New List(Of Test)
        tests.Add(New Test("test"))
        tests.Add(New Test("test2"))
        tests.Add(New Test("test3"))

        toSearchFor = "test2"
        Console.WriteLine(tests.Find(AddressOf FindTest).ID)
      End Sub

      Private toSearchFor As String = ""
        Private Function FindTest(ByVal val As Test) As Boolean
        Return val.ID = toSearchFor
      End Function

      Private Class Test
        Public ID As String
        Public Sub New(ByVal id As String)
          Me.ID = id
        End Sub
      End Class
    End Module

C# :

    using System;
    using System.Collections.Generic;
    using System.Text;

    namespace CSPredicateExample
    {
      class Program
      {
        static void Main(string[] args)
        {
          List<Test> tests = new List<Test>();
          tests.Add(new Test("test"));
          tests.Add(new Test("test2"));
          tests.Add(new Test("test3"));

          string toSearchFor = "test2";
          Console.WriteLine(tests.Find(delegate(Test val) { return val.ID == toSearchFor; }).ID);
        }

        class Test
        {
          public string ID;
          public Test(string id)
          {
            this.ID = id;
          }
        }
      }
    }

Because of features like this, I am really looking forward to the next release of VB. Of course, with LINQ, will I even care about predicates then?

I would be very interested to know if anyone has any other suggestions on ways to effectively use the predicate model in VB.

**UPDATE:** Wow, go [Paul Stovell](http://paulstovell.net/)! Instead of complaining like I did, Paul actually did something to get around this limitation in the current version of VB.NET and created an implementation of ["Almost-anonymous" methods](http://www.paulstovell.net/blog/index.php/almost-anonymous-methods-in-visual-basic-net/)! His method also shows how to use the Widening overloaded operator in VB.NET, which I haven't seen much of. Cool!


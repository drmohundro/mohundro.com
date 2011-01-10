--- 
title: A custom switch statement in C#
date: 2011/01/10

I don't usually do blog requests, but then again, I don't usually get blog
requests. I've got a few friends that I email back and forth with regarding
technology, programming languages or whatever else piques our interests.

This particular time, my friend was complaining about the switch statement in
C# versus VB.NET.

It's true, actually. VB's `Select` statement is more powerful than the
`switch` statement in C#. In VB.NET, you can do things like:

    Select Case num
      Case 1 to 10
        'do something
      Case 11 to 20
        'do another thing
      Case Else
        'do the default
    End Select

Whereas, this isn't possible in C# with the switch statement. However, that
doesn't really bother me much.

Besides, I initially responded with the whole "prefer polymorphism over
conditionals" thing anyway. You know.

We went back and forth a little bit and he mentioned that he'd rather see a
switch statement that accepted lambdas or delegates to choose the action to
take. This reminded me of switch statements in both Ruby and PowerShell.

In Ruby, you've got the case statement:

    case some_var
      when nil
        # executes if some_var is null
      when String
        # executes if some_var is a string
      when 42
        # executes if some_var equals 42
      when /regex/
        # executes if some_var matches the regex
      when 1..10
        # executes when some_var is between 1 and 10
      else
        # the catch all
    end

As you can see, the case statement in Ruby is *very* powerful.

PowerShell's switch statement can take arguments (i.e. -wildcard, -regex,
etc.) to let it match on different things. Like so:

    switch -regex ($a) { 
        "[a-d]" {"$a matches the first group."} 
        "[e-g]" {"$a matches the second group."} 
        "[h-k]" {"$a matches the third group."} 
        default {"$a didn't match any of the cases."}
    }

So, when looking at all of these other switch statements, C#'s version does
look sort of weak. But hey, we're programmers. Surely we can solve this
ourselves, right?

The first step I took was to write out the code I was interested in. My
friend had sent an initial snippet that included a non-existent keyword called
"swatch" that did allow for much more powerful checks - primarily by
delegating off to lambdas. His proof of concept snippet looked like
this:

    // this is *pseudocode* - it won't compile!
    swatch (myObject)
    {
      case myObj => return myObj == null:
        Console.Writeline("the object is null");
        break;
      case myObj => return myObj.property1 == 3:
        Console.Writeline("the object's property1 value is three");
        break;
      case myObj => return myObj.myCollection.Contains(4):
        Console.Writeline("the object's collection contains the 4 value");
        break;
    }

So, I've got something to start with. How can I tweak this into valid C#? I
began with writing the code that I wanted first. In other words, I'm designing
the API of the class from the outside, not from the inside. This is one of the
best benefits of writing tests first - you get to build the API as a consumer
of the class first.

Here's what I initially came up with:

    var accts = new List<Account>
                    {
                      new Account 
                      {
                        Name = "Amazon", 
                        IsPreferred = true, 
                        Moolah = 123456789.01m
                      },
                      new Account 
                      {
                        Name = "Bob's Store", 
                        IsPreferred = false, 
                        Moolah = 15.78m
                      }
                    };

    var swatch = new Switcher<Account>();

    foreach (var acct in accts)
    {
      swatch.Switch(acct,
        swatch.Case(x => x == null,
          x => Console.WriteLine("the object is null")),

        swatch.Case(x => x.Moolah > 10000.00m,
          x => Console.WriteLine("Whoa, these guys (" + x.Name + ") got some money")),

        swatch.Default(
          x => Console.WriteLine("wha?!?"))
      );
    }

The above syntax *can* work. We just need to implement the Switcher&lt;T&gt; class.

Here it is, in its entirety:

    class Switcher<T>
    {
      public Decision Case(Predicate<T> condition, Action<T> branch)
      {
        return new Decision {Condition = condition, Branch = branch};
      }

      public Decision Default(Action<T> branch)
      {
        return new Decision {Condition = x => true, Branch = branch};
      }

      public void Switch(T instance, params Decision[] cases)
      {
        foreach (var @case in cases)
        {
          if (@case.Condition(instance))
          {
            @case.Branch(instance);
            break;
          }
        }
      }

      public class Decision
      {
        public Predicate<T> Condition { get; set; }
        public Action<T> Branch { get; set; }
      }
    }

The code isn't complete - it doesn't do any checks to ensure that only one
Default case is passed in. It also doesn't do anything to ensure that the
Default case is the last one to be checked. We can leave that as an exercise
to the reader perhaps. Other types of case methods could be added such as
TypeOf that evaluates the action if the instance is of the type specified
(i.e. `swatch.TypeOf<Foo>()`). It would also be pretty easy to add in a
RegEx case method, too (i.e.  `swatch.RegEx("[a-z]")`).

After responding to the email, I considered that it would also be possible to
implement this in a fluent interface style of API. It might be interesting to
try that, too.


title: "The new version of Rhino.Mocks is awesome!"
author: David
date: 2007/10/26
categories: .net;unit testing

Ayende is the man. Seriously. 

Today, he [released Rhino Mocks 3.3 to great fanfare](http://ayende.com/Blog/archive/2007/10/26/Rhino-Mocks-3.3.aspx). 

If there wasn't great fanfare, there should be. My favorite new feature - mocking objects that inherit from MarshalByRefObject. You might be asking yourself, why does this matter? Doesn't that only apply to remoting? Well, yes, sort of. The thing is, a huge number of the built-in classes in the CLR support this remoting infrastructure. You know the ones I'm talking about - the built-in classes that are hard to mock and test. 

At least they didn't let you mock them out until today. Here's an example of something that might have been harder to test before today:

    [TestFixture]
    public class Tests
    {
      [Test]
      public void TestingCoolRhinoMocksStuff()
      {
        MockRepository mocks = new MockRepository();

        Process p = mocks.CreateMock<Process>();

        using (mocks.Record())
        {
          Expect.Call(p.Responding).Return(false);
        }

        using (mocks.Playback())
        {
          Assert.IsFalse(p.Responding);
        }
      }
    }

Yeah, I'm mocking System.Diagnostics.Process. Sweet. 

Take a look in Reflector and you'll find out just how many objects actually inherit from MarshalByRefObject. I think you'll be quite surprised. 

Thanks Ayende!


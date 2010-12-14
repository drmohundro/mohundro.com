
title: "An unexpected benefit from COM objects in managed code"
author: David
date: 2007/08/30
categories: .net;programming
guid: fe14ef4b-90a4-44b1-8e66-b726f8fa541a

I was messing around with some unit tests this week and I came across an unexpected benefit while working on code that worked with a COM object. When you add a reference to a COM library in .NET, you'll get an interface as well an implementation of that interface that forwards the calls to the COM objects.

Because an interface is created for the COM objects as well as the implementation, you can mock the COM dependency with Rhino Mocks or some other mocking framework. Just code against the interface instead of the concrete implementation and inject the concrete implementation via dependency injection for the normal scenario. 

Let's say you wanted to unit test some code that had a dependency on the Windows Media Player COM object. Here's how you could do it.\* 

![Windows Media Player COM Class](https://s3.amazonaws.com/mohundro/blog/WindowsLiveWriter/AnunexpectedbenefitfromCOMobjectsinmanag_E99E/image_1.png) 

    // Code to be tested
    public class SomeClass
    {
       private WMPLib.WindowsMediaPlayer _player;

       public SomeCode(WMPLib.WindowsMediaPlayer player)
       {
          _player = player;
       }

       public void DoSomething()
       {
          _player.enabled = false;
       }
    }

    // Unit test
    [TestFixture()]
    public class SomeCodeTest
    {
       [Test()]
       public void PlayerEnabledShouldBeSetCorrectly()
       {
          MockRepository mocks = new MockRepository();

          // Mock the WMP interface... note that even
          // though it doesn't start with an 'I', 
          // it is still an interface...
          WMPLib.WindowsMediaPlayer player = mocks.CreateMock<wmplib>();

          // Inject the mocked WMP object
          SomeClass sc = new SomeClass(player);

          using (mocks.Record())
          {
             // Expect player.enabled to be set to false
             player.enabled = false;
          }

          using (mocks.Playback())
          {
             sc.DoSomething();
          }
       }
    }

I tried this code out and the test runs fine. Note the comment where the mock object is actually being created. For some reason, the interface to the COM object isn't named with an 'I'. It still is an interface, though. And you can create the COM object by saying 'new WMPLib.WindowsMediaPlayer' though I think that is some COM interop magic going on there (I'm guessing the CoClass attribute on the interface has something to do with this magic).

\* I'm not actually mocking Windows Media Player in any of my code and I have no idea how well it will work. I do know that I can mock some of our own COM objects without any problems, though.


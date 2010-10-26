
title: "An unexpected benefit from COM objects in managed code"
author: David
date: 2007/08/29

<p>I was messing around with some unit tests this week and I came across an unexpected benefit while working on code that worked with a COM object. When you add a reference to a COM library in .NET, you'll get an interface as well an implementation of that interface that forwards the calls to the COM objects. </p> <p>Because an interface is created for the COM objects as well as the implementation, you can mock the COM dependency with Rhino Mocks or some other mocking framework. Just code against the interface instead of the concrete implementation and inject the concrete implementation via dependency injection for the normal scenario.</p> <p>Let's say you wanted to unit test some code that had a dependency on the Windows Media Player COM object. Here's how you could do it.*</p> <p><a href="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/AnunexpectedbenefitfromCOMobjectsinmanag_E99E/image_1.png" atomicselection="true"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; margin: 0px 0px 0px 20px; border-right-width: 0px" height="467" alt="image" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/AnunexpectedbenefitfromCOMobjectsinmanag_E99E/image_thumb_1.png" width="241" align="right" border="0"></a> </p><pre>// Code to be tested
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

      // Mock the WMP interface... note that even <br>      // though it doesn't start with an 'I', 
      // it is still an interface...
      WMPLib.WindowsMediaPlayer player = mocks.CreateMock<wmplib.windowsmediaplayer>();

      // Inject the mocked WMP object
      SomeClass sc = new SomeClass(player);

      using (mocks.Record())
      {<br>         // Expect player.enabled to be set to false
         player.enabled = false;
      }

      using (mocks.Playback())
      {
         sc.DoSomething();
      }
   }
}
</pre>
<p>I tried this code out and the test runs fine. Note the comment where the mock object is actually being created. For some reason, the interface to the COM object isn't named with an 'I'. It still is an interface, though. And you can create the COM object by saying 'new WMPLib.WindowsMediaPlayer' though I think that is some COM interop magic going on there (I'm&nbsp;guessing&nbsp;the CoClass attribute on the interface has something to do with this magic).</p>
<p>* I'm not actually mocking Windows Media Player in any of my code&nbsp;and I have no idea how well it will work. I do know that I can mock some of our own COM objects without any problems, though.</p>

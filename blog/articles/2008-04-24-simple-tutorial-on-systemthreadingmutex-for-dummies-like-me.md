
title: "Simple tutorial on System.Threading.Mutex for dummies (like me)"
author: David
date: 2008/04/24
categories: .net;programming
guid: ba34974d-3d73-4aa8-8450-b72238836d72

(Warning - this post is both a rant against the Mutex as well as a guide for its usage. Also, don't blindly copy code, only the bottom code snippet works. :-) ) 

I'm a big fan of an API that is so easy to use that I don't have to look at the documentation. 

I had to look up the documentation for [System.Threading.Mutex](http://msdn2.microsoft.com/en-us/library/system.threading.mutex.aspx)... multiple times. 

Taking a look at Mutex, I see that it implements [IDisposable](http://msdn2.microsoft.com/en-us/library/system.idisposable.aspx). Great, that means I can wrap it in a [using block](http://msdn2.microsoft.com/en-us/library/yh598w02(VS.80).aspx). 

My first try: 

    bool createdNew; 
    using (Mutex mtx = new Mutex(false, "MyAwesomeMutex", out createdNew)) 
    { 
      MessageBox.Show("Press OK to release the mutex."); 
    }

Looks good, right? Nope, that is a big negative. Nowhere does this actually acquire the mutex. When you run this application twice, they both show the message box just fine. Maybe I should actually check the createdNew value? 

Let's change the code to look like this:

    bool createdNew; 
    using (Mutex mtx = new Mutex(false, "MyAwesomeMutex", out createdNew)) 
    { 
      if (!createdNew) 
        mtx.WaitOne(); 
      MessageBox.Show("Press OK to release the mutex."); 
    }

However, that didn't work, either. It turns out that the createdNew parameter just tells you if you're the one who created the mutex, <em>not</em> if you currently own the mutex. That is what the purpose for the [WaitOne](http://msdn2.microsoft.com/en-us/library/system.threading.mutex.waitone.aspx) method is for. Of course, the documentation just says that it "blocks the current thread until the current WaitHandle receives a signal." Okay. Well, I'm glad that I now know that it also waits for my thread to acquire a lock on the mutex. (note, if you pass in 'true' as the first parameter, you'll <em>request</em> to be the owner, but you'll only be the owner if the createdNew out parameter comes back with true) 

Third try. Third time's the charm, right?

    bool createdNew; 
    using (Mutex mtx = new Mutex(false, "MyAwesomeMutex", out createdNew)) 
    { 
      mtx.WaitOne(); 
      MessageBox.Show("Press OK to release the mutex."); 
    }

Great, now when I run my app twice, the second one is blocking on the WaitOne call. Cool. You can even tell in the below screenshot, because the button's paint event is blocked and is whiting out (like Solitaire does when you win!). 

![Mutex Test App not painting](https://s3.amazonaws.com/mohundro/blog/WindowsLiveWriter/SimpletutorialonSy.Mutexfordummieslikeme_DE3C/image_6.png)

Let's click okay and see if the second form gets the mutex, thus displaying the message. That's weird - the form still isn't responding. Let's close the first form. 

![Test App crashing](https://s3.amazonaws.com/mohundro/blog/WindowsLiveWriter/SimpletutorialonSy.Mutexfordummieslikeme_DE3C/image_8.png)

Ouch! That was unexpected. What? Abandoned mutex? This sounds like I never even released the mutex. Hmmm... [ReleaseMutex](http://msdn2.microsoft.com/en-us/library/system.threading.mutex.releasemutex.aspx)? Shouldn't that be called from the Dispose (end of the Using block)? Might as well try it.

    bool createdNew; 
    using (Mutex mtx = new Mutex(false, "MyAwesomeMutex", out createdNew)) 
    { 
      try 
      { 
        mtx.WaitOne(); 

        MessageBox.Show("Click OK to release the mutex."); 
      } 
      finally 
      { 
        mtx.ReleaseMutex(); 
      } 
    }

Finally! Now, it works like I'm wanting. I'm keeping the using block in place, because that disposes the WaitHandle that Mutex uses (Mutex in face inherits from WaitHandle). 

Anyway, I'm hoping there is a reason for the API to be designed in this way, but man, it doesn't seem very intuitive to me. 

While learning this, I unfortunately tried putting the Mutex in some of my code without trying it small scale first. After struggling for quite a while, I went to the small application and discovered everything that I've posted here. I hope this helps you with the Mutex when you have to deal with it.


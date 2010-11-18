
title: "Blocked threads and transparent proxies"
author: David
date: 2007/08/02
categories: .net;programming
guid: e94f8a75-7f4d-4718-89fa-5e3f7e4d33f1

> (**note** - if you're reading this in a feed reader like Google Reader, sorry - the code snippets look awful... if anyone has any suggestions on good ways to get code to look good in the webpage *and* feed readers, I'd appreciate it)

Given this:

    delegate void WorkDelegate();
    interface ISomeInterface
    {
      void Execute();
    }

What is the difference between this class

    class TestCaseOne
    {
      ISomeInterface something = Activator.GetObject(typeof(ISomeInterface), 
        "http://some.url.com/") as ISomeInterface;

      public TestCaseOne()
      {
        BackgroundWorker wkr = new BackgroundWorker();
        wkr.DoWork += new DoWorkEventHandler(wkr_DoWork);
        wkr.RunWorkerAsync();
      }

      void wkr_DoWork(object sender, DoWorkEventArgs e)
      {
        something.Execute();
      }
    }

and this class?

    class TestCaseTwo
    {
      ISomeInterface something = Activator.GetObject(typeof(ISomeInterface), 
        "http://some.url.com/") as ISomeInterface;

      public TestCaseTwo()
      {
        WorkDelegate dlg = new WorkDelegate(something.Execute);
        dlg.BeginInvoke(MyCallback, new object[] { dlg });
      }

      private void MyCallback(IAsyncResult iar)
      {
        object[] asyncState = iar.AsyncState as object[];
        WorkDelegate dlg = asyncState[0] as WorkDelegate;

        dlg.EndInvoke(iar);
      }
    }

Both classes have a field named something that is a reference to an HTTP remoting proxy that has been published at [http://some.url.com](http://some.url.com). Let's assume that the the HTTP Remoting configuration has already been set up. Both call the Execute method defined on the interface, but one is using a BackgroundWorker for threading and the other is using the BeginInvoke/EndInvoke means of threading. Big deal, right?

There isn't a huge difference just looking at the code -- except that with TestCaseOne, the remoting call will result in a blocked thread whereas TestCaseTwo will not. In TestCaseOne, the background thread will block on the something.Execute() call and wait for it to return. In TestCaseTwo, the WorkDelegate BeginInvokes on the transparent remoting proxy. There isn't any code to block on. Instead, the framework will let you know when your remoting call returns.

Why does this matter? When you have a blocked thread, you basically have wasted CPU cycles where it is blocking instead of working. This likely won't matter much if you're not working with a lot of threads, but it can cause performance problems if you're working with a lot of threads.

On the other hand, when TestCaseTwo calls back to let you know the remoting call has completed, it will not call back on the calling thread. BackgroundWorker is smart enough to invoke back to the UI thread if needed. Both have their pluses and minuses. The BackgroundWorker component does make the code a little more easy to read and it handles invoking back to the UI thread. However, if you're working with a lot of threads, you might try using the delegate approach instead, so as to avoid any blocked threads.


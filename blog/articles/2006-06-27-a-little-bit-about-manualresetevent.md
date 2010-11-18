
title: "A little bit about ManualResetEvent"
author: David
date: 2006/06/27
categories: .net;programming
guid: 31792f68-b4aa-4f0f-a666-a136799795ee

I'm not sure how often people run into situations where the ManualResetEvent is needed, but I have a few times. System.Threading.ManualResetEvent provides an easy way to allow cross-thread communication and to let other threads know when something has completed. Most of the time that I've needed it, I have a property in a class that is loaded in another thread, but I want to prevent access to the property until it is loaded. From what I've seen, this is a great time to use the ManualResetEvent.

It is easiest to explain with some code snippets. Here's how you create the ManualResetEvent.

    Private dataLock As New ManualResetEvent(False)

To wait on the signal, use this code:

    _dataLock.WaitOne()

Once your background work is completed, you can call Set like so:

    _dataLock.Set()

Here's a full code sample that shows how it would work and also gives a short example on the BackgroundWorker.

    Imports System.ComponentModel
    Imports System.ThreadingModule Module1

    Private _dataLock As New ManualResetEvent(False)

    Sub Main()

      Thread.CurrentThread.Name = "[Main]"

      Dim wkr As New BackgroundWorker
      AddHandler wkr.DoWork, AddressOf wkr_DoWork
      AddHandler wkr.RunWorkerCompleted, AddressOf wkr_RunWorkerCompleted

      wkr.RunWorkerAsync("Get to work!")

      Write("Waiting on the lock...")
      _dataLock.WaitOne()
      Write("we're back!")

      Console.WriteLine(vbNewLine & "Press any key to continue...")
      Console.ReadLine()
    End Sub

    Private Sub wkr_DoWork(ByVal sender As Object, ByVal e As System.ComponentModel.DoWorkEventArgs)
      Thread.CurrentThread.Name = "[Work]"

      Write("DoWork just received this value: " & CStr(e.Argument))
      Thread.Sleep(5000)

      e.Result = "DoWork finished!"

      Write("DoWork is done so start signaling completion.")
      _dataLock.Set()
    End Sub

    Private Sub wkr_RunWorkerCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.RunWorkerCompletedEventArgs)
      Dim wkr As BackgroundWorker = DirectCast(sender, BackgroundWorker)
      RemoveHandler wkr.DoWork, AddressOf wkr_DoWork
      RemoveHandler wkr.RunWorkerCompleted, AddressOf wkr_RunWorkerCompleted
      wkr.Dispose()
    End Sub

    Private Sub Write(ByVal s As String)
      Console.WriteLine(String.Format("Thread: {0}, Message: {1}", Thread.CurrentThread.Name, s))
    End Sub

The output from running looks like this:

    Thread: [Main], Message: Waiting on the lock...
    Thread: [Work], Message: DoWork just received this value: Get to work!
    Thread: [Work], Message: DoWork is done so start signaling completion.
    Thread: [Main], Message: we're back!
    
    Press any key to continue...

One thing to remember: do NOT put the call to Set (i.e. \_dataLock.Set()) in the thread where you are waiting (i.e. \_dataLock.WaitOne())! You'll never get the signal because that thread is already blocking! Because of this, make sure your call to Set always happens in the DoWork event of the BackgroundWorker instead of the RunWorkerCompleted event.


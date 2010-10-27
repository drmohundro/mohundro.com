
title: "Opening files that don't have associated programs"
author: David
date: 2006/03/30

Recently, I was adding the ability to open files from an application at work. Luckily, I had run into this situation before, so I knew that you could run a Process.Start on the file in question and have Explorer open it for you. What I didn't know was that it would throw a Win32Exception if the file didn't have an associated program to open it. My next step was what any good developer would do: Google it.

Fairly early on in my searching, I came across a [post](http://www.nedbatchelder.com/blog/20050318T070512.html) by [Ned Batchelder](http://www.nedbatchelder.com/blog/index.html) that described the EXACT same scenario I was working on! Ned wanted to open a file with an unknown extension from a managed application just like me. He details his Google search and explains how he discovered information about the API functions, ShellExecute and ShellExecuteEx. Basically, you can call ShellExecuteEx with an "open" verb and Explorer will attempt to open the file. If it fails with an SE_ERR_NOASSOC error, then call ShellExecuteEx again but using an "openas" verb. Doesn't sound too bad, though some code snippets still would've sped the process up for me :-) I did learn it better this way, though.

Anyway, here's where I started. First, I pulled in the definition for the SHELLEXECUTEINFO structure.

    Friend Structure SHELLEXECUTEINFO
      Public cbSize As Integer
      Public fMask As SEE_MASK
      Public hwnd As IntPtr
      <MarshalAs(UnmanagedType.LPTStr)> _
      Public lpVerb As String
      <MarshalAs(UnmanagedType.LPTStr)> _
      Public lpFile As String
      <MarshalAs(UnmanagedType.LPTStr)> _
      Public lpParameters As String
      <MarshalAs(UnmanagedType.LPTStr)> _
      Public lpDirectory As String
      Dim nShow As Integer
      Dim hInstApp As SE_ERR
      Dim lpIDList As IntPtr
      <MarshalAs(UnmanagedType.LPTStr)> _
      Public lpClass As String
      Public hkeyClass As IntPtr
      Public dwHotKey As Integer
      Public hIcon As IntPtr
      Public hProcess As IntPtr
    End Structure

Next, I created definitions for the SW, SEE_MASK, and SE_ERR constants.

    #Region " SW Constants "
    Friend Enum SW As Integer
      HIDE = 0
      SHOWNORMAL = 1
      NORMAL = 1
      SHOWMINIMIZED = 2
      SHOWMAXIMIZED = 3
      MAXIMIZE = 3
      SHOWNOACTIVATE = 4
      SHOW = 5
      MINIMIZE = 6
      SHOWMINNOACTIVE = 7
      SHOWNA = 8
      RESTORE = 9
      SHOWDEFAULT = 10
      FORCEMINIMIZE = 11
      MAX = 11
    End Enum
    #End Region

    #Region " SEE_MASK Constants "
    Friend Enum SEE_MASK As Integer
      CLASSNAME = &H1
      CLASSKEY = &H3
      IDLIST = &H4
      INVOKEIDLIST = &HC
      ICON = &H10
      HOTKEY = &H20
      NOCLOSEPROCESS = &H40
      CONNECTNETDRV = &H80
      FLAG_DDEWAIT = &H100
      DOENVSUBST = &H200
      FLAG_NO_UI = &H400
      UNICODE = &H4000
      NO_CONSOLE = &H8000
      ASYNCOK = &H100000
      HMONITOR = &H200000
      NOZONECHECKS = &H800000
      NOQUERYCLASSSTORE = &H1000000
      WAITFORINPUTIDLE = &H2000000
      FLAG_LOG_USAGE = &H4000000
    End Enum
    #End Region

    #Region " SE_ERR Constants "
    Friend Enum SE_ERR As Integer
      SE_ERR_FNF = 2 ' file not found
      SE_ERR_PNF = 3 ' path not found
      SE_ERR_ACCESSDENIED = 5 ' access denied
      SE_ERR_OOM = 8 ' out of memory
      SE_ERR_DLLNOTFOUND = 32
      SE_ERR_SHARE = 26
      SE_ERR_ASSOCINCOMPLETE = 27
      SE_ERR_DDETIMEOUT = 28
      SE_ERR_DDEFAIL = 29
      SE_ERR_DDEBUSY = 30
      SE_ERR_NOASSOC = 31
    End Enum
    #End Region

Finally, I created my definition for the ShellExecuteEx function.

    <DllImport("shell32.dll", CharSet:=CharSet.Auto, SetLastError:=True)> _
    Friend Shared Function ShellExecuteEx(ByRef lpExecInfo As SHELLEXECUTEINFO) As Boolean
    End Function

I stuck all of this into a NativeMethods class and tried the code below: 

    Dim info As New NativeMethods.SHELLEXECUTEINFO
    info.cbSize = Marshal.SizeOf(info)
    info.lpDirectory = Path.GetDirectoryName(fileToStart)
    info.lpFile = Path.GetFileName(fileToStart)
    info.nShow = NativeMethods.SW.SHOWDEFAULT
    info.lpVerb = "open"
    info.fMask = NativeMethods.SEE_MASK.FLAG_NO_UI Or NativeMethods.SEE_MASK.FLAG_DDEWAIT

    If Not NativeMethods.ShellExecuteEx(info) Then
      If info.hInstApp = NativeMethods.SE_ERR.SE_ERR_NOASSOC Then
        Dim sinfo As New NativeMethods.SHELLEXECUTEINFO
        sinfo.cbSize = Marshal.SizeOf(info)
        sinfo.lpVerb = "openas"
        sinfo.lpDirectory = Path.GetDirectoryName(fileToStart)
        sinfo.lpFile = Path.GetFileName(fileToStart)
        sinfo.nShow = NativeMethods.SW.SHOWDEFAULT
        NativeMethods.ShellExecuteEx(sinfo)
      End If
    End If

**UPDATED (9/12/2006):** Many thanks to Michael and his comment regarding using the SEE_MASK.FLAG_DDEWAIT. That fixed all of the problems I was running into regarding the above code. (see the usage on info.fMask)

A quick note about the code: Ned mentioned in his post that he got the ERROR_NO_ASSOCATION error instead of SE_ERR_NOASSOC. Well, the ERROR_NO_ASSOCATION is what is returned in the Win32 error (Marshal.LastWin32Error). The SE_ERR_NOASSOC is returned in the hInstApp (see MSDN documentation [here](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/shellcc/platform/shell/reference/structures/shellexecuteinfo.asp)). 

See any problems with that? I certainly didn't (and still don't). It works like a charm for files with associations... however, it would only work one time for files without any associated program. Afterwards, it wouldn't give me anything... no errors, nada, zilch. After a few tries, an AccessViolationException would get thrown. Why? I have no idea. I tried various things to see if I should be cleaning up memory somewhere but I couldn't find anything. I did find out that if I just called ShellExecuteEx with the "openas" verb the first time, I wouldn't get any problems at all. What in the world???

As a result of the strange behavior, I changed my code slightly to look like this: 

    Try
      Using p As New Process
        p.StartInfo.FileName = fileToStart
        p.StartInfo.UseShellExecute = True
        p.Start()
      End Using
    Catch win32Ex As Win32Exception
      Dim sinfo As New NativeMethods.SHELLEXECUTEINFO
      sinfo.cbSize = Marshal.SizeOf(sinfo)
      sinfo.lpVerb = "openas"
      sinfo.lpDirectory = Path.GetDirectoryName(fileToStart)
      sinfo.lpFile = Path.GetFileName(fileToStart)
      sinfo.nShow = NativeMethods.SW.SHOWDEFAULT

      If Not NativeMethods.ShellExecuteEx(sinfo) Then
        Throw New Win32Exception
      End If
    End Try

The above code is working like a charm. I still have no idea why my first example won't work for me. If anyone has any ideas or suggestions, please let me know. I haven't worked with Interop between managed and unmanaged code very much. My experience up to this point has primarily been an entirely managed project or an entirely unmanaged project (and that only in college).

**NOTES:** Here are some resources I found while researching this:

[[http://www.nedbatchelder.com/blog/20050318T070512.html](http://www.nedbatchelder.com/blog/20050318T070512.html)]<br>[[http://www.pinvoke.net/default.aspx/shell32/ShellExecuteEx.html](http://www.pinvoke.net/default.aspx/shell32/ShellExecuteEx.html)]<br>[[http://www.pinvoke.net/default.aspx/Constants/SW.html](http://www.pinvoke.net/default.aspx/Constants/SW.html)]<br>[[http://msdn.microsoft.com/library/default.asp?url=/library/en-us/shellcc/platform/shell/reference/structures/shellexecuteinfo.asp](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/shellcc/platform/shell/reference/structures/shellexecuteinfo.asp)]

Also, be sure to look at the ShellAPI.h header file!<br>

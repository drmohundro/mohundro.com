
title: "FtpWebRequest/FtpWebResponse Errors"
author: David
date: 2006/01/20
categories: .net
guid: b49f5cc4-8b1b-4ed5-aa0f-f1b0eb111b0b

I discovered today that the new `FtpWebRequest`/`FtpWebResponse` classes might not be the best options for connecting to FTP servers, at least unless you're in control of the FTP server. The classes make some assumptions about the remote FTP server, like the server's file system.

I was working on converting an application that sends files to a customer's FTP server and I thought I would use the `FtpWebRequest` and `FtpWebResponse` classes. The problem is that the customer's FTP server is running on VMS! I know, that isn't very common, but the file system in VMS is NOT like Windows or Unix. Folders aren't separated by "\" or "/" so when a change directory (CWD) command is sent, you can't assume that folders are delimited by one of those characters! When you try to list the files in the directory, it sends a CWD command to change directory to the current directory (why, I don't know) with a "/" at the end. Predictably, I get a 550 error back with a "file specification syntax error."

I haven't found a workaround other than coding it myself. If anyone has any suggestions, let me know.

NOTE:

I used <strike>Ethereal</strike>[Wireshark](http://www.wireshark.com) to observe what was being sent and received. It is a great utility for watching network traffic.


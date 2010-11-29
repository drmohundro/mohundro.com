
title: "More PowerShell automation and unrelated updates"
author: David
date: 2007/01/11
categories: general;powershell
guid: 0123fded-9dcc-44b6-aa11-87a76fde36ee

A recent post by Lee Holmes on [breaking your writer's (blogger's?) block](http://www.leeholmes.com/blog/BreakYourWritersBlock.aspx) is prompting this post. I recently finished reading Steve McConnell's book, [Code Complete](http://cc2e.com/Default.aspx)\*, over the Christmas holidays and the book was amazing. As I read it, I began taking lists of things I wanted to post on that were excellent advice... and ran into a block because there was just so much I wanted to say about. I still plan on writing more detailed posts on the issue but, as Lee suggests, I need to just get out here and post more. 

So anyway. 

Recently, I posted an [entry on calculating file hashes with PowerShell](/blog/2006/12/28/powershell-script-to-calculate-file-hashes/) and promptly had to put an update because the [PowerShell Community Extensions](http://www.codeplex.com/PowerShellCX) (PsCx) had provided a better file hash function. The good thing about PsCx is that it really provides a good example of PowerShell code and has a lot of cmdlets that drive home automating PowerShell for your needs. 

One of my favorite functions is incredibly simple but it highlights how you can save just a few keystrokes for more productivity. The Edit-File function uses a predefined variable that points to an EXE path and runs the EXE with the specified parameter. There is also an alias for it (e) so you can type something like "e somefile.txt" and it will open. I like this method a little better than actually renaming notepad.exe to n.exe (\*cough\* [Scott Hanselman](http://www.hanselman.com/blog/Nexe.aspx) \*cough\* :-) ). It actually prompted me to create multiple, similar functions so that I can open files in different editors (I use Ultra-Edit, Notepad2, Notepad++, or who knows what else) without having to respecify the editor variable. Now I type "u somefile.txt" to open a file in Ultra-Edit. 

This also prompted me to set up the winmerge function below:

    function winmerge ([string]$path1, [string]$path2) {
      $winmergePath = "c:\program files\winmerge\winmerge.exe"
      . $winmergePath $path1 $path2
    }

It allows me to quickly see the comparisons between two different files without having to preselect them with the mouse. It is simple, but quite convenient. And I also don't have to go adding all sorts of random directories to my PATH just so I can get to them more quickly.

So there you go: my PowerShell automation.

I also promised some unrelated updates. On Monday, January 8, I had LASIK surgery on both of my eyes to correct my extreme nearsightedness. The whole operation took 15 minutes and the only discomfort I had was a headache and some stinging eyes on the day of the operation. Since that time, my left eye can already see with 20/15 vision. My right eye is still a little fuzzy, but that is supposed to clear up in another day or so - it took the laser twice as long to correct my right eye as it did my left eye!

If anyone is interested in more details on my experiences with LASIK, I'd be happy to provide a follow-up post on it.

\* [Jeff Atwood](http://www.codinghorror.com/blog) really should get some sort of referral rewards for recommending Code Complete... I mean seriously...



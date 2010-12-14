
title: "PowerShell ISE Themes!"
author: David
date: 2008/12/31
categories: powershell
guid: ce805e6f-dd3f-4ff1-8264-f3d43dc06215

Last week, the PowerShell team released PowerShell v2 CTP3. And, of course, there was much rejoicing. I've got quite a bit I'd like to blog about regarding PowerShell, but I couldn't wait to share one feature I love. 

PowerShell ISE Themes. 

Okay, so, it doesn't actually ship with themes. But you can create them. Let me provide some background. The "ISE" in PowerShell ISE stands for Integrated Scripting Environment and is based on the [upcoming WPF editor that will ship with Visual Studio 2010](http://blogs.msdn.com/powershell/archive/2008/10/31/powershell-ise-and-visual-studio.aspx). Here is a screenshot of it. 

![PowerShell ISE](https://s3.amazonaws.com/mohundro/blog/WindowsLiveWriter/PowerShellISEThemes_8295/image_4.png)

As you can see, there are three panes included: one that allows you to edit PS1 scripts (with syntax highlighting and tab completion included), one that displays the output of your commands (whether from the script editor or the command pane), and one that allows you to type in commands (the equivalent of the prompt you get in the console host). 

I'll admit, when I heard about the graphical host, I thought it was nice but I really didn't think I'd use it much. I use gVim to edit my scripts and have the console up all day. Why did I need another editor? I didn't get really excited until I saw [all of the customizations that you can do with it](http://get-powershell.com/category/ise/). 

The [$psISE variable offers up a wealth of options](http://blogs.msdn.com/powershell/archive/2008/12/29/powershell-ise-can-do-a-lot-more-than-you-think.aspx). I'm particularly fond of the Options property off of $psISE. I'll let the screenshot describe why: 

[PowerShell ISE with themes](https://s3.amazonaws.com/mohundro/blog/WindowsLiveWriter/PowerShellISEThemes_8295/image_6.png)

Looks different, eh? Below is the code to get it to work:

    # PowerShell ISE version of the VIM blackboard theme at 
    # http://www.vim.org/scripts/script.php?script_id=2280

    # fonts
    $psISE.Options.FontName = 'DejaVu Sans Mono'
    $psISE.Options.FontSize = 16

    # output pane
    $psISE.Options.OutputPaneBackground = '#FF000000'
    $psISE.Options.OutputPaneTextBackground = '#FF000000'
    $psISE.Options.OutputPaneForeground = '#FFFFFFFF'

    # command pane
    $psISE.Options.CommandPaneBackground = '#FF000000'

    # script pane
    $psISE.Options.ScriptPaneBackground = '#FF000000'

    # tokens
    $psISE.Options.TokenColors['Command'] = '#FFFFFF60'
    $psISE.Options.TokenColors['Unknown'] = '#FFFFFFFF'
    $psISE.Options.TokenColors['Member'] = '#FFFFFFFF'
    $psISE.Options.TokenColors['Position'] = '#FFFFFFFF'
    $psISE.Options.TokenColors['GroupEnd'] = '#FFFFFFFF'
    $psISE.Options.TokenColors['GroupStart'] = '#FFFFFFFF'
    $psISE.Options.TokenColors['LineContinuation'] = '#FFFFFFFF'
    $psISE.Options.TokenColors['NewLine'] = '#FFFFFFFF'
    $psISE.Options.TokenColors['StatementSeparator'] = '#FFFFFFFF'
    $psISE.Options.TokenColors['Comment'] = '#FFAEAEAE'
    $psISE.Options.TokenColors['String'] = '#FF00D42D'
    $psISE.Options.TokenColors['Keyword'] = '#FFFFDE00'
    $psISE.Options.TokenColors['Attribute'] = '#FF84A7C1'
    $psISE.Options.TokenColors['Type'] = '#FF84A7C1'
    $psISE.Options.TokenColors['Variable'] = '#FF00D42D'
    $psISE.Options.TokenColors['CommandParameter'] = '#FFFFDE00'
    $psISE.Options.TokenColors['CommandArgument'] = '#FFFFFFFF'
    $psISE.Options.TokenColors['Number'] = '#FF98FE1E'

To use it, I just dot the script into my PowerShell ISE profile (see the $profile variable while in PowerShell ISE) like so (where ./Themes/blackboard.ps1 is the path to the blackboard theme):

    . ./Themes/blackboard.ps1

The script is a conversion I did of the [vim blackboard theme which itself is a clone of the blackboard theme from TextMate](http://www.vim.org/scripts/script.php?script_id=2280). I'm sure it could use some tweaking, but it works for me for now.

One thing I'm missing so far is how to change the color of the text caret. Because I have a black background, I can't see where I've got focus in the editor! Hopefully the PowerShell team will add an additional property to the Options to change the caret color or, even better, hopefully I've just missed the setting :-)

Let me know what you think! I've got even more PowerShell profile posts I'm working on so stay tuned.

**UPDATE:** Based on Joel's comment, I've posted a bug on the Microsoft Connect site for PowerShell. Go vote for it at [https://connect.microsoft.com/feedback/ViewFeedback.aspx?FeedbackID=390304&SiteID=99](https://connect.microsoft.com/feedback/ViewFeedback.aspx?FeedbackID=390304&SiteID=99). Note that you can only access the site if you've signed up on Microsoft Connect and added PowerShell as a project.


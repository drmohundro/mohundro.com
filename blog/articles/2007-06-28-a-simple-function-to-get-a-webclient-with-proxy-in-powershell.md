
title: "A simple function to get a WebClient (with proxy) in PowerShell"
author: David
date: 2007/06/28
categories: powershell;utilities
guid: e9b90dbc-398d-4b0b-a094-44f349b18bbb

I was browsing around a few days ago and came across a link to a blog post on the SAPIEN website about [searching live.com from PowerShell](http://blog.sapien.com/current/2007/5/7/live-search-in-windows-powershell.html). Sounds cool, I think, so I download it to try it out only to be thwarted by the proxy at work. 

There are a lot of scripts out there that use the System.Net.WebClient and the vast majority don't take proxies into account. To get around this issue, here's a simple script that I wrote to help out:

    function Get-ProxyWebClient {
      $webclient = New-Object System.Net.WebClient
      $proxy = New-Object System.Net.WebProxy($global:ProxyUrl, $global:ProxyPort)
      $proxy.Credentials = (Get-Credential).GetNetworkCredential()
      $webclient.Proxy = $proxy
      return $webclient
    }

This script makes the assumption that you've already predefined the $global.ProxyUrl and $global.ProxyPort variables in your profile. It is also nice for me because it prompts me for my credentials instead of having them hard-coded in the script or in my profile. 

Now I can also check the weather from PowerShell using the Show-Weather script that the guys at SAPIEN provided in their [&#252;ber-prompt post](http://blog.sapien.com/current/2007/6/13/one-prompt-to-rule-them-all.html).


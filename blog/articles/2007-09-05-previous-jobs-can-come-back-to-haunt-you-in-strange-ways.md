
title: "Previous jobs can come back to haunt you in strange ways"
author: David
date: 2007/09/05

When I was in high school, my first job was preparing food at a local Taco Mayo. I didn't last long there. Soon afterwards, I began working at a local ISP doing tech support. I still remember all of the problems that brand new 56K modems had, because the v92 standard hadn't really been standardized yet. 

Anyway, all that to say my first *real* job was tech support at an ISP. Tonight, I was practicing my troubleshooting skills on my internet connection. I got home from work and couldn't connect to anything except my router. 

Here are the steps I took: 

- 1) Opened Outlook and IE and tried to go somewhere. Nothing happened. 
- 2) Recognized there was a problem. 
- 3) Pulled up a command prompt and tried to ping [www.google.com](http://www.google.com) and then my ISPs website. No dice. 
- 4) I rebooted. 
- 5) I pulled up an admin command prompt (UAC) and tried pinging again with no success. 
- 6) I released my IP address and then renewed it (ipconfig /release and then ipconfig /renew - this is why I needed an elevated prompt). 
- 7) I tried pinging again without success. 
- 8) I unplugged my cable modem, waited for 15 seconds, plugged it back up and then tried again... without success. 
- 9) I navigated to my router's page in my browser which came up great. 
- 10) I released and renewed my IP address from the router. Then I tried pinging... once again without success. 
- 11) I bypassed my router and connected my ethernet cable directly to my cable modem. 
- 12) I unplugged and then plugged back in my cable modem and tried pinging without success. 
- 13) I got frustrated and tried *most* of the above things in random order to try to get it to work. 
- 14) I called tech support. 
- 15) I got more frustrated dealing with the automated answering system. 
- 16) I got *FAR* more frustrated dealing with the automated tech support - that had me do everything I had already tried. 
- 17) The automated tech support finally asked if I'd like to speak with a real person - I said yes. 
- 18) The real tech support picked up quickly (thankfully) and had me power off my modem and bypass my router (already done) and then try pinging which didn't work. 
- 19) Then he asked me to reboot. 
- 20) Knowing that this was my second reboot, I was skeptical but I went ahead with it for the real tech support guy's benefit. 
- ... 
- 21) It starts working. 
- 22) I look and feel like an idiot. 

Moral of the story - rebooting always fixes the problem. Just try it over and over and over again. Until it starts working. 

\*sigh\*

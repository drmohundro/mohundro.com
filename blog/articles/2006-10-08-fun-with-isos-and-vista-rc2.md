
title: "Fun with ISOs and Vista RC2"
author: David
date: 2006/10/08

<p>I recently updated my Vista installation to RC2 (build 5744), which went fairly smoothly for me. The installation went even better than for RC1, <a href="http://www.mohundro.com/blog/PermaLink,guid,d2103c85-a702-47ae-b149-48c3ba43fcb2.aspx">because I had moved my documents to my D: drive</a>, so once I told Vista where they were, most of my initial configuration was done! I did have one weird problem with installation, but it disappeared when I booted from the DVD instead of attempting to install from within the previous install of Vista.</p> <p>I ran into my biggest problem today, though, when I attempted to install Visual Studio 2005. I had downloaded the ISO quite a while back and had used it to install VS2005 first on Windows XP SP2 and later on Vista RC1 without any problems. Under XP, I was able to use the Virtual CD tool that Microsoft provides, but it wasn't supported under Vista. As a result, I had found the <a href="http://www.slysoft.com/en/virtual-clonedrive.html">SlySoft Virtual CloneDrive</a>, which worked great on Vista RC1. It didn't seem to work so well on Vista RC2 and I have no idea why.</p> <p>The Visual Studio 2005 installation would fail with an error loading the file Rmt9x.mst. My problem sounded quite a bit like <a href="http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=203630&amp;SiteID=1">this one</a> detailed on the MSDN forums, but I wasn't sure. I had also noticed some strange behavior with restarting since I had installed RC2, such as the restart hanging, even to the point of me having to power down my computer instead of waiting on the restart. On a hunch, I decided to uninstall Virtual CloneDrive and give <a href="http://www.daemon-tools.cc/dtcc/index.php?">DAEMON Tools</a> a try. It helped that DAEMON Tools said that it supported Vista!</p> <p>Once Virtual CloneDrive was uninstalled, I started up the DAEMON Tools installation which asked for a reboot. I was a little wary, but went ahead and let it and it rebooted without any hangs! First good sign!</p> <p>After the reboot, I started up DAEMON Tools and pointed it to the VS2005 ISO and started up setup. The installation ran great, so everything points to something in Virtual CloneDrive not working as expected under RC2.</p> <p>As I mentioned earlier, I still have no idea why Virtual CloneDrive began having problems under RC2. It ran great under RC1 and I really liked the interface it provided. DAEMON Tools is admittedly less user friendly, but it certainly gets the job done, which is what I needed.</p>
--- 
title: The new blog is live!
date: 12/23/2010

So, my blog looks different now... and it isn't just a new theme. It's
new blog engine, new web host, new look and feel, new everything!

## The back story...

So, I started my blog back in January of 2006. At the time, dasBlog was
one of the most prevalent .NET blog engines around on .NET. So, I
decided to roll my blog on dasBlog. I chose a recommended web host that
had great pricing and also supported ASP.NET. All was great. At the
time, I was posting every single thought that came to mind which
resulted in a good 20 to 30 posts every month. Slowly, though, over the
years, I started to find my blogging groove.

Fast forward to this year. dasBlog doesn't hold the high place it once
had as top .NET blogging engine. Worse still, my web host had seriously
gone down the tubes. [Lee Holmes posted that his uptime was averaging
60%](http://www.leeholmes.com/blog/2010/09/08/and-the-winner-is-arvixe/).
If you're not familiar with uptime percentages, that means that my
visitors had a 60% chance for my site to be up.

The last straw for me was seeing a link to the Google cache for my site
mentioned on a response to an MSDN forum question because it was down.
It was time to move.

## The new platform!

The short version: the new blog is running on
[toto](https://github.com/cloudhead/toto), a Ruby-powered blogging
engine. I'm hosting it on [Heroku](http://heroku.com).

The longer version: lately (err, the last couple of years), I've become
much more interested in learning and writing Ruby code. I had already
written two fairly small sites in Ruby (one in Sinatra and one in Rails)
and both were hosted on Heroku. The process for those sites had been
great. The deployment story was amazing - it was literally `git push
heroku master`. You couldn't get any better as far as I was concerned.

So, I knew I was interested in moving platforms; however, there were
some problems with this. First off, I had to convert my posts. Second, I
wanted 301 redirects in place. Third, I needed a theme.

## Converting my posts

Thankfully, dasBlog stores its posts in a fairly straightforward way -
there is an XML file for each day that can contain one or more posts. On
the other hand, toto stores its posts as straight text files formatted
as [Markdown](http://daringfireball.net/projects/markdown/) (if you've
used StackOverflow, you've used Markdown - it's what they use for their
questions and answers).

So, how best to convert? I ended up writing a smallish Ruby script to
convert that made use of Nokogiri to parse the XML. The main script
turned out to be just under 60 lines. Writing the script turned out to
be the best thing I could do, because it let me re-run the conversion
process. I could add small tweaks to try to strip out invalid HTML and
try out my changes. Since I had everything in source control, I could
just run a diff against the converted posts to see if everything still
looked good.

## Redirecting old URLs

Redirecting my old URLs to the new URL format turned out to be easy for
80% of my posts and time consuming for the rest. I used a Ruby gem
called rack-rewrite.

The below code snippet accounted for the easy 80%.
    
    r301 %r{/blog/
      (\d{4})/  # year
      (\d{2})/  # month
      (\d{2})/  # day
      (\w+?)    # slug
      \.aspx$}x, lambda { |match, rack_env|

      helper = RedirectHelper.new

      year, month, day, slug = match[1], match[2], match[3], helper.convert_legacy_slug(match[4])
      "/blog/#{year}/#{month}/#{day}/#{slug}/"
    }

I just used a fairly simple regex to parse the old format out and move
it over to the new format. I did end up building a RedirectHelper class
that contained most of the logic for handling the remaining 20%.
Overall, though, it seems to be working well, though I'm sure I probably
missed a few posts. If you are browsing around and run into any 404s,
feel free to let me know.

## The new theme

My starting point for the blog theme was the [dorothy toto
theme](https://github.com/cloudhead/dorothy). It provided a nice HTML5
basic structure that I was able to build upon. Since it was already
using HTML5, I decided to stick with that. Chances are, the site looks
like junk on Internet Explorer 6 and 7. It honestly doesn't look great
on IE 8 even, though the IE 9 beta renders it just fine.

The fun things for me in the conversion were getting to use the Google
WebFont API - that's how the cool fonts are getting loaded in.
Everything else was just some minor CSS changes.

I did elect to use Disqus for my comments, because Toto doesn't provide
a commenting solution out of the box. This actually has a couple of
ramifications for me. First, I lost all of my old comments. That wasn't
a huge deal, because I never really had a boatload of them. Second, it's
an external service that I'm not in control of. Mostly, this doesn't
bother, but I do think some of my former coworkers back in the Fort
Smith area might not be able to comment because I think Disqus is
blocked by their firewall. At least it was when I was still working
there.

## Wrapping this post up

So, anyway, there you go, my new blog. Actually, I'd like your input
now. I want to post the code for the blog up on [my GitHub
account](https://github.com/drmohundro), but I have some questions about
the best way to do this. First off, I don't want my blog content
duplicated. It isn't a huge deal, but I don't want Google returning
search results to the GitHub hosted markdown files over my posts. It
probably won't, because there won't be returned as the main HTML like it
would be when served from my blog, but it is still a concern I've got.

And I guess that's it actually. Try out the comments if you want. Let me
know if you like the look or if you notice any broken links or broken
functionality.

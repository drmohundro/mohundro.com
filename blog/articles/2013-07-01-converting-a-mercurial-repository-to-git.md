---
title: Converting a Mercurial repository to Git
date: 2013/07/01

About three years ago, our team migrated from using Subversion to Mercurial,
primarily because of the pain involved with branches. If you've heard the
phrase "tree conflict," then you know what we were dealing with.

We've been *very* happy with Mercurial since that time. Other than the initial
ramp up time for the team to learn the intricacies of DVCSs, we honestly
haven't had any major issues. What might have taken half a day to work through
now takes minutes.

However, if you've noticed the title, we have now migrated to Git. I'm not
going to spend much time on the "why" except to say that we were standardizing
on a common VCS tool across the enterprise and that the current plan is to use a
commercial Git offering.

## Caveats about our usage of Mercurial

Before I go through the options that we looked at, I do want to mention some
points about how we were using Mercurial.

First off, we didn't use the standard "First Last <email@email.com>" format in
our HG config. Don't ask why, because I don't remember why. Short of rewriting
history, it was something we were stuck with.

Second, there were three years of history from a team of developers. In other
words, the repository was quite large.

## hg-fast-export

The first option that I researched was `hg-fast-export` (via
[fast-export](https://github.com/frej/fast-export)). It was nice in that you
could pass in an authors mapping file to convert from old name formats to new
name formats.

The basic steps to use it are:

```bash
mkdir my-new-repo
cd my-new-repo
git init
hg-fast-export -r ../path/to/hg/repo -A ../authors.txt
```

It actually worked fine for our smaller repositories. It did however fail when
I tried to convert our main repository. My guess is that we had a branch
somewhere that had multiple heads or something. I couldn't find the revision
it failed on which suggests to me that a bad commit had been stripped or
something. Not ideal, but something that we had to deal with.

The other issue is that it took *hours* to convert a large repository. This
wouldn't be a big deal in and of itself except that I couldn't get the
conversion to work on our primary repo.

## hg-git

Given that `hg-fast-export` wasn't working well, I then looked into
[hg-git](http://hg-git.github.io/). hg-git was promising in that I thought I'd
be able to set up a git remote and push to it from the existing hg repository;
however, I had issues with that. 

I *was* able to get the `hg gexport` command working, though. It creates a git
directory under your .hg directory (unless you configure the `intree` option).
This process worked quite well, but it took *eight* hours to complete.

Once the conversion happened, I could copy the git directory out, rename it to
.git and I had my local git repository (note that I did have to set the git
`core.bare` option to false).

At this point, I had gone from a multiple hour long process that didn't work
to a multiple hour long process that did work. Neither was ideal, though,
because I had to tell the team to stop pushing changes while I was converting
the repository. That, or re-run the export again.

## git-remote-hg

Given that during my one successful run of `hg gexport`, I had missed some
commits, I decided to do a little more research, which led me to the
[`git-remote-hg`
script](https://github.com/git/git/blob/master/contrib/remote-helpers/git-remote-hg).
This script will actually be shipping with git at some point, which gives it
some credibility in my book. It works by letting you clone from HG via a URL,
like `git clone hg::/path/to/your/repo`. Note the leading `hg::`. The other
nice thing is that, since it is a remote in git, you can continue to pull
updates down.

My favorite thing about git-remote-hg, though, is its speed. It could clone
our entire repository in under 15 minutes.

To get it to work, you just have to drop it in your PATH somewhere. I tried
to get it to work on Windows, but was unsuccessful. I decided to bail and
use it on OSX because 1) OSX was available and 2) I had read a lot of
successes online from people who were using it on OSX. I did have to tweak the
first line of the script to point to my homebrew install of Python, but other
than that, it just worked.

The one issue with git-remote-hg I had is that I couldn't find an effective
means of modifying authors. After the conversion, I could run `git
filter-branch --env-filter` scripts to modify the git authors ([see the GitHub
"changing author info"
link](https://help.github.com/articles/changing-author-info)). The problem with
the these scripts is that, as far as I could tell, they only work on one author at a
time and they took about 45 minutes to complete.

## Final solution

It was at this time that I remembered [Scott Hanselman's words that "the
Internet is not a black
box"](http://www.hanselman.com/blog/TheInternetIsNotABlackBoxLookInside.aspx).
In other words, the git-remote-hg script also is not a black box - it's just a
Python script. Perhaps I could add my own author mapping code and shorten the
feedback loop from hours to minutes.

Basically, I changed the code in the method `fixup_user()` to have the
following code (with censored users and emails):

```python
found_user = '%s <%s>' % (name, mail)

user_mapping = {
    "Bob <unknown>": "Bob Dev <bob.dev@fakeemail.com>",
    "John <unknown>": "John Doe <john.doe@fakeemail.com>",
    "Jane <unknown>": "Jane Smith <jane.smith@fakeemail.com>",
}

try:
    mapped_author = user_mapping[found_user]
    found_user = mapped_author
except KeyError:
    warn("Couldn't find user mapping for %s" % found_user)

return found_user
```

Finally, success! The best part was that I had a repeatable process that ran
quickly! Once that was complete, I was able to successfully push the
repository to the new remote that I had set up.

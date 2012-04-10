---
title: Code review of randomness
date: 2012/04/10

Last week, prior to a weekly meeting, one of my team members had the idea to
take a few minutes before the meeting to review some code. We already do code
reviews prior to deployments, but we've been wanting to improve the quality
of the code reviews... we wanted to really have good dialog about code quality
and be able to share that discussion with the whole team.

## Code reviews... but random

So we were all on board with a more fully featured code review... but whose
code would we choose? We weren't exactly getting volunteers left and right to
offer up their code... probably because they knew that everyone else would
find *some* reason to skewer it. After all, no code is perfect... there is
almost always room for improvement.

Another problem with volunteered code is that it would typically be code that
had been seen recently. New code tends to be of higher quality than legacy
code; however, we have plenty of legacy code that could be greatly improved by
having the team take just 10 minutes to look over it.

The solution was a PowerShell script that I whipped together in about 15
minutes. Here it is:

    param (
        $fileType = "cs",
        $directoryToSearch = "c:\path\to\source\repo"
    )

    $scriptDir = (Split-Path $MyInvocation.MyCommand.Path -Parent)
    $editor = 'C:\Program Files\Sublime Text 2\sublime_text.exe'

    $excludedFilePaths =
        '\.Designer\.cs',
        '\.generated\.cs',
        '\\Service\sReferences\\'

    function notIn($lookFor, $toSearch) {
        foreach ($toExclude in $toSearch) {
            if ($lookFor -match $toExclude) {
                return $false
            }
        }
        return $true
    }

    function allFilesOfType {
        ls -filter "*.$fileType" -recurse |
            where { notIn $_.FullName $excludedFilePaths }
    }

    Push-Location $directoryToSearch

    "Drum roll, please..."

    $randomlySelectedFile  = allFilesOfType | Get-Random -count 1 | select -expand FullName
    & $editor $randomlySelectedFile

    Pop-Location

As you can see, it is pretty basic. Most of the complexity involves excluding
Designer or generated files. Once the script determines a random file, it
opens it in a text editor for the team to view. From there, we began looking
at it as a team and calling out issues... "we should use var here," "can we
rename that variable?," "I think we need to dispose of that object," etc. In a
short 15 minutes, we as a team were able to find all sorts of minor issues
with the code.

## Team Learning, Team Dialog, and Decreasing Technical Debt

By reviewing the code together, it allowed us to share the learning about what
we *as a team* thought made for quality code. Often while pair programming,
these discussions come up, but they were only between 2 or 3 at most... by
doing this together, we could all benefit from the discussion.

Another benefit is that it forces us to become familiar with random parts of
our system. I'm confident that almost every development team has some aspect of
the "Train (or bus) Problem" as I call it... if someone on your team were hit
by a train (or bus), could the rest of the team pick up without them? If not,
then there is a potential liability there. By reviewing code as a group, the
team can become familiar with the code together.

From a technical debt perspective, we now have another tool in our arsenal
that we can use to slowly improve code. Ideally, if we continue improving our
core code in this way, in six months or so we'll have trouble finding issues.
We might have to go after specific sections of our code to review at that
point. Either way, we've got something started that seems to be very
beneficial.

Leave a comment if your team does something similar.


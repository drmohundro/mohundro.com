---
title: Easy Date Math with PowerShell
date: 2013/02/05

Date math is hard... at least for me. My brain has trouble thinking in terms
of dates. I probably overanalyze things, but if you say something like "let's
meet for dinner 2 days from now," I immediately start thinking things like
"inclusive" or "exclusive" dates. Do you mean 2 days from now including today?
Does it include today if it is morning, but if it is evening, we'll start with
tomorrow? As I said, I'm sure I'm overanalyzing.

In any event, I have discovered that I can easily use PowerShell to calculate
dates for me. For the last few years, I've been using code like 
`([datetime]'1/2/2013').AddDays(3)` to help me figure out what day something
would be.

At work, we have recurring dev meetings... and for whatever reason, we decided
to have them on a "tri-weekly" basis. Not every week, not every other week,
not monthly, but *tri-weekly*. My date-encumbered brain just can't handle this
stress.

So, I turn to PowerShell. Behold, the `Get-DevLunchDays.ps1` script:

```powershell
$initialDate = [datetime]'2013/1/8'

$rollingDate = $initialDate

do {
    Write-Host $rollingDate.ToShortDateString()
    $rollingDate = $rollingDate.AddDays(21)
} until ($rollingDate -ge [datetime]'2013/12/31')
```

I've hardcoded an initial date in the `$initialDate` variable and then I just
script out the rest. Sure, it's simple, but it saves me time and stress!

---
title: CasperJS Presentation
date: 2012/06/21

It's been a good 4 years since I last gave a public presentation in
[Memphis](/blog/2008/09/30/slides-and-notes-from-mnug-talk/) (it was on
PowerShell), so I figured it was time to give another talk. Tonight, I gave a
short talk on [CasperJS](http://casperjs.org/) at the [Memphis Java User
Group](http://www.memphisjug.org/event/show/36).

If you're unfamiliar with CasperJS, I like to think of it as a really nice
wrapper library around [PhantomJS](http://phantomjs.org/), which is a headless
WebKit engine. If you know Chrome, you know WebKit... WebKit is just the open
source backing project for Chrome. PhantomJS lets you drive Chrome in an
automated way with JavaScript. CasperJS is a libary to provide syntantic sugar
around PhantomJS. It also provides methods to let you write integration tests
for your web stack.

Just to give you a sample script, here is one that I demoed that verifies that
my blog title is correct.

    var casper = require('casper').create();

    casper.start('http://mohundro.com', function() {
      this.test.assert(this.getCurrentUrl().indexOf('mohundro') !== -1, 'the url should not redirect away');
      this.test.assertTitle('David Mohundro', 'my blog has the title of my name');
    });

    casper.run(function() {
      this.test.renderResults(true);
    });

A nicety with CasperJS is that it has native CoffeeScript support. The same
script could be written like so:

    casper = require('casper').create()

    casper.start 'http://mohundro.com', () ->
      @test.assert @getCurrentUrl().indexOf('mohundro') != -1, 'the url should not redirect away'
      @test.assertTitle 'David Mohundro', 'my blog has the title of my name'

    casper.run () ->
      @test.renderResults true

If you came out, I hope you enjoyed the talk. I've posted my slides and demos
out on my [presentations Github
repository](https://github.com/drmohundro/presentations). Check it out.

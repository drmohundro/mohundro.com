
title: "NHibernate Unit Testing… with Fluent NHibernate!"
author: David
date: 2009/05/18

I’ve been attempting to learn NHibernate lately. One of the big draws for me was the ability to write unit tests that did hit a database, but an in-memory one. Ayende recently posted on [how to use SQLite to get in-memory unit tests](http://ayende.com/Blog/archive/2009/04/28/nhibernate-unit-testing.aspx). His example assumed standard hbm mappings and configuration. 
I was curious how hard it would be port his example over to Fluent NHibernate. Not surprisingly, it was quite easy actually! 
Here’s the Blog entity I used, which is based on the usage I saw from Ayende’s post: 
<script src="http://gist.github.com/114239.js"></script> 
And here is the mapping: 
<script src="http://gist.github.com/114241.js"></script> 
As you can see, it is pretty straight forward so far. The next piece of code is the Fluent NHibernate implementation of Ayende’s InMemoryDatabaseTest. 
<script src="http://gist.github.com/114242.js"></script> 
There aren’t too many differences really. We’re using the same SchemaExport, but we do need to call ExposeConfiguration so that we can store off a reference to the Configuration to be used by the SchemaExport instance. 
The final piece, the actual test itself, is identical to Ayende’s example, except that I’m using MbUnit instead of xUnit: 
<script src="http://gist.github.com/114244.js"></script> 
Nice and easy! I like it! 
As you can also tell, I’m experimenting with using [github](http://github.com/)’s [gist](http://gist.github.com/) feature. I’ve been using [github](http://github.com/) to store off my dot files and other environment-related settings as well as my presentations, but the gist feature seems pretty nice.

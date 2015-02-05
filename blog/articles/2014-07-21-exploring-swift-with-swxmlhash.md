---
title: Exploring Swift with SWXMLHash
date: 2014/07/21

Over the last month or so, I've been playing around with Swift, the new language that Apple unveiled at WWDC this year. Thus far, I've really enjoyed it. To get started with learning it, I thought I'd convert one of our iOS applications at work over to Swift from Objective-C. I'm only doing it in my spare time, so it might never get published, but I've learned a lot since starting.

## The Background

The iOS application that I'm converting hasn't been touched (aside from some bug fixes) in a couple of years, so it is woefully out of date. In addition, it was written by contractors that we used, so I'm unable to ask a lot of questions while I convert. It's been hard.

One of the most difficult things that I've had to deal with is its integration with our API... which happens to be a SOAP API. If you're from a .NET background, SOAP is easy. In fact, from .NET, SOAP almost lives up to its acronym of being "simple" (SOAP stands for "Simple Object Access Protocol"); however, if you're using SOAP from a language like Objective-C, Ruby or JavaScript, SOAP is downright painful. RESTful APIs are much easier to consume. Unfortunately for me, only a few of our SOAP APIs have REST endpoints at the moment - meaning I'm stuck with SOAP.

The existing iOS application does all of its XML work using with pure strings. In other words, the entire SOAP envelope is built in a hardcoded string. iOS does provide an XML parsing class called `NSXMLParser`, but it's at best similar to using the `XmlReader` in .NET. It doesn't try to provide an XML DOM at all, but only provides forward reading of XML.

I knew I'd want to improve the XML parsing support.

## Enter SwiftyJSON

While researching and reading up on Swift, I came across the [SwiftyJSON](https://github.com/lingoer/SwiftyJSON/) library. It takes a neat approach to parsing JSON by making the reading of JSON look a lot like using a combination of an array and a dictionary.

For example, given the following JSON...

```json
{
	"title": "Swifty Example",
	"user": {
	"login": "drmohundro",
	"type": "User",
	"site_admin": false
	}
}
```

It could read values out like so...

```swift
let title = json["title"].string?
let isAdmin = json["user"]["site_admin"].bool?
```

What's especially fascinating (to me) is that the library represents each value (an instance of `JSONValue`) as an enum. Swift's enums are *far* more powerful than they are in the CLR. CLR enums are basically fancy wrappers around integers. Swift enums can represent any type, whether it be an int, float, string, or custom type.

I decided to take what I saw in SwiftyJSON and try to build a similar library for XML parsing.

## Enter SWXMLHash

You can see the results of my work at [SWXMLHash](https://github.com/drmohundro/swxmlhash). 

__Naming disclaimer__ - naming projects is *hard*. I initially wanted to name it "SwiftyXML", but I felt like I'd need to get permission from the author of SwiftyJSON first, because I could see introducing an entire "Swifty" library to handle parsing a multitude of types of data. I ended up going with SWXMLHash because SW = Swift and the XMLHash part represents my idea that the library is parsing XML into a hash (aka dictionary).

The library provides two components. The first component handles parsing the XML into an in-memory data structure, which uses the `NSXMLParser` type behind the scenes. The second component is the actual lookup (which is heavily based on SwiftyJSON).

It isn't complete by any means, but it does fully support array and dictionary indexing.

Given the following XML (which is a snippet of the [sample XML from MSDN's XML sample!](http://msdn.microsoft.com/en-us/library/ms762271\(v=vs.85\).aspx))...

```xml
<root>
	<header>
		<title>Test Title Header</title>
	</header>
	<catalog>
		<book id=\"bk101\">
			<author>Gambardella, Matthew</author>
			<title>XML Developer's Guide</title>
			<genre>Computer</genre>
			<price>44.95</price>
			<publish_date>2000-10-01</publish_date>
			<description>An in-depth look at creating applications with XML.</description>
		</book>
		<book id=\"bk102\">
			<author>Ralls, Kim</author>
			<title>Midnight Rain</title>
			<genre>Fantasy</genre>
			<price>5.95</price>
			<publish_date>2000-12-16</publish_date>
			<description>A former architect battles corporate zombies, an evil sorceress, and her own childhood to become queen of the world.</description>
		</book>
		<book id=\"bk103\">
			<author>Corets, Eva</author>
			<title>Maeve Ascendant</title>
			<genre>Fantasy</genre>
			<price>5.95</price>
			<publish_date>2000-11-17</publish_date>
			<description>After the collapse of a nanotechnology society in England, the young survivors lay the foundation for a new society.</description>
		</book>
	</catalog>
</root>
```

The following parsing options are allowed...

```swift
// begin parsing
let xml = SWXMLHash.parse(xmlToParse)

// will return "Test Title Header"
xml["root"]["header"]["title"].element?.text

// will return "Ralls, Kim"
xml["root"]["catalog"]["book"][1]["author"].element?.text

// will return "bk102"
xml["root"]["catalog"]["book"][1].element?.attributes["id"]

// will return "Computer, Fantasy, Fantasy"
", ".join(xml["root"]["catalog"]["book"].all.map { elem in elem["genre"].element!.text! })
```

There is still quite a bit of work to be done, but it does give me everything I need to parse the XML returned from my SOAP calls for now.

Check it out and let me know what you think.

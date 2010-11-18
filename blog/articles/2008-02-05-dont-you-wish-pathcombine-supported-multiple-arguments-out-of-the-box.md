
title: "Don't you wish Path.Combine supported multiple arguments out of the box?"
author: David
date: 2008/02/05
categories: programming;utilities
guid: 8ba7ef3c-0be3-45fa-be3b-4376942ac96d

I've found myself wishing that I could pass in more than two arguments to Path.Combine. That is, something like this:

    Path.Combine(rootPath, someCalculatedPath, someKnownFileName);

As it is, Path.Combine only accepts two arguments, so I end up with calls that look like this:

    Path.Combine(Path.Combine(rootPath, comeCalculatedPath), someKnownFileName);

It seems like a hassle to me. Here is a simple wrapper function (with accompanying test) that will accomplish this:

    public static class FileUtils
    {
        public static string CombinePaths(params string[] paths)
        {
            if (paths.Length == 0) return string.Empty; 

            return Path.Combine(paths.First(), CombinePaths(paths.Skip(1).ToArray()));
        }
    } 

    [TestFixture]
    public class FileUtilsTests
    {
        [Test]
        public void Should_combine_paths_correctly()
        {
            string expected = @"c:\some\path\to\file.txt"; 

            Assert.AreEqual(expected, FileUtils.CombinePaths("c:\\some", "path\\to", "file.txt"));
        }
    }


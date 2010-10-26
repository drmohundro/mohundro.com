
title: "Designer class not being used by designer"
author: David
date: 2006/08/21

In one of my projects at work, I ran into a situation where Visual Studio 2005 didn't recognize my designer files (i.e. MainForm.Designer.vb) so all of the serialized designer code was getting stuck in a new InitializeComponent in my code file (i.e. MainForm.vb). Of course, because my Designer code was a partial class, I got an error out of it. In my experience, this behavior is sort of obscure, but here is an easy fix.<br /><br />Open up the project file (which in my case was GUI.vbproj) in a text editor and do a search for your Designer file. You should see some tags that look like this:<br /><pre>&lt;Compile Include="CustomControl.Designer.vb"&gt;<br />&lt;/Compile&gt;<br />&lt;Compile Include="CustomControl.vb"&gt;<br />  &lt;SubType&gt;UserControl&lt;/SubType&gt;<br />&lt;/Compile&gt;<br /></pre>Now, what it SHOULD look like is this:<br /><pre>&lt;Compile Include="CustomControl.Designer.vb"&gt;<br />  <font color="#3333ff"><b>&lt;DependentUpon&gt;CustomControl.vb&lt;/DependentUpon&gt;</b></font><br />&lt;/Compile&gt;<br />&lt;Compile Include="CustomControl.vb"&gt;<br />  &lt;SubType&gt;UserControl&lt;/SubType&gt;<br />&lt;/Compile&gt;<br /></pre>I've bolded the important part for you. Basically, my project file, for whatever reason, was missing the &lt;DependentUpon&gt; tag. If you add that back, Visual Studio should start behaving as expected again.<br />

title: "DataBinding and Pointers, or \"Why is my DataBinding not working?\""
author: David
date: 2006/02/14

<P>Let's say you have the following class:</P>
<DIV style="FONT-SIZE: 9pt; BACKGROUND: #f0f0f0; COLOR: black; FONT-FAMILY: Consolas"><SPAN style="COLOR: teal">
<DIV style="FONT-SIZE: 9pt; BACKGROUND: #f0f0f0; COLOR: black; FONT-FAMILY: Consolas">
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;51</SPAN>&nbsp;<SPAN style="BACKGROUND: white; COLOR: navy">Public</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Class</SPAN><SPAN style="BACKGROUND: white"> Person</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;52</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Private</SPAN><SPAN style="BACKGROUND: white"> _name&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">As</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">String</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;53</SPAN>&nbsp;</P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;54</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Public</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Event</SPAN><SPAN style="BACKGROUND: white"> NameChanged&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">As</SPAN><SPAN style="BACKGROUND: white"> EventHandler</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;55</SPAN>&nbsp;</P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;56</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Public</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Property</SPAN><SPAN style="BACKGROUND: white"> Name()&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">As</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">String</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;57</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Get</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;58</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Return</SPAN><SPAN style="BACKGROUND: white"> _name</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;59</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">End</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Get</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;60</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Set</SPAN><SPAN style="BACKGROUND: white">(</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">ByVal</SPAN><SPAN style="BACKGROUND: white"> value&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">As</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">String</SPAN><SPAN style="BACKGROUND: white">)</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;61</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; _name = value</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;62</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; OnNameChanged(EventArgs.Empty)</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;63</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">End</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Set</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;64</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">End</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Property</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;65</SPAN>&nbsp;</P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;66</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Protected</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Sub</SPAN><SPAN style="BACKGROUND: white"> OnNameChanged(</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">ByVal</SPAN><SPAN style="BACKGROUND: white"> e&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">As</SPAN><SPAN style="BACKGROUND: white"> EventArgs)</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;67</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">RaiseEvent</SPAN><SPAN style="BACKGROUND: white"> NameChanged(</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Me</SPAN><SPAN style="BACKGROUND: white">, e)</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;68</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">End</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Sub</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;69</SPAN>&nbsp;<SPAN style="BACKGROUND: white; COLOR: navy">End</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Class</SPAN></P></DIV><!--EndFragment--></SPAN></DIV><!--EndFragment-->
<P>We've set up the [Property]Changed events so that DataBinding will work correctly. Now, let's assume you want to&nbsp;bind the name property over to the text property of your TextBox control. We'll go the simple data binding route here for simplicity.</P>
<DIV style="FONT-SIZE: 9pt; BACKGROUND: #f0f0f0; COLOR: black; FONT-FAMILY: Consolas">
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;&nbsp;3</SPAN>&nbsp;<SPAN style="BACKGROUND: white; COLOR: navy">Public</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Class</SPAN><SPAN style="BACKGROUND: white"> Form1</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;&nbsp;4</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Private</SPAN><SPAN style="BACKGROUND: white"> txtName&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">As</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">New</SPAN><SPAN style="BACKGROUND: white"> TextBox</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;&nbsp;5</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Private</SPAN><SPAN style="BACKGROUND: white"> _person&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">As</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">New</SPAN><SPAN style="BACKGROUND: white"> Person</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;&nbsp;6</SPAN>&nbsp;</P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;&nbsp;7</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Public</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Sub</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">New</SPAN><SPAN style="BACKGROUND: white">()</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;&nbsp;8</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: green">' This call is required by the Windows Form Designer.</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;&nbsp;9</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; InitializeComponent()</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;10</SPAN>&nbsp;</P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;11</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: green">' Add any initialization after the InitializeComponent() call.</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;12</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Me</SPAN><SPAN style="BACKGROUND: white">.Controls.Add(txtName)</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;13</SPAN>&nbsp;</P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;14</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; _person.Name =&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: maroon">"cool"</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;15</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; txtName.DataBindings.Add(</SPAN><SPAN style="BACKGROUND: white; COLOR: maroon">"Text"</SPAN><SPAN style="BACKGROUND: white">, _person,&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: maroon">"Name"</SPAN><SPAN style="BACKGROUND: white">)</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;16</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">End</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Sub</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;17</SPAN>&nbsp;</P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;18</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Private</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Sub</SPAN><SPAN style="BACKGROUND: white"> Form_Click(</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">ByVal</SPAN><SPAN style="BACKGROUND: white"> sender&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">As</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Object</SPAN><SPAN style="BACKGROUND: white">,&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">ByVal</SPAN><SPAN style="BACKGROUND: white"> e&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">As</SPAN><SPAN style="BACKGROUND: white"> EventArgs) _</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;19</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Handles</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Me</SPAN><SPAN style="BACKGROUND: white">.Click</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;20</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; _person.Name =&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: maroon">"clicked"</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;21</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">End</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Sub</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;22</SPAN>&nbsp;<SPAN style="BACKGROUND: white; COLOR: navy">End</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Class</SPAN></P></DIV><!--EndFragment-->
<P>There! Now the txtName will display "clicked" whenever you click on the form. Magic! Now, let's change that Click event like so to see what happens:</P>
<DIV style="FONT-SIZE: 9pt; BACKGROUND: #f0f0f0; COLOR: black; FONT-FAMILY: Consolas"><SPAN style="COLOR: teal">
<DIV style="FONT-SIZE: 9pt; BACKGROUND: #f0f0f0; COLOR: black; FONT-FAMILY: Consolas">
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;18</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Private</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Sub</SPAN><SPAN style="BACKGROUND: white"> Form_Click(</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">ByVal</SPAN><SPAN style="BACKGROUND: white"> sender&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">As</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Object</SPAN><SPAN style="BACKGROUND: white">,&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">ByVal</SPAN><SPAN style="BACKGROUND: white"> e&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">As</SPAN><SPAN style="BACKGROUND: white"> EventArgs) _</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;19</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Handles</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Me</SPAN><SPAN style="BACKGROUND: white">.Click</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;20</SPAN>&nbsp;</P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;21</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Dim</SPAN><SPAN style="BACKGROUND: white"> newPerson&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">As</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">New</SPAN><SPAN style="BACKGROUND: white"> Person</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;22</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; newPerson.Name =&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: maroon">"new person"</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;23</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; _person = newPerson</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;24</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">End</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Sub</SPAN></P></DIV><!--EndFragment--></SPAN></DIV><!--EndFragment-->
<P>Why would I ever want to do is&nbsp;this way? Well, let's say you're remoting somewhere to get your data and your background thread returns a fully populated object. The easiest thing to do is to just point to the new object... except that it doesn't work.</P>
<P>All we did was change our instance over, but&nbsp;the textbox never&nbsp;changed. Why not? Because of&nbsp;REFERENCES, POINTERS, and&nbsp;MEMORY ADDRESSES! That's why! Check this out:</P>
<DIV style="FONT-SIZE: 9pt; BACKGROUND: #f0f0f0; COLOR: black; FONT-FAMILY: Consolas">
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;18</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Private</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Sub</SPAN><SPAN style="BACKGROUND: white"> Form_Click(</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">ByVal</SPAN><SPAN style="BACKGROUND: white"> sender&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">As</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Object</SPAN><SPAN style="BACKGROUND: white">,&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">ByVal</SPAN><SPAN style="BACKGROUND: white"> e&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">As</SPAN><SPAN style="BACKGROUND: white"> EventArgs) _</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;19</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Handles</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Me</SPAN><SPAN style="BACKGROUND: white">.Click</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;20</SPAN>&nbsp;</P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;21</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Dim</SPAN><SPAN style="BACKGROUND: white"> newPerson&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">As</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">New</SPAN><SPAN style="BACKGROUND: white"> Person</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;22</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; newPerson.Name =&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: maroon">"new person"</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;23</SPAN>&nbsp;</P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;24</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Debug.WriteLine(</SPAN><SPAN style="BACKGROUND: white; COLOR: maroon">"Are references equal? "</SPAN><SPAN style="BACKGROUND: white"> &amp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Object</SPAN><SPAN style="BACKGROUND: white">.ReferenceEquals(txtName.DataBindings(</SPAN><SPAN style="BACKGROUND: white; COLOR: maroon">"Text"</SPAN><SPAN style="BACKGROUND: white">).DataSource, _person))</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;25</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; _person = newPerson</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;26</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Debug.WriteLine(</SPAN><SPAN style="BACKGROUND: white; COLOR: maroon">"Are references equal? "</SPAN><SPAN style="BACKGROUND: white"> &amp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Object</SPAN><SPAN style="BACKGROUND: white">.ReferenceEquals(txtName.DataBindings(</SPAN><SPAN style="BACKGROUND: white; COLOR: maroon">"Text"</SPAN><SPAN style="BACKGROUND: white">).DataSource, _person))</SPAN></P>
<P style="MARGIN: 0px"><SPAN style="COLOR: teal">&nbsp;&nbsp;&nbsp;27</SPAN>&nbsp;<SPAN style="BACKGROUND: white">&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">End</SPAN><SPAN style="BACKGROUND: white">&nbsp;</SPAN><SPAN style="BACKGROUND: white; COLOR: navy">Sub</SPAN></P></DIV><!--EndFragment-->
<P>Whoa! The first Debug.Writeline will give you TRUE, but the second will give you FALSE. You see, understanding how references and pointers work is important. The textbox's DataSource is holding onto a reference of the old Person instance. You now have two different instances in memory, whether you like it or not.</P>
<P>What do you do about it? Well, as far as I can tell, you can either update your DataSource reference (it did change after all) or you can move your properties over manually so that your references don't change. I'm open to suggestions on other methods here.</P>
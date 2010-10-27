
title: "DataBinding and Pointers, or \"Why is my DataBinding not working?\""
author: David
date: 2006/02/14

Let's say you have the following class:
<div style="FONT-SIZE: 9pt; BACKGROUND: #f0f0f0; COLOR: black; FONT-FAMILY: Consolas"><span style="COLOR: teal">
<div style="FONT-SIZE: 9pt; BACKGROUND: #f0f0f0; COLOR: black; FONT-FAMILY: Consolas">
<p style="MARGIN: 0px"><span style="COLOR: teal">   51</span> <span style="BACKGROUND: white; COLOR: navy">Public</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Class</span><span style="BACKGROUND: white"> Person</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   52</span> <span style="BACKGROUND: white">    </span><span style="BACKGROUND: white; COLOR: navy">Private</span><span style="BACKGROUND: white"> _name </span><span style="BACKGROUND: white; COLOR: navy">As</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">String</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   53</span> 
<p style="MARGIN: 0px"><span style="COLOR: teal">   54</span> <span style="BACKGROUND: white">    </span><span style="BACKGROUND: white; COLOR: navy">Public</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Event</span><span style="BACKGROUND: white"> NameChanged </span><span style="BACKGROUND: white; COLOR: navy">As</span><span style="BACKGROUND: white"> EventHandler</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   55</span> 
<p style="MARGIN: 0px"><span style="COLOR: teal">   56</span> <span style="BACKGROUND: white">    </span><span style="BACKGROUND: white; COLOR: navy">Public</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Property</span><span style="BACKGROUND: white"> Name() </span><span style="BACKGROUND: white; COLOR: navy">As</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">String</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   57</span> <span style="BACKGROUND: white">        </span><span style="BACKGROUND: white; COLOR: navy">Get</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   58</span> <span style="BACKGROUND: white">            </span><span style="BACKGROUND: white; COLOR: navy">Return</span><span style="BACKGROUND: white"> _name</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   59</span> <span style="BACKGROUND: white">        </span><span style="BACKGROUND: white; COLOR: navy">End</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Get</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   60</span> <span style="BACKGROUND: white">        </span><span style="BACKGROUND: white; COLOR: navy">Set</span><span style="BACKGROUND: white">(</span><span style="BACKGROUND: white; COLOR: navy">ByVal</span><span style="BACKGROUND: white"> value </span><span style="BACKGROUND: white; COLOR: navy">As</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">String</span><span style="BACKGROUND: white">)</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   61</span> <span style="BACKGROUND: white">            _name = value</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   62</span> <span style="BACKGROUND: white">            OnNameChanged(EventArgs.Empty)</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   63</span> <span style="BACKGROUND: white">        </span><span style="BACKGROUND: white; COLOR: navy">End</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Set</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   64</span> <span style="BACKGROUND: white">    </span><span style="BACKGROUND: white; COLOR: navy">End</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Property</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   65</span> 
<p style="MARGIN: 0px"><span style="COLOR: teal">   66</span> <span style="BACKGROUND: white">    </span><span style="BACKGROUND: white; COLOR: navy">Protected</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Sub</span><span style="BACKGROUND: white"> OnNameChanged(</span><span style="BACKGROUND: white; COLOR: navy">ByVal</span><span style="BACKGROUND: white"> e </span><span style="BACKGROUND: white; COLOR: navy">As</span><span style="BACKGROUND: white"> EventArgs)</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   67</span> <span style="BACKGROUND: white">        </span><span style="BACKGROUND: white; COLOR: navy">RaiseEvent</span><span style="BACKGROUND: white"> NameChanged(</span><span style="BACKGROUND: white; COLOR: navy">Me</span><span style="BACKGROUND: white">, e)</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   68</span> <span style="BACKGROUND: white">    </span><span style="BACKGROUND: white; COLOR: navy">End</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Sub</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   69</span> <span style="BACKGROUND: white; COLOR: navy">End</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Class</span>
</div>
<!--EndFragment--></span></div>
<!--EndFragment-->

We've set up the [Property]Changed events so that DataBinding will work correctly. Now, let's assume you want to bind the name property over to the text property of your TextBox control. We'll go the simple data binding route here for simplicity.
<div style="FONT-SIZE: 9pt; BACKGROUND: #f0f0f0; COLOR: black; FONT-FAMILY: Consolas">
<p style="MARGIN: 0px"><span style="COLOR: teal">    3</span> <span style="BACKGROUND: white; COLOR: navy">Public</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Class</span><span style="BACKGROUND: white"> Form1</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">    4</span> <span style="BACKGROUND: white">    </span><span style="BACKGROUND: white; COLOR: navy">Private</span><span style="BACKGROUND: white"> txtName </span><span style="BACKGROUND: white; COLOR: navy">As</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">New</span><span style="BACKGROUND: white"> TextBox</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">    5</span> <span style="BACKGROUND: white">    </span><span style="BACKGROUND: white; COLOR: navy">Private</span><span style="BACKGROUND: white"> _person </span><span style="BACKGROUND: white; COLOR: navy">As</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">New</span><span style="BACKGROUND: white"> Person</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">    6</span> 
<p style="MARGIN: 0px"><span style="COLOR: teal">    7</span> <span style="BACKGROUND: white">    </span><span style="BACKGROUND: white; COLOR: navy">Public</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Sub</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">New</span><span style="BACKGROUND: white">()</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">    8</span> <span style="BACKGROUND: white">        </span><span style="BACKGROUND: white; COLOR: green">' This call is required by the Windows Form Designer.</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">    9</span> <span style="BACKGROUND: white">        InitializeComponent()</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   10</span> 
<p style="MARGIN: 0px"><span style="COLOR: teal">   11</span> <span style="BACKGROUND: white">        </span><span style="BACKGROUND: white; COLOR: green">' Add any initialization after the InitializeComponent() call.</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   12</span> <span style="BACKGROUND: white">        </span><span style="BACKGROUND: white; COLOR: navy">Me</span><span style="BACKGROUND: white">.Controls.Add(txtName)</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   13</span> 
<p style="MARGIN: 0px"><span style="COLOR: teal">   14</span> <span style="BACKGROUND: white">        _person.Name = </span><span style="BACKGROUND: white; COLOR: maroon">"cool"</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   15</span> <span style="BACKGROUND: white">        txtName.DataBindings.Add(</span><span style="BACKGROUND: white; COLOR: maroon">"Text"</span><span style="BACKGROUND: white">, _person, </span><span style="BACKGROUND: white; COLOR: maroon">"Name"</span><span style="BACKGROUND: white">)</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   16</span> <span style="BACKGROUND: white">    </span><span style="BACKGROUND: white; COLOR: navy">End</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Sub</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   17</span> 
<p style="MARGIN: 0px"><span style="COLOR: teal">   18</span> <span style="BACKGROUND: white">    </span><span style="BACKGROUND: white; COLOR: navy">Private</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Sub</span><span style="BACKGROUND: white"> Form_Click(</span><span style="BACKGROUND: white; COLOR: navy">ByVal</span><span style="BACKGROUND: white"> sender </span><span style="BACKGROUND: white; COLOR: navy">As</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Object</span><span style="BACKGROUND: white">, </span><span style="BACKGROUND: white; COLOR: navy">ByVal</span><span style="BACKGROUND: white"> e </span><span style="BACKGROUND: white; COLOR: navy">As</span><span style="BACKGROUND: white"> EventArgs) _</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   19</span> <span style="BACKGROUND: white">        </span><span style="BACKGROUND: white; COLOR: navy">Handles</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Me</span><span style="BACKGROUND: white">.Click</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   20</span> <span style="BACKGROUND: white">        _person.Name = </span><span style="BACKGROUND: white; COLOR: maroon">"clicked"</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   21</span> <span style="BACKGROUND: white">    </span><span style="BACKGROUND: white; COLOR: navy">End</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Sub</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   22</span> <span style="BACKGROUND: white; COLOR: navy">End</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Class</span>
</div>
<!--EndFragment-->

There! Now the txtName will display "clicked" whenever you click on the form. Magic! Now, let's change that Click event like so to see what happens:
<div style="FONT-SIZE: 9pt; BACKGROUND: #f0f0f0; COLOR: black; FONT-FAMILY: Consolas"><span style="COLOR: teal">
<div style="FONT-SIZE: 9pt; BACKGROUND: #f0f0f0; COLOR: black; FONT-FAMILY: Consolas">
<p style="MARGIN: 0px"><span style="COLOR: teal">   18</span> <span style="BACKGROUND: white">    </span><span style="BACKGROUND: white; COLOR: navy">Private</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Sub</span><span style="BACKGROUND: white"> Form_Click(</span><span style="BACKGROUND: white; COLOR: navy">ByVal</span><span style="BACKGROUND: white"> sender </span><span style="BACKGROUND: white; COLOR: navy">As</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Object</span><span style="BACKGROUND: white">, </span><span style="BACKGROUND: white; COLOR: navy">ByVal</span><span style="BACKGROUND: white"> e </span><span style="BACKGROUND: white; COLOR: navy">As</span><span style="BACKGROUND: white"> EventArgs) _</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   19</span> <span style="BACKGROUND: white">        </span><span style="BACKGROUND: white; COLOR: navy">Handles</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Me</span><span style="BACKGROUND: white">.Click</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   20</span> 
<p style="MARGIN: 0px"><span style="COLOR: teal">   21</span> <span style="BACKGROUND: white">        </span><span style="BACKGROUND: white; COLOR: navy">Dim</span><span style="BACKGROUND: white"> newPerson </span><span style="BACKGROUND: white; COLOR: navy">As</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">New</span><span style="BACKGROUND: white"> Person</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   22</span> <span style="BACKGROUND: white">        newPerson.Name = </span><span style="BACKGROUND: white; COLOR: maroon">"new person"</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   23</span> <span style="BACKGROUND: white">        _person = newPerson</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   24</span> <span style="BACKGROUND: white">    </span><span style="BACKGROUND: white; COLOR: navy">End</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Sub</span>
</div>
<!--EndFragment--></span></div>
<!--EndFragment-->

Why would I ever want to do is this way? Well, let's say you're remoting somewhere to get your data and your background thread returns a fully populated object. The easiest thing to do is to just point to the new object... except that it doesn't work.

All we did was change our instance over, but the textbox never changed. Why not? Because of REFERENCES, POINTERS, and MEMORY ADDRESSES! That's why! Check this out:
<div style="FONT-SIZE: 9pt; BACKGROUND: #f0f0f0; COLOR: black; FONT-FAMILY: Consolas">
<p style="MARGIN: 0px"><span style="COLOR: teal">   18</span> <span style="BACKGROUND: white">    </span><span style="BACKGROUND: white; COLOR: navy">Private</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Sub</span><span style="BACKGROUND: white"> Form_Click(</span><span style="BACKGROUND: white; COLOR: navy">ByVal</span><span style="BACKGROUND: white"> sender </span><span style="BACKGROUND: white; COLOR: navy">As</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Object</span><span style="BACKGROUND: white">, </span><span style="BACKGROUND: white; COLOR: navy">ByVal</span><span style="BACKGROUND: white"> e </span><span style="BACKGROUND: white; COLOR: navy">As</span><span style="BACKGROUND: white"> EventArgs) _</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   19</span> <span style="BACKGROUND: white">        </span><span style="BACKGROUND: white; COLOR: navy">Handles</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Me</span><span style="BACKGROUND: white">.Click</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   20</span> 
<p style="MARGIN: 0px"><span style="COLOR: teal">   21</span> <span style="BACKGROUND: white">        </span><span style="BACKGROUND: white; COLOR: navy">Dim</span><span style="BACKGROUND: white"> newPerson </span><span style="BACKGROUND: white; COLOR: navy">As</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">New</span><span style="BACKGROUND: white"> Person</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   22</span> <span style="BACKGROUND: white">        newPerson.Name = </span><span style="BACKGROUND: white; COLOR: maroon">"new person"</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   23</span> 
<p style="MARGIN: 0px"><span style="COLOR: teal">   24</span> <span style="BACKGROUND: white">        Debug.WriteLine(</span><span style="BACKGROUND: white; COLOR: maroon">"Are references equal? "</span><span style="BACKGROUND: white"> & </span><span style="BACKGROUND: white; COLOR: navy">Object</span><span style="BACKGROUND: white">.ReferenceEquals(txtName.DataBindings(</span><span style="BACKGROUND: white; COLOR: maroon">"Text"</span><span style="BACKGROUND: white">).DataSource, _person))</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   25</span> <span style="BACKGROUND: white">        _person = newPerson</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   26</span> <span style="BACKGROUND: white">        Debug.WriteLine(</span><span style="BACKGROUND: white; COLOR: maroon">"Are references equal? "</span><span style="BACKGROUND: white"> & </span><span style="BACKGROUND: white; COLOR: navy">Object</span><span style="BACKGROUND: white">.ReferenceEquals(txtName.DataBindings(</span><span style="BACKGROUND: white; COLOR: maroon">"Text"</span><span style="BACKGROUND: white">).DataSource, _person))</span>
<p style="MARGIN: 0px"><span style="COLOR: teal">   27</span> <span style="BACKGROUND: white">    </span><span style="BACKGROUND: white; COLOR: navy">End</span><span style="BACKGROUND: white"> </span><span style="BACKGROUND: white; COLOR: navy">Sub</span>
</div>
<!--EndFragment-->

Whoa! The first Debug.Writeline will give you TRUE, but the second will give you FALSE. You see, understanding how references and pointers work is important. The textbox's DataSource is holding onto a reference of the old Person instance. You now have two different instances in memory, whether you like it or not.

What do you do about it? Well, as far as I can tell, you can either update your DataSource reference (it did change after all) or you can move your properties over manually so that your references don't change. I'm open to suggestions on other methods here.

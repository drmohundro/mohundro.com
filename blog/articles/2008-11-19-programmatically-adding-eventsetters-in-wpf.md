
title: "Programmatically adding EventSetters in WPF"
author: David
date: 2008/11/19
categories: .net;programming;wpf
guid: 514f3f7a-3fec-4e2c-9897-d292eef6f4c8

I've been doing some WPF work lately. WPF is ridiculously powerful and provides a *lot* more than WinForms. On the other hand - wow, the learning curve is quite steep. I think I'm improving, though.

So, the scenario. I wanted to be able to let a user click on an item in a ListBox and drag across, selecting multiple items in the process. Basically, I want to emulate the behavior that the Outlook calendar provides. 
I ended up coding up the following XAML to get the behavior:

    <ListBox
      x:Name="myListBox"
      SelectionMode="Multiple"
      ItemsSource="{Binding Path=SomeIEnumerableOnMyDataContext}"
      >
      <ListBox.Resources>
        <Style
          TargetType="{x:Type ListBoxItem}"
          >
          <EventSetter
            Event="PreviewMouseLeftButtonDown"
            Handler="ListBoxItem_PreviewMouseLeftButtonDown" />
          <EventSetter
            Event="PreviewMouseUp"
            Handler="ListBoxItem_PreviewMouseUp" />
          <EventSetter
            Event="PreviewMouseMove"
            Handler="ListBoxItem_PreviewMouseMove" />
          <EventSetter
            Event="PreviewMouseRightButtonDown"
            Handler="ListBoxItem_PreviewMouseRightButtonDown" /> 
        </Style>
    </ListBox>

The problem with this code is that Blend (currently v2 SP1) doesn't like EventSetters. 

![Expression Blend Error](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/ProgrammaticallyaddingEventSettersinWPF_A8F8/image_4.png) 

I wanted to keep the events hooked up so that, while testing, I could keep the behavior but, at the same time, I want to be able to at least try to design in blend. So I took to implementing the above XAML in code. 

Sacha Barber has a [good article on converting from XAML to code and back](http://www.codeproject.com/KB/WPF/codeVsXAML.aspx) that helped a lot but it didn't get me quite there.

Here is how to programmatically create one of the EventSetters in code:

    var style = new Style(typeof (ListBoxItem)); 

    style.Setters.Add(
        new EventSetter(PreviewMouseLeftButtonDownEvent,
                        new MouseButtonEventHandler(OnPreviewMouseLeftButtonDown)));

It's pretty straightforward, but actually hooking this style into my ListBox was what got me confused next. 

Setting the ListBox's style to my style instance didn't work and then I got stuck on how to plug my style into the ListBox's ResourceDictionary (via the Resources property). The XAML doesn't specify a Key anywhere, but the Resources's Add method requires a key. I tried creating my own key and also specifying a null key, but I still didn't get the behavior I wanted. 

StackOverflow's goal of being the place for one-off questions like this is starting to work because I stumbled across [my answer](http://stackoverflow.com/questions/141007/creating-a-xaml-resource-from-code-without-a-key) via Google. I didn't realize that, in the above XAML, when the Style specifies its TargetType, the type is implicitly the Key in the ResourceDictionary. 

So the solution is this: 

    Resources.Add(typeof (ListBoxItem), style);

Easy enough.


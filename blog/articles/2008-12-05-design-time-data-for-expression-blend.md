
title: "Design-Time Data for Expression Blend"
author: david
date: 2008/12/05
categories: .net;wpf
guid: a64aa0e1-21f5-4639-9107-9138aeb742a2

This post presents a problem that has been approached by others before, but I thought I'd offer yet another possible solution. But first, let's introduce the problem! 

In my experience, real world applications (aka NOT demos) don't display data that was hard-coded in an application. For my part, the data is usually coming from some remote service or endpoint, so I'm either working with some proxy to a WCF, ASMX, or remoting endpoint. It seems that most WPF demos that showcase data-binding imagine a scenario where the data is readily available to the designer which allows them, at design-time, to see what the application might look like with real data loaded. 

Check out the below screenshot of an amazing application that I created this morning. 

![Amazing WPF app](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/DesignTimeDataforExpressionBlend_73DD/image_2.png)

As you can tell, I'm displaying a list of accounts by name and balance. The UI on this thing is unbelievable, too, because it also makes the balance *red* when their balance is below zero. Go WPF! 

Seriously, though, I've tried to structure this like I might a real application. I'm a huge fan of the [CompositeWPF library](http://codeplex.com/CompositeWPF) (*cough* Prism *cough*), so I'm using a Model-View-Presenter approach here, where the View is binding to a PresentationModel. You can see some examples of this in the StockTrader reference application that ships with CompositeWPF. The presenter's only job is to hook up the data binding to the view and then load the PresentationModel up with data from the service. (Note that it would be very easy to add threading support here so that, while pulling data from IService, we don't lock up the UI)

    public class Presenter  
    {  
        private readonly IView _view;  
        private readonly IService _service;  
        private readonly PresentationModel _presentationModel;  

        public Presenter(IView view, IService service, PresentationModel presentationModel)
        {
            _view = view;  
            _service = service;  
            _presentationModel = presentationModel;  
        }  

        public void Run()
        {
            _view.Model = _presentationModel;  
            LoadAccounts();  
        }  

        private void LoadAccounts()
        {
            foreach (var acct in _service.GetAccounts())  
                _presentationModel.Accounts.Add(acct);  
        }  
    }

The PresentationModel only exposes an ObservableCollection of Accounts.

    public class PresentationModel  
    {  
        private readonly ObservableCollection&lt;Account&gt; _accounts = new ObservableCollection&lt;Account&gt;();  
        public ObservableCollection&lt;Account&gt; Accounts  
        {  
            get  
            {  
                return _accounts;  
            }  
        }  
    }

The code for Window1.xaml is below.

    <Window  
      x:Class="WpfApplication1.Window1"  
      xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"  
      xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"  
      xmlns:local="clr-namespace:WpfApplication1"  
      Title="Window1"  
      Height="300"  
      Width="300">

      <local:AccountDisplay  
        DataContext="{Binding}" />
    </Window>

I'm just tying the DataContext for my AccountDisplay UserControl to whatever Binding is set to the Window. This allows the data binding to just flow through the rest of the application. This is very flexible. But what about the code behind? It is pretty basic, too.

    public partial class Window1 : Window, IView  
    {  
        public Window1()  
        {  
            InitializeComponent();

            var presenter = new Presenter(this, new RealService(), new PresentationModel());
            presenter.Run();
        }  

        #region IView Members

        public object Model
        {  
            get { return DataContext; }  
            set { DataContext = value; }  
        }  

        #endregion  
    }

The sample isn't using CompositeWPF, but if you're familiar with it, you should realize that it would be very easy to plug it in. In fact, my example is screaming Inversion of Control because of the Dependency Injection that I'm already using with the Presenter. A conversion to using the CompositeWPF would start with replacing the local declaration of the AccountDisplay user control with a region and associated module and you'll be well on your way.

The real display is in AccountDisplay. Here is its source:

    <UserControl  
      x:Class="WpfApplication1.AccountDisplay"  
      xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"  
      xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"  
      xmlns:local="clr-namespace:WpfApplication1"  
      Height="300"  
      Width="300">  

      <UserControl.Resources>  
        <local:BalanceToBrushConverter  
          x:Key="BalanceToBrushConverter" />  
      </UserControl.Resources>  

      <ItemsControl  
        ItemsSource="{Binding Path=Accounts}">  

        <ItemsControl.ItemTemplate>  
          <DataTemplate>  

            <StackPanel  
              Orientation="Horizontal">  
              <Border  
                CornerRadius="5"  
                Padding="5"  
                BorderBrush="Black"  
                BorderThickness="2">  
                <TextBlock  
                  Text="{Binding Path=Name}" />  
              </Border>  
              <Border  
                CornerRadius="5"  
                Padding="5"  
                BorderBrush="Black"  
                BorderThickness="2">  
                <TextBlock  
                  Foreground="{Binding Path=Balance, Converter={StaticResource BalanceToBrushConverter}}"  
                  Text="{Binding Path=Balance}" />  
              </Border>  
            </StackPanel>  
          </DataTemplate>  
        </ItemsControl.ItemTemplate>  

      </ItemsControl>  
    </UserControl>

Here, I'm just using relative binding (Binding Path=Property) here. This means I'll pick up data binding from the DataContext, which was set back in Window1.xaml (once again, a result of that flowing data binding).

So, where's the problem? Let's look at this from the designer perspective by opening AccountDisplay.xaml in Blend.

![Pretty blank Designer in Blend](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/DesignTimeDataforExpressionBlend_73DD/image_4.png) 

It... it looks really great. So... white and everything. Anyone know what the problem is? My Presenter is the guy who does the work to return accounts to bind to, but Blend is just showing us the XAML. This is good - we don't want the fact that we're designing this to actually run our code and hit our services. But... we still want some test data to design with, right? We could add some data to our XAML file... but then that affects us when we actually *run* the application. Besides, I personally want test data to match the structure of the model I'm binding to.

Here's what I'm doing to fix this right now. I added the following 3 lines of code to AccountDisplay.xaml.

    <local:Designer.DataContext>  
      <local:BlendPresentationModel />
    </local:Designer.DataContext>

That doesn't tell you much, so I'll show you the Designer class that is being referenced now.

    /// <summary>
    /// Allows the use of design-time only data binding... seems to only work  
    /// in Blend and not the VS designer...  
    /// </summary>
    public static class Designer  
    {  
        public static readonly DependencyProperty DataContextProperty =  
            DependencyProperty.RegisterAttached("DataContext", typeof (object), typeof (Designer),  
                                                new PropertyMetadata(OnDataContextChanged));  

        private static void OnDataContextChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)  
        {  
            SetDataContext(d, e.NewValue);  
        }  

        public static void SetDataContext(DependencyObject d, object value)  
        {  
            var element = d as FrameworkElement;  
            if (element == null) return;  

            if (DesignerProperties.GetIsInDesignMode(element))  
                element.DataContext = value;  
        }

        public static object GetDataContext(DependencyObject d)
        {
            var element = d as FrameworkElement;
            if (element == null) return null;

            if (!DesignerProperties.GetIsInDesignMode(element))
                return null;

            return element.DataContext;
        }  
    }

A few of things to note. I have a Dependency Property called DataContext first. I'm using a Dependency Property so that WPF data binding works. It can take any object (hence the typeof(object) parameter. When it changes, I call off to SetDataContext with the new value. Next important thing to note - DesignerProperties.GetIsInDesignMode. I try to cast the owner of my Designer instance (which is typically going to be a UserControl or Window or other UI element) to a FrameworkElement. I'm using FrameworkElement because it is the highest object in the hierarchy that provides the DataContext property. Then, if we're in Design mode, I override the DataContext with my Designer DataContext.

In the XAML, what ends up getting set is a BlendPresentationModel, which looks like this:

    public class BlendPresentationModel : PresentationModel  
    {  
        public BlendPresentationModel()  
        {  
            var accounts = new List<Account>
                               {  
                                   new Account  
                                       {  
                                           Name = "Bob's Stuff",  
                                           Balance = 1000000  
                                       },  
                                   new Account  
                                       {  
                                           Name = "Cheap Skate",  
                                           Balance = -100  
                                       }  
                               };  
            foreach (var acct in accounts)  
                Accounts.Add(acct);  
        }  
    }

With my approach, I've created an object that inherits from my PresentationModel, so the object I'm binding my UI to is the same type that I'm using when running, but I'm providing test data instead. This is what it looks like in Blend now:

![Expression Blend showing my PresentationModel](http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/DesignTimeDataforExpressionBlend_73DD/image_6.png) 

In one of my projects, I've been dropping these guys around in various UserControls and even one at the top level Window so that I can see what it all looks like together. So far, it is working well. 

The biggest problem I've got with this solution so far is that the Visual Studio designer doesn't render the test data. I would guess that this would be fixed at some point - honestly, the rendering of XAML should be the same between Blend and Visual Studio and, if it isn't, it should be fixed.

[Karl Shifflett posts a solution to this](http://karlshifflett.wordpress.com/2008/10/11/viewing-design-time-data-in-visual-studio-2008-cider-designer-in-wpf-and-silverlight-projects/) as well - my solution is basically just my own take on what he's already done, so thanks to him for the initial idea. I wasn't using Resources for binding, which is the primary reason I started with my own solution.

Also, [Laurent Bugnion has a great article](http://www.galasoft.ch/mydotnet/articles/article-2007091401.html) on various methods to accomplish this as well. I particularly like the feature he shares where Blend can create sample data. I'm very hopeful that this functionality is improved and expanded in future versions of Blend.

I hope this post helps out! Also, if I'm doing something that doesn't make sense or if there is a better way to do something, please let me know.

**UPDATE:** Thanks to [Brian Genisio](http://houseofbilz.com/) for the suggestion to add the GetDataContext method to my Designer class.


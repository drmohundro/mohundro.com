
title: "Design-Time Data for Expression Blend"
author: david
date: 2008/12/04

<p>This post presents a problem that has been approached by others before, but I thought I’d offer yet another possible solution. But first, let’s introduce the problem!</p> <p>In my experience, real world applications (aka NOT demos) don’t display data that was hard-coded in an application. For my part, the data is usually coming from some remote service or endpoint, so I’m either working with some proxy to a WCF, ASMX, or remoting endpoint. It seems that most WPF demos that showcase data-binding imagine a scenario where the data is readily available to the designer which allows them, at design-time, to see what the application might look like with real data loaded.</p> <p>Check out the below screenshot of an amazing application that I created this morning.</p> <p><a href="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/DesignTimeDataforExpressionBlend_73DD/image_2.png"><img style="border-width: 0px; display: inline;" title="image" alt="image" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/DesignTimeDataforExpressionBlend_73DD/image_thumb.png" width="244" border="0" height="244"></a> </p> <p>As you can tell, I’m displaying a list of accounts by name and balance. The UI on this thing is unbelievable, too, because it also makes the balance <em>red</em> when their balance is below zero. Go WPF!</p> <p>Seriously, though, I’ve tried to structure this like I might a real application. I’m a huge fan of the <a href="http://codeplex.com/CompositeWPF">CompositeWPF library</a> (*cough* Prism *cough*), so I’m using a Model-View-Presenter approach here, where the View is binding to a PresentationModel. You can see some examples of this in the StockTrader reference application that ships with CompositeWPF. The presenter’s only job is to hook up the data binding to the view and then load the PresentationModel up with data from the service. (Note that it would be very easy to add threading support here so that, while pulling data from IService, we don’t lock up the UI)</p><pre class="brush: csharp;">public class Presenter  
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
</pre>
<p>The PresentationModel only exposes an ObservableCollection of Accounts.</p><pre class="brush: csharp;">public class PresentationModel  
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
</pre>
<p>The code for Window1.xaml is below.</p><pre class="brush: xml;">&lt;Window  
  x:Class="WpfApplication1.Window1"  
  xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"  
  xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"  
  xmlns:local="clr-namespace:WpfApplication1"  
  Title="Window1"  
  Height="300"  
  Width="300"&gt;  
    
  &lt;local:AccountDisplay  
    DataContext="{Binding}" /&gt;  
&lt;/Window&gt;
</pre>
<p>I’m just tying the DataContext for my AccountDisplay UserControl to whatever Binding is set to the Window. This allows the data binding to just flow through the rest of the application. This is very flexible. But what about the code behind? It is pretty basic, too.</p><pre class="brush: csharp;">public partial class Window1 : Window, IView  
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
</pre>
<p>The sample isn’t using CompositeWPF, but if you’re familiar with it, you should realize that it would be very easy to plug it in. In fact, my example is screaming Inversion of Control because of the Dependency Injection that I’m already using with the Presenter. A conversion to using the CompositeWPF would start with replacing the local declaration of the AccountDisplay user control with a region and associated module and you’ll be well on your way.</p>
<p>The real display is in AccountDisplay. Here is its source:</p><pre class="brush: xml;">&lt;UserControl  
  x:Class="WpfApplication1.AccountDisplay"  
  xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"  
  xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"  
  xmlns:local="clr-namespace:WpfApplication1"  
  Height="300"  
  Width="300"&gt;  
    
  &lt;UserControl.Resources&gt;  
    &lt;local:BalanceToBrushConverter  
      x:Key="BalanceToBrushConverter" /&gt;  
  &lt;/UserControl.Resources&gt;  
  
  &lt;ItemsControl  
    ItemsSource="{Binding Path=Accounts}"&gt;  
  
    &lt;ItemsControl.ItemTemplate&gt;  
      &lt;DataTemplate&gt;  
  
        &lt;StackPanel  
          Orientation="Horizontal"&gt;  
          &lt;Border  
            CornerRadius="5"  
            Padding="5"  
            BorderBrush="Black"  
            BorderThickness="2"&gt;  
            &lt;TextBlock  
              Text="{Binding Path=Name}" /&gt;  
          &lt;/Border&gt;  
          &lt;Border  
            CornerRadius="5"  
            Padding="5"  
            BorderBrush="Black"  
            BorderThickness="2"&gt;  
            &lt;TextBlock  
              Foreground="{Binding Path=Balance, Converter={StaticResource BalanceToBrushConverter}}"  
              Text="{Binding Path=Balance}" /&gt;  
          &lt;/Border&gt;  
        &lt;/StackPanel&gt;  
      &lt;/DataTemplate&gt;  
    &lt;/ItemsControl.ItemTemplate&gt;  
  
  &lt;/ItemsControl&gt;  
&lt;/UserControl&gt;
</pre>
<p>Here, I’m just using relative binding (Binding Path=Property) here. This means I’ll pick up data binding from the DataContext, which was set back in Window1.xaml (once again, a result of that flowing data binding).</p>
<p>So, where’s the problem? Let’s look at this from the designer perspective by opening AccountDisplay.xaml in Blend.</p>
<p><a href="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/DesignTimeDataforExpressionBlend_73DD/image_4.png"><img style="border-width: 0px; display: inline;" title="image" alt="image" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/DesignTimeDataforExpressionBlend_73DD/image_thumb_1.png" width="221" border="0" height="244"></a> </p>
<p>It… it looks really great. So… white and everything. Anyone know what the problem is? My Presenter is the guy who does the work to return accounts to bind to, but Blend is just showing us the XAML. This is good – we don’t want the fact that we’re designing this to actually run our code and hit our services. But… we still want some test data to design with, right? We could add some data to our XAML file… but then that affects us when we actually <em>run</em> the application. Besides, I personally want test data to match the structure of the model I’m binding to.</p>
<p>Here’s what I’m doing to fix this right now. I added the following 3 lines of code to AccountDisplay.xaml.</p><pre class="brush: xml;">&lt;local:Designer.DataContext&gt;  
  &lt;local:BlendPresentationModel /&gt;  
&lt;/local:Designer.DataContext&gt;
</pre>
<p>That doesn’t tell you much, so I’ll show you the Designer class that is being referenced now.</p><pre class="brush: csharp;">/// &lt;summary&gt;  
/// Allows the use of design-time only data binding... seems to only work  
/// in Blend and not the VS designer...  
/// &lt;/summary&gt;  
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
</pre>
<p>A few of things to note. I have a Dependency Property called DataContext first. I’m using a Dependency Property so that WPF data binding works. It can take any object (hence the typeof(object) parameter. When it changes, I call off to SetDataContext with the new value. Next important thing to note – DesignerProperties.GetIsInDesignMode. I try to cast the owner of my Designer instance (which is typically going to be a UserControl or Window or other UI element) to a FrameworkElement. I’m using FrameworkElement because it is the highest object in the hierarchy that provides the DataContext property. Then, if we’re in Design mode, I override the DataContext with my Designer DataContext.</p>
<p>In the XAML, what ends up getting set is a BlendPresentationModel, which looks like this:</p><pre class="brush: csharp;">public class BlendPresentationModel : PresentationModel  
{  
    public BlendPresentationModel()  
    {  
        var accounts = new List&lt;Account&gt;  
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
</pre>
<p>With my approach, I’ve created an object that inherits from my PresentationModel, so the object I’m binding my UI to is the same type that I’m using when running, but I’m providing test data instead. This is what it looks like in Blend now:</p>
<p><a href="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/DesignTimeDataforExpressionBlend_73DD/image_6.png"><img style="border-width: 0px; display: inline;" title="image" alt="image" src="http://www.mohundro.com/blog/content/binary/WindowsLiveWriter/DesignTimeDataforExpressionBlend_73DD/image_thumb_2.png" width="218" border="0" height="244"></a> </p>
<p>In one of my projects, I’ve been dropping these guys around in various UserControls and even one at the top level Window so that I can see what it all looks like together. So far, it is working well. </p>
<p>The biggest problem I’ve got with this solution so far is that the Visual Studio designer doesn’t render the test data. I would guess that this would be fixed at some point – honestly, the rendering of XAML should be the same between Blend and Visual Studio and, if it isn’t, it should be fixed.</p>
<p></p>
<p><a href="http://karlshifflett.wordpress.com/2008/10/11/viewing-design-time-data-in-visual-studio-2008-cider-designer-in-wpf-and-silverlight-projects/">Karl Shifflett posts a solution to this</a> as well – my solution is basically just my own take on what he’s already done, so thanks to him for the initial idea. I wasn’t using Resources for binding, which is the primary reason I started with my own solution.</p>
<p>Also, <a href="http://www.galasoft.ch/mydotnet/articles/article-2007091401.html">Laurent Bugnion has a great article</a> on various methods to accomplish this as well. I particularly like the feature he shares where Blend can create sample data. I’m very hopeful that this functionality is improved and expanded in future versions of Blend.</p>
<p>I hope this post helps out! Also, if I’m doing something that doesn’t make sense or if there is a better way to do something, please let me know.</p><p><b>UPDATE:</b><br>Thanks to <a href="http://houseofbilz.com/">Brian Genisio</a> for the suggestion to add the GetDataContext method to my Designer class.<br></p>
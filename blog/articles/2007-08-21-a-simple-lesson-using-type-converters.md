
title: "A simple lesson using type converters"
author: David
date: 2007/08/21
categories: .net;programming

I found myself writing the following code this evening:

    public T GetItem<T>(string name)
    {
      string result = node.SelectSingleNode(name).InnerText.Trim();

      return (T)GetConverter(typeof(T)).ConvertFromString(result);
    }

    private TypeConverter GetConverter(Type objectType)
    {
      if (objectType.Equals(typeof(int)))
        return new Int32Converter();
      else if (objectType.Equals(typeof(bool)))
        return new BooleanConverter();
      else if (objectType.Equals(typeof(string)))
        return new StringConverter();
      else
        throw new ArgumentException("Does not support casting to " + objectType.Name);
    }

Don't ever write code like this. [Read the documentation](http://msdn2.microsoft.com/en-us/library/system.componentmodel.booleanconverter.aspx) which explicitly says that "you should never create an instance of a BooleanConverter". If you follow their advice, your code will become much cleaner. Like so:

    public T GetItem<T>(string name)
    {
      string result = node.SelectSingleNode(name).InnerText.Trim();
      return (T)TypeDescriptor.GetConverter(typeof(T)).ConvertFromString(result);
    }


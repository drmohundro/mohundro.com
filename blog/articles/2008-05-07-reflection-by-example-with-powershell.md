
title: "Reflection by example with Powershell"
author: David
date: 2008/05/07
categories: .net;powershell

A coworker swung by a few days ago to ask some questions about using Reflection. I learn really well by example so I decided to use Powershell to show using Reflection. Below is the session I used and later emailed to him. You can see a few spots at the bottom of the example where I was unsure of the syntax on passing an empty parameter array, but I figured it out.

This is a good example of why I like Powershell :-) 

    1 [1] » “haha”.gettype()
    2 
    3 IsPublic IsSerial Name BaseType
    4 ———— ———— —— ————
    5 True True String System.Object
    6 
    7 
    8 [2] » $temp = “haha”.gettype()
    9 [3] » $temp.GetProperties()
    10 
    11 
    12 MemberType : Property
    13 Name : Chars
    14 DeclaringType : System.String
    15 ReflectedType : System.String
    16 MetadataToken : 385875994
    17 Module : CommonLanguageRuntimeLibrary
    18 PropertyType : System.Char
    19 Attributes : None
    20 CanRead : True
    21 CanWrite : False
    22 IsSpecialName : False
    23 
    24 MemberType : Property
    25 Name : Length
    26 DeclaringType : System.String
    27 ReflectedType : System.String
    28 MetadataToken : 385875995
    29 Module : CommonLanguageRuntimeLibrary
    30 PropertyType : System.Int32
    31 Attributes : None
    32 CanRead : True
    33 CanWrite : False
    34 IsSpecialName : False
    35 
    36 
    37 
    38 [4] » $temp.GetProperties()[0]
    39 
    40 
    41 MemberType : Property
    42 Name : Chars
    43 DeclaringType : System.String
    44 ReflectedType : System.String
    45 MetadataToken : 385875994
    46 Module : CommonLanguageRuntimeLibrary
    47 PropertyType : System.Char
    48 Attributes : None
    49 CanRead : True
    50 CanWrite : False
    51 IsSpecialName : False
    52 
    53 
    54 
    55 [5] » $temp.GetProperties()[0].name
    56 Chars
    57 [6] » $temp.GetProperties()[1].name
    58 Length
    59 [7] » $temp.GetProperties()[1].GetGetMethod()
    60 
    61 
    62 Name : get_Length
    63 DeclaringType : System.String
    64 ReflectedType : System.String
    65 MemberType : Method
    66 MetadataToken : 100663629
    67 Module : CommonLanguageRuntimeLibrary
    68 MethodHandle : System.RuntimeMethodHandle
    69 Attributes : PrivateScope, Public, HideBySig, SpecialName
    70 CallingConvention : Standard, HasThis
    71 ReturnType : System.Int32
    72 ReturnTypeCustomAttributes : Int32
    73 ReturnParameter : Int32
    74 IsGenericMethod : False
    75 IsGenericMethodDefinition : False
    76 ContainsGenericParameters : False
    77 IsPublic : True
    78 IsPrivate : False
    79 IsFamily : False
    80 IsAssembly : False
    81 IsFamilyAndAssembly : False
    82 IsFamilyOrAssembly : False
    83 IsStatic : False
    84 IsFinal : False
    85 IsVirtual : False
    86 IsHideBySig : True
    87 IsAbstract : False
    88 IsSpecialName : True
    89 IsConstructor : False
    90 
    91 
    92 
    93 [8] » $temp.GetProperties()[1].GetGetMethod().Invoke
    94 
    95 
    96 MemberType : Method
    97 OverloadDefinitions : {System.Object Invoke(Object obj, BindingFlags invokeAttr, Binder binder, Object[] parameters, CultureInfo cu
    98 lture), System.Object Invoke(Object obj, Object[] parameters)}
    99 TypeNameOfValue : System.Management.Automation.PSMethod
    100 Value : System.Object Invoke(Object obj, BindingFlags invokeAttr, Binder binder, Object[] parameters, CultureInfo cul
    101 ture), System.Object Invoke(Object obj, Object[] parameters)
    102 Name : Invoke
    103 IsInstance : True
    104 
    105 
    106 
    107 [9] » $temp.GetProperties()[1].GetGetMethod().Invoke(“hello world”, [])
    108 Unable to find type []: make sure that the assembly containing this type is loaded.
    109 At line:1 char:65
    110 + $temp.GetProperties()[1].GetGetMethod().Invoke(“hello world”, []) <<<<
    111 [10] » $temp.GetProperties()[1].GetGetMethod().Invoke(“hello world”)
    112 Cannot find an overload for “Invoke” and the argument count: “1”.
    113 At line:1 char:47
    114 + $temp.GetProperties()[1].GetGetMethod().Invoke( <<<< “hello world”)
    115 [11] » $temp.GetProperties()[1].GetGetMethod().Invoke(“hello world”, {})
    116 Exception calling “Invoke” with “2” argument(s): “Parameter count mismatch.”
    117 At line:1 char:47
    118 + $temp.GetProperties()[1].GetGetMethod().Invoke( <<<< “hello world”, {})
    119 [12] » $temp.GetProperties()[1].GetGetMethod().Invoke(“hello world”, $Null)
    120 11
    121 [13] »
    122


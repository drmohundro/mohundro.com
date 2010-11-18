
title: "The FileHelpers library ROCKS!"
author: David
date: 2006/01/05
categories: .net
guid: 78c670c2-8cd1-4430-8d40-c559fa315149

My post earlier today referred to the [FileHelpers](http://filehelpers.sourceforge.net/) library by Marcos Meli.

Wow, do I wish I had known about this earlier. This thing is great! With a few easy attributes, you can use a business object as a layout for fixed-length files! Okay, I guess an example would help. Here's some VB code I whipped up to test this library out.

    Imports FileHelpers

    Public Class MainForm
      Private Sub MainForm_Load(ByVal sender As Object, _
        ByVal e As System.EventArgs) Handles Me.Load 

        Dim engine As New FileHelperEngine(GetType(Record)) 

        Dim records() As Record = _
          DirectCast(engine.ReadString("123456789 2005-01-01"), _
          Record()) 

        Debugger.Break() 

        Dim res As String = engine.WriteString(records) 

        Debugger.Break()
      End Sub
    End Class

    <FixedLengthRecord()> _
    Public Class Record 
      <FieldFixedLength(11)> _
      Public BillNumber As String 

      <FieldFixedLength(10), _
      FieldConverter(ConverterKind.Date, "yyyy-MM-dd")> _
      Public BillDate As DateTime
    End Class

At each Debugger.Break line, I checked my values and this thing is great. records(0).BillNumber is "123456789  " and records(0).BillDate is a converted DateTime set to 1/1/2005.

If you deal with fixed-length or delimited files on a regular basis, this library might be a great option for you.

Thanks Marcos!

UPDATE: Version 1.3.1 was released recently, so I have updated my example code to use the new ReadString and WriteString methods.


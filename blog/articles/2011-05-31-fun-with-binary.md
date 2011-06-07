--- 
title: Fun with binary!
date: 2011/05/31

I know what you're thinking... "did he just say 'binary data'? Like, 1's and
0's?" Well, yes, yes I did.  If you're like me, the last time you actively had
to do anything with straight binary data was in college when you were learning
how to convert between binary to hex to decimal and back again. I would imaging
that most of us run into hex somewhat frequently, but that we don't actually
have to deal with binary data as often.

## Some Background

As one of my recent projects, I had to write an API that interfaced with some
hardware, which was something relatively new to me. Most of my work in the
past has been either standard client-side GUI applications or web
applications. I have yet to have written any applications to talk over a
serial port. Even with this new project, I didn't have to talk over ports
because the hardware did have a relatively nice .NET SDK for it. The primary
flaw with the SDK was that it still had quite a few methods that only returned
byte arrays. The documentation for those byte arrays was specified in a table
of bits... in other words, if the second bit in the fourth byte is on, then one
feature is accessible... you get the idea. In many cases, I had to parse out
these bits to determine what the hardware was actually returning me.

I can't show you any of the code that I used in this project, but I can
provide a similar example. You know TCP, right? One of the network protocols
that we use every day without even thinking? Here's an image from Wikipedia
that shows the structure for the TCP header (via
[Wikipedia](http://en.wikipedia.org/wiki/Transmission_Control_Protocol)):

![TCP Header](https://s3.amazonaws.com/mohundro/blog/2011-05-31-tcp-header.png)

For fun, let's assume that that we've been provided the below data and we'd
like to parse this into a structure that looks more like the table the TCP
spec has.

First, in hex:

    0000   de 39 00 50 d5 99 75 e4 02 50 89 dc 50 18 01 01  .9.P..u..P..P...
    0010   cc 87 00 00                                      ....

Then, in binary:

    0000   11011110 00111001 00000000 01010000 11010101 10011001 01110101 11100100   .9.P..u.
    0008   00000010 01010000 10001001 11011100 01010000 00011000 00000001 00000001   .P..P...
    0010   11001100 10000111 00000000 00000000                                       ....

(for those who are curious, I got this data from Wireshark)

Of course, I wasn't provided my bytes in such a pretty format... byte arrays
are going to look a lot more like this:

    0xde, 0x39, 0x00, 0x50, 0xd5, 0x99, 0x75, 0xe4, 0x02, 0x50, 0x89, 0xdc, 
    0x50, 0x18, 0x01, 0x01, 0xcc, 0x87, 0x00, 0x00

## The Naive (and horribly non-performant) Way

My first step was to see the structure of what I was getting passed. I'm not
like those guys in movies - I don't dream in binary and I sure don't see
structure in ones and zeros. So, I wanted to get the data into a tabular
format. To do so, my first stop was Powershell.

Given the above byte array, all it took was the below snippet of Powershell
(note that I used the 0x prefix with the hex values... there isn't any binary
literal notation):

    $bytes = [byte[]](0xde, 0x39, 0x00, 0x50, 0xd5, 0x99, 0x75, 0xe4, 0x02,
                      0x50, 0x89, 0xdc, 0x50, 0x18, 0x01, 0x01, 0xcc, 0x87, 
                      0x00, 0x00)

Now that we've got a byte array, we can start to play around with it. I
created the following script that I named Get-ByteTable.ps1:

    param (
      [Parameter(ValueFromPipeline=$true)]
      [byte]
      $bytes,

      [int]
      $rowLength = 8
    )

    begin {
      $offset = 0
      $bitIndex = 0
      $byteTable = ''

      Set-Variable -name LENGTH_OF_BYTE_IN_BINARY -value 8 -option constant

      function To-Binary {
        param (
          [Parameter(ValueFromPipeline=$true)]
          [int]$num
        )
        [Convert]::ToString($num, 2)
      }

      function outputByteRow {
        if ($byteTable.Length -lt $rowLength) {
          $byteTable = $byteTable.PadLeft($rowLength, '0')
        }

        $hexValue = "0x{0:X$($rowLength / 4)}" -f $([Convert]::ToInt64($byteTable, 2))

        $bitIndex = 0
        $table = New-Object PSObject

        $table |
          Add-Member NoteProperty 'Offset' ($offset - $rowLength) -pass |
          Add-Member NoteProperty 'Hex' $hexValue

        for (; $bitIndex -lt $rowLength; $bitIndex++) {
          $table |
            Add-Member NoteProperty "$bitIndex" $byteTable.Substring($bitIndex, 1)
        }

        $table
      }
    }

    process {
      if ($byteTable.Length -ge $rowLength) {
        outputByteRow
        $byteTable = ''
      }

      $byteTable = $byteTable + ($bytes | To-Binary).PadLeft(8, '0')

      $offset += $LENGTH_OF_BYTE_IN_BINARY
    }

    end {}

Basically, the usage is just `$bytes | Get-ByteTable.ps1`. Now, the issue then
is output formatting... that just dumps the list of PSObjects out and the
default format is `Format-List`. So, let's try, `$bytes | Get-ByteTable.ps1 |
Format-Table -AutoSize -Property *`. The `AutoSize` flag informs Powershell to
use as little space as possible and the `Property *` flag tells Powershell to
output *all* properties as columns... if you don't do this, Powershell will
only output some of the columns. The script also has a parameter if you want
to specify the row length. If you'd rather work with the data, you could pipe
the output to `Export-Csv`.

Check out the below sample output:

    » $bytes | Get-ByteTable.ps1 -rowlength 32 | Format-Table -AutoSize -Property *

    Offset Hex        0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
    ------ ---        - - - - - - - - - - -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
         0 0xDE390050 1 1 0 1 1 1 1 0 0 0 1  1  1  0  0  1  0  0  0  0  0  0  0  0  0  1  0  1  0  0  0  0
        32 0xD59975E4 1 1 0 1 0 1 0 1 1 0 0  1  1  0  0  1  0  1  1  1  0  1  0  1  1  1  1  0  0  1  0  0
        64 0x025089DC 0 0 0 0 0 0 1 0 0 1 0  1  0  0  0  0  1  0  0  0  1  0  0  1  1  1  0  1  1  1  0  0
        96 0x50180101 0 1 0 1 0 0 0 0 0 0 0  1  1  0  0  0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0  1

We can use this table to line up our values with what we saw from the TCP
header protocol. For example, bits 0-15 make up our source port. In the table
above, those bits come out to be 1101111000111001... or 56889 in decimal. This
lines up with what we can see in Wireshark, so our script works as expected.

![Wireshark's TCP view](https://s3.amazonaws.com/mohundro/blog/2011-05-31-wireshark-tcp.png)

## The Better (and more Programmatic) Way

Okay, so that Powershell script was fun. But seriously, it was *not* the right
way to deal with binary data. We took bits (i.e. 0's and 1's) and converted
them to hex... but hex *as a string*. And then we *parsed* it. Not only was it
non-performant, but it was also an explosion of data.

A better way to parse binary data is the
[System.Collections.BitArray](http://msdn.microsoft.com/en-us/library/system.collections.bitarray.aspx)
class. It takes in a byte array and presents that byte array as an array of
booleans... true is to 1 as false is to 0. Pretty easy.

Now, the BitArray class doesn't ship with any means of working with the data
in a tabular format. It isn't a big hurdle, but it was something that I wanted
to be able to do because the specification I was dealing with showed the bits
in a tabular structure, too. Actually treating the one array in a tabular way
is easy (i.e. rowLength * rowIndex + columnIndex = actualIndex) and is best
served via extension methods as shown below:

    // Note that I've set a constant BYTE_LENGTH below, which effectively
    // serves as the row length... it would be easy enough to specify a 
    // different row length via another parameter.
    internal static class Extensions
    {
      private const int BYTE_LENGTH = 8;

      public static IEnumerable<bool> GetRowBits(this BitArray bits, int row)
      {
        var startIndex = BYTE_LENGTH * row;
        var endIndex = startIndex + BYTE_LENGTH;
        for (var i = startIndex; i < endIndex; i++)
        {
          yield return bits[i];
        }
      }

      public static void Set(this BitArray bits, int rowIndex, int columnIndex, bool value)
      {
        var startIndex = BYTE_LENGTH * rowIndex;
        bits.Set(startIndex + columnIndex, value);
      }
    }

Usage then would be:

    // assume bytes is an already populated byte array.
    var bits = new BitArray(bytes);

    // to get the bit at 0,4
    var bit = bits.GetRowBits(0).ElementAt(4);

    // to set the bit at 5,4 ON
    bits.Set(5, 4, true);

I'm not particularly happy with the method names and I haven't come up with a
great way to specify the row length... as it stands now, my extensions are
using the row length of 8 (`BYTE_LENTH`). I would guess the best way to handle
it would be to wrap the BitArray class instead of actually using extension
methods.

## Who Knew Calc Could Do That?!?

The final thing I wanted to share is some calc.exe awesomeness. First, ensure
that you're running calc.exe in "Programmer" mode.

![Calc in Programmer Mode](https://s3.amazonaws.com/mohundro/blog/2011-05-31-calc-programmer-mode.png)

Next, let's start in Dec (decimal) mode and type in 255. Of course, you can
change between decimal, hex, octal or binary and see the resultant numbers.
This didn't surprise me. However, notice the the section beneath the number
display, where it shows the binary for your number.

![Calc binary display](https://s3.amazonaws.com/mohundro/blog/2011-05-31-calc-binary-display.png)

Try clicking one of the bits. It's awesome.

It flips the bit for you! I had no idea calc could do that! One of the things
I really like about some of the "programmer" features of calc is that you can
now visually see what happens when you right or left shift bits (Lsh and Rsh
respectively). Turns out it is a really good tool for visually bit operations.
Not only that, but it is also good at helping explain things like ["Two's
complement"](http://en.wikipedia.org/wiki/Two's_complement).

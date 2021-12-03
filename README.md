
# Alex's Tools

The following are tools and settings that I like to have on all my Linux
systems so I decided to create a debian package since that way I can
install the whole thing at once.

## atype

The `atype` tool is used to type the content of a file in hexadecimal and
in ASCII.

The tool can also be used to transform a binary file in a C/C++ table.

## cleanrc

If you deal with files from MS-Windows or MacOS, you may end up with
files that end with `\r\n` or `\r` characters instead of the `\n` as
expected on Linux.

This tool will force the all end of line characters to the `\n` character.

## hex

The `hex` tool is used to convert integers and characters to numbers in
hexadecimal, octal, decimal and also prints out the number as UTF-8
which is used often now a day.

## poke

The `poke` tool needs a lot of help to really become useful. Especially,
we would need to be able to insert and delete bytes. Right now, you can
only write a byte at the specified offset.

That being said, I have had the need to write a specific value at a
specific offset in order to fix various files. This is useful for such
situation when you want to just write a shell script to poke values.

## concat

I needed to concatenate lines of a text file in a single long line.
I used these script for that purpose. I like to keep them, just in
case. I will add more as I create new scripts. Specifically, I have
some in my ~/bin folder which I need to install on many of my
systems and that would be useful.


-- vim: ts=4 sw=4 et

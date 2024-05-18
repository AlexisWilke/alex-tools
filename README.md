
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

## concat

I needed to concatenate lines of a text file in a single long line.
I used these script for that purpose. I like to keep them, just in
case. I will add more as I create new scripts. Specifically, I have
some in my ~/bin folder which I need to install on many of my
systems and that would be useful.

## extend-gpg-duration

Run this script to extend the GPG agent session duration. The tool checks
the gpg-agent.conf file of all users and changes the TTLs to a much longer
period than the default.

At this time, the duration cannot be specified on the command line. But at
least the script gives you all the necessary information on how to do such
edits.

## hex

The `hex` tool is used to convert integers and characters to numbers in
hexadecimal, octal, decimal and also prints out the number as UTF-8
which is used often now a day.

The latest version also include better support for floating point
numbers.

## less filters

I learned that you could add your own filters for the less command. This
is how it displays certain things about certain files which by default
you would probably not expect. For example, it can transform an .ELF
file into the output of objdump instead of showing us binary data.
This is the extension I propose here.

I also have a firewall extension, but that one is turned off at the moment.
It's not logical in this scheme.

## poke

The `poke` tool needs a lot of help to really become useful. Especially,
we would need to be able to insert and delete bytes. Right now, you can
only write a byte at the specified offset.

That being said, I have had the need to write a specific value at a
specific offset in order to fix various files. This is useful for such
situations when you want to just write a shell script to poke values.

## promote-vim-editor

This script automatically makes vim the default editor in your shell.

## restart-pulseaudio

On each reboot on Ubuntu 22.04, my pulseaudio system is down. This may be
because it is not supposed to be the code being used (I upgraded my
computer from 20.04 instead of installing fresh and this may be why this
fails).

The script restarts the pulseaudio system and then I have sound as expected.

## restart-system-monitor-extension

Once in a while (rarely, though), the system-monitor extension appearing
in my status bar at the top-right crashes. This script can be used to
restart it.

## sane-tty

This script is used to reset a console. At times, a utility such as
`less` messes up the console and using this function helps in fixing
the normal console functionality.

## VIM Syntax Extensions

At this time, I install those in the skeleton and I have a `.vimrc`
file. However, I am thinking that this is not what one wants in the
end. There are ways to make this work properly, it just needs a little
more work.

1. put the vimrc functionality for syntax detection under a plugin
   (see `/usr/share/vim/addons/plugins/...`)
2. put the syntax files under `/usr/share/vim/addons/syntax/...` with
   a name specific to my plugin (i.e. alex-tools-<name>.vim)
3. verify that the order works as expected, my `cpp.vim` extension, for
   example, must be the one loaded for C++ files since it extends the
   default `cpp.vim`; that works in my `.vimrc` file, it's TBD in a plugin

Some additional info:
https://vi.stackexchange.com/questions/17185

## XCompose

I have some additional key combos I like to have access to. This file defines
those extensions. It gets installed under your home directory as a hidden
file (.XCompose).

**WARNING:** I have not yet found a way to automatically take changes in
account in the current session. At the moment, you have to at least Log Out
and Log back In. You can also reboot.


-- vim: ts=4 sw=4 et

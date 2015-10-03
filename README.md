# lec
Command Line Wrapper for Line Ending Corrector (A utility that makes sure your files have consistent line endings)

# about line-ending-corrector

It converts all those pesky `\r\n` (a.k.a `CRLF`) line endings in Microsoft Windows operating systems into the more commonly used and recognized `\n` (a.k.a `CR`). Though it lets you do the opposite as well ( converting `CR` to `CRLF` )

You should definitely have this in your build process especially if someone in your team works from a non UNIX system.

[View the programmatic API here](https://github.com/iShafayet/line-ending-corrector)

# Installation

For usage from the command line

    [sudo] npm install -g lec

# Usage the command line

To operate on a single file inplace (the file will only be altered if any inconsistent line endings are found)

    lec <filename>


To operate on a single file with a diffrent output file name.

    lec <filename> -o <output-filename>

To operate on all the files in the current dirrectory

    lec -d
    
To operate on all the files in a directory

    lec -d <directory>

To operate on all the files in a directory and all subdirectories recursively

    lec -d -r <directory>
    
To use CRLF instead of LF as the desired End Of Line character

    lec <filename> --eolc CRLF


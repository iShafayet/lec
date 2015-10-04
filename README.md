# lec
Command Line Wrapper for Line Ending Corrector (A utility that makes sure your files have consistent line endings)

# about line-ending-corrector

It converts all those pesky `\r\n` (a.k.a `CRLF`) line endings in Microsoft Windows operating systems into the more commonly used and recognized `\n` (a.k.a `LF`). Though it lets you do the opposite as well ( converting `LF` to `CRLF` ). It supports `\r` (a.k.a `CR`) as well for the sake of completion.

You should definitely have this in your build process especially if someone in your team works from a non UNIX system.

[View the programmatic API here](https://github.com/iShafayet/line-ending-corrector)

# Installation

For usage from the command line

```bash
[sudo] npm install -g lec
```

# Usage from the command line

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

To use `CRLF` instead of `LF` as the desired End Of Line character

    lec <filename> --eolc CRLF

# Full Command Line Help

```
  Usage: lec <filename> [options]

  Options:

    -h, --help                          output usage information
    -V, --version                       output the version number
    -o, --output <filename>             Output File Path
    -r, --recursive                     Run the algorithm recursively
    -f, --force-write                   Forcefully (over)write the destination file
    -d, --directory                     Apply on the contents of a directory
    -c, --eolc <End Of Line Character>  End of Line Character
    -e, --encoding <encoding>           Preferred Encoding
    -v, --verbose                       Output additional information
    -n, --nodot                         Ignore Dot Files

```

# Contributing

We actively check for issues even for the least used repositories (unless explicitly abandoned). All of our opensource repositories are being used in commercial projects by teamO4 or bbsenterprise. So, it is very likely that we will sort out important issues not long after they are posted.

Please create a github issue if you find a bug or have a feature request.

Pull requests are always welcome for any of our public repos.



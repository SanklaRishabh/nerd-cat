# NERD CAT

Nerd Cat is a basic syntax highlighter for Python written in Bash. It works just like the `cat` tool, outputting the contents of a file directly on the terminal, but with added coloring.

## Usage

`nerd-cat [PYTHON-FILE]`

## Installation

1. Clone this repository.
2. Add this directory to the `$PATH` variable.
3. Set an alias: `alias nerd-cat=nerd-cat.sh`

## Features

1. Basic syntax coloring for Python.
2. Added support for multi-line strings, comments and punctuations within expressions.
3. Implementation of a lexer instead of relying on regex for processing.

## Limitations

1. Cannot highlight function names properly.
2. May be buggy, I don't know. You tell me :)

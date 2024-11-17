# NERD CAT

<img src="nerd_cat.jpeg" alt="A nerdy cat" width="300"/>

Nerd Cat is a basic syntax highlighter for Python written in Bash. It works just like the `cat` tool, outputting the contents of a file directly on the terminal, but with added coloring.

https://github.com/user-attachments/assets/4129d8dd-814c-4a7e-bc28-95c301c8823f

## Usage

`nerd-cat [PYTHON-FILE]`

## Installation

1. Clone this repository.
2. Add this directory to the `$PATH` variable.
3. Set an alias: `alias nerd-cat=nerd-cat.sh`

## Features

- Basic syntax coloring for Python.
- Added support for multi-line strings, comments and punctuations within expressions.
- Implementation of a lexer instead of relying on regex for processing.

## Limitations

- Cannot highlight function names properly.
- May be buggy. I don't know, you tell me :)

#!/bin/bash

# Define color scheme.
RED="\033[0;31m"    # Strings.
GREEN="\033[0;32m"  # Comments.
YELLOW="\033[1;33m" # Numbers.
BLUE="\033[0;34m"   # Keywords.
RESET="\033[0m"     # Reset coloring.

# Create a map to store Python keywords.
declare -A KEYWORDS

for keyword in "False" "None" "True" "and" "as" "assert" "async" "await" \
  "break" "class" "continue" "def" "del" "elif" "else" "except" "finally" \
  "for" "from" "global" "if" "import" "in" "is" "lambda" "nonlocal" "not" "or" \
  "pass" "raise" "return" "try" "while" "with" "yield"; do
  KEYWORDS[$keyword]=1
done

# Define a tokenizer function.
tokenize_and_colorize() {
  local input=$1
  local len=${#input}
  local pos=0
  local token=""
  local state="normal"

  while [ $pos -lt $len ]; do
    local char="${input:$pos:1}"

    case $state in
    "normal")
      # Check if character is whitespace.
      if [[ $char =~ [[:space:]] ]]; then
        echo -ne "$char"
      # Check if the character is a comment starter.
      elif [[ $char == "#" ]]; then
        echo -ne "$GREEN$char"

        state="comment"
      # Check if the character is a double quote.
      elif [[ $char == '"' ]]; then
        echo -ne "$RED$char"

        state="string_double"
      # Check if the character is a single quote.
      elif [[ $char == "'" ]]; then
        echo -ne "$RED$char"

        state="string_single"
      # Check if the character is number.
      elif [[ $char =~ [0-9] ]]; then
        echo -ne "$YELLOW$char"

        state="number"
      # Check if the character is alphanumeric.
      elif [[ $char =~ [[:alnum:]_] ]]; then
        token="$char"
        state="identifier"
      # Check if the character is a punctuation.
      elif [[ $char =~ [[:punct:]] ]]; then
        echo -ne "$char"
      fi
      ;;

    "comment")
      echo -ne "$char"

      if [[ $char == $'\n' ]]; then
        echo -ne "$RESET"

        state="normal"
      fi
      ;;

    "string_double")
      echo -ne "$char"

      if [[ $char == '"' && "${input:$pos-1:1}" != "\\" ]]; then
        echo -ne "$RESET"

        state="normal"
      fi
      ;;

    "string_single")
      echo -ne "$char"

      if [[ $char == "'" && "${input:$pos-1:1}" != "\\" ]]; then
        echo -ne "$RESET"

        state="normal"
      fi
      ;;

    "number")
      if [[ $char =~ [0-9] ]]; then
        echo -ne "$char"
      else
        echo -ne "$RESET"

        state="normal"

        continue
      fi
      ;;

    "identifier")
      if [[ $char =~ [[:alnum:]_] ]]; then
        token="$token$char"
      else
        if [[ ${KEYWORDS[$token]} ]]; then
          echo -ne "$BLUE$token$RESET"
        else
          echo -ne "$token"
        fi

        state="normal"

        continue
      fi
      ;;
    esac

    pos=$((pos + 1))
  done

  # Handle any remaining token.
  if [[ $state == "identifier" ]]; then
    if [[ ${KEYWORDS[$token]} ]]; then
      echo -ne "$BLUE$token$RESET"
    else
      echo -ne "$token"
    fi
  fi
}

# Check for valid number of parameters.
if [ $# -ne 1 ]; then
  echo "Usage: nerd-cat [PYTHON-FILE]"
  echo "Example: nerd-cat main.py"
  exit 1
fi

# Check if the file exists and is a valid Python format file.
if [[ ! $1 =~ \.py || ! -f "$1" ]]; then
  echo "Error: Invalid file type."
  exit 2
fi

# Check if the file is readable.
if [ ! -r "$1" ]; then
  echo "Error: File $1 is not readable."
  exit 3
fi

# Get the contents of the file.
content=$(<"$1")

# Add syntax highlighting
tokenize_and_colorize "$content"

# Add newline at the end.
echo
exit 0

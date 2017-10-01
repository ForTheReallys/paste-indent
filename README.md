Paste Indent
============

Plugin for maintainging correct indent when pasting.

Introduction
------------

Paste-indent is a simple plgin that makes indentation simple when pasting with
vim.  Take this block of C code for example with the cursor at '|':

    int main(int argc, char **argv) {
        if (argc == 2) {
        }
        |printf("%s\n", argv[1]);
        return 0;
    }

Input: ddkP

Without paste-indent:

    int main(int argc, char **argv) {
        if (argc > 1) {
            printf("%s\n", argv[1]);
        }
        return 0;
    }

With paste-indent:

    int main (int argc, char **argv) {
        if (argc > 1) {
            printf("%s\n", argv[1]);
        }
        return 0;
    }

This works for any number of lines, can take a range, uses the correct
registers, and even works for nested code.

It's smart too!  When making characterwise pastes (without newlines),
paste-indent knows not to indent unless pasting on an empty line.

Installation
------------

Copy plugin/paste-indent.vim to ~/vim/plugin

If you prefer to use pathogen, just run the following commands:

cd ~/.vim
git clone `https://github.com/ForTheReallys/paste-indent.git` bundle/paste-indent

Options
-------

### The `g:paste_indent_off` option

Do nothing on startup

### The `g:paste_indent_after_char` option

The character to paste after the cursor
Default: 'p'

### The `g:paste_indent_before_char` option

The character to paste before the cursor
Default: 'P'

Commands
--------

### The `:PasteIndentOn` command

Map the the appropriate paste keys to indent after pasting

### The `:PasteIndentOff` command

Turn off indent after pasting

# picoline.vim

![active window](./doc/active.png)
![inactive window](./doc/inactive.png)

picoline is a tiny status line written in vim9script for my personal use, and
serves as a starting point that's easy to extend.

picoline is very small. It has only one command - `PicolineToggle` - which just shows and hides the `statusline` (`:h statusline`).

The most interesting part about it is to show how easy it is to customize the status line.

## Features

- Highlights current mode using colors
- Shows current git branch (requires [vim-fugitive](https://github.com/tpope/vim-fugitive))
- Shows if [vim-gutentags](https://github.com/ludovicchabant/vim-gutentags) is currently running
- Uses default `StatusLine` and `StatusLineNC` highlight groups and exposes custom ones for vim modes
- A cool friend that watches you code `(ᵔ◡ᵔ)`

## Mode Highlighting

picoline automatically highlights the current vim mode (`:h vim-modes`) using different colors. The following highlight groups are defined with my personal defaults:

- `PicolineNRM` - Normal mode
- `PicolineINS` - Insert mode
- `PicolineVIS` - Visual mode
- `PicolineCMD` - Command mode
- `PicolineRPL` - Replace mode
- `PicolineSEL` - Select mode
- `PicolineTRM` - Terminal mode
- `PicolinePRO` - Prompt mode
- `PicolineEXT` - External mode

## Customization

You can override these highlight groups in your colorscheme or vimrc to customize the appearance:

```vim
" Example: Custom colors for insert and visual modes
highlight PicolineINS guifg=#ffffff guibg=#e74c3c ctermbg=red ctermfg=white
highlight PicolineVIS guifg=#2c3e50 guibg=#f1c40f ctermbg=yellow ctermfg=black
```

The highlight groups are automatically set up when vim starts and when you change colorschemes.

## Commands

- `:PicolineToggle` - Toggle the statusline on/off

## That's pretty much it

Like I said, picoline ain't much, but it's everything I need.

See `:help picoline` for more detailed documentation.

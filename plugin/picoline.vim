vim9script

import autoload 'picoline.vim'

def SetupPicolineColors(): void
  var default_bg = synIDattr(hlID('StatusLine'), 'bg', 'gui')
  var default_fg = synIDattr(hlID('StatusLine'), 'fg', 'gui')

  if default_bg == '' | default_bg = '#2e3440' | endif
  if default_fg == '' | default_fg = '#d8dee9' | endif

  var mode_colors = {
    'NRM': {'fg': default_fg, 'bg': default_bg},      # Normal mode
    'INS': {'fg': '#ffffff', 'bg': '#bf616a'},        # Insert mode
    'VIS': {'fg': '#2e3440', 'bg': '#ebcb8b'},        # Visual mode
    'CMD': {'fg': '#2e3440', 'bg': '#d08770'},        # Command mode
    'RPL': {'fg': '#ffffff', 'bg': '#b48ead'},        # Replace mode
    'SEL': {'fg': '#ffffff', 'bg': '#5e81ac'},        # Select mode
    'TRM': {'fg': '#2e3440', 'bg': '#88c0d0'},        # Terminal mode
    'PRO': {'fg': '#2e3440', 'bg': '#a3be8c'},        # Prompt mode
    'EXT': {'fg': default_fg, 'bg': '#4c566a'},       # External mode
  }

  for [mode, colors] in items(mode_colors)
    var group_name = 'Picoline' .. mode
    if hlID(group_name) == 0 || synIDattr(hlID(group_name), 'bg', 'gui') == ''
      execute printf(
        'highlight %s guifg=%s guibg=%s ctermfg=white ctermbg=black',
        group_name,
        colors.fg,
        colors.bg
      )
    endif
  endfor
enddef

augroup Picoline
  autocmd!
  autocmd SigUSR1            *  SetupPicolineColors()
  autocmd ColorScheme        *  SetupPicolineColors()
  autocmd WinEnter,BufEnter  *  setlocal statusline=%!picoline#Build(v:true)
  autocmd WinLeave,BufLeave  *  setlocal statusline=%!picoline#Build(v:false)
augroup END

# Set up colors on initial load
SetupPicolineColors()

command! PicolineToggle picoline.Toggle()

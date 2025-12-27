vim9script

def GetModeInfo(): string
  var current_mode = mode()
  var current_state = exists('*state') ? state() : ''
  # Check mode patterns first
  if current_mode =~# '[Ri]'
    return 'INS'
  elseif current_mode ==# '!'
    return 'EXT'
  elseif current_mode ==# 't'
    return 'TRM'
  elseif current_mode =~# '[Rv]'
    return 'RPL'
  elseif current_mode =~? '[v]'
    return 'VIS'
  elseif current_mode ==? 'c'
    # Distinguish between command-line (:) and search (/?)
    var cmdtype = getcmdtype()
    if cmdtype =~ '[/?]'
      return 'SCH'
    else
      return 'CMD'
    endif
  elseif current_mode =~# '[r]'
    return 'PRO'
  elseif current_mode =~? '[sS]'
    return 'SEL'
  # Check state for operator-pending (only after mode checks)
  elseif current_state =~# '[mo]'
    return 'PEN'
  else
    return 'NRM'
  endif
enddef

export def Build(active: bool): string
  if !active
    return BuildSleeping()
  endif

  var separator = "│"
  var icon = '(ᵔ◡ᵔ)'

  var fugitive = exists('*g:FugitiveHead') == 1
    ? separator .. ' ' .. '%{FugitiveHead()}'
    : ''
  var gutentags = exists('*gutentags#statusline') == 1
    ? separator .. ' ' .. '%{gutentags#statusline()}'
    : ''

  var statusline_hlgroup = '%#StatusLine#'
  var current_ft = empty(&filetype) ? '?' : '%{&filetype}'
  var mode_info = GetModeInfo()

  var statusline_segments = [
    '%#Picoline' .. mode_info .. '#',
    '' .. mode_info .. '',
    statusline_hlgroup,
    separator,
    fnamemodify(getcwd(), ':t'),
    separator,
    '%{expand("%:.")} %m %r %h',
    '%=',
    gutentags,
    fugitive,
    separator,
    current_ft,
    separator,
    icon,
  ]
  return join(statusline_segments)
enddef

export def BuildSleeping(): string
  var separator = " "
  var icon = '(∪｡∪)'

  var statusline_segments = [
    '%#StatusLineNC#',
    separator,
    '%{expand("%:t")}',
    '%=',
    separator,
    icon,
  ]
  return join(statusline_segments)
enddef

export def Toggle(): void
  if &laststatus == 2
    set laststatus=0
  else
    set laststatus=2
  endif
enddef

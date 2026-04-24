if exists('g:autoloaded_picoline')
  finish
endif
let g:autoloaded_picoline = 1

function! s:get_mode_info() abort
  let l:current_mode = mode()
  let l:current_state = exists('*state') ? state() : ''

  if l:current_mode =~# '[Ri]'
    return 'INS'
  elseif l:current_mode ==# '!'
    return 'EXT'
  elseif l:current_mode ==# 't'
    return 'TRM'
  elseif l:current_mode =~# '[Rv]'
    return 'RPL'
  elseif l:current_mode =~? '[v]'
    return 'VIS'
  elseif l:current_mode ==? 'c'
    let l:cmdtype = getcmdtype()
    if l:cmdtype =~# '[/?]'
      return 'SCH'
    else
      return 'CMD'
    endif
  elseif l:current_mode =~# '[r]'
    return 'PRO'
  elseif l:current_mode =~? '[sS]'
    return 'SEL'
  elseif l:current_state =~# '[mo]'
    return 'PEN'
  else
    return 'NRM'
  endif
endfunction

function! picoline#build(active) abort
  if !a:active
    return picoline#build_sleeping()
  endif

  let l:icon = '(ᵔ◡ᵔ)'
  let l:statusline_hlgroup = '%#StatusLine#'
  let l:sep_char = '│'
  let l:sep_colored = ' %#PicolineSeparator#' . l:sep_char . l:statusline_hlgroup . ' '
  let l:mode_info = s:get_mode_info()

  let l:left = ' %#Picoline' . l:mode_info . '#' . l:mode_info . l:statusline_hlgroup
  let l:left .= l:sep_colored . fnamemodify(getcwd(), ':t')
  let l:left .= l:sep_colored . '%{expand("%:.")} %m %r %h'

  let l:right = ''

  if exists('*gutentags#statusline') == 1
    let l:gt = gutentags#statusline()
    if !empty(l:gt)
      let l:right .= l:sep_colored . l:gt
    endif
  endif

  if exists('*g:FugitiveHead') == 1
    let l:branch = FugitiveHead()
    if !empty(l:branch)
      let l:right .= l:sep_colored . l:branch
    endif
  endif

  let l:current_ft = empty(&filetype) ? '?' : &filetype
  let l:right .= l:sep_colored . l:current_ft
  let l:right .= l:sep_colored . l:icon

  return l:left . '%=' . l:right
endfunction

function! picoline#build_sleeping() abort
  let l:separator = ' '
  let l:icon = '(∪｡∪)'

  let l:statusline_segments = [
        \ '%#StatusLineNC#',
        \ l:separator,
        \ '%{expand("%:t")}',
        \ '%=',
        \ l:separator,
        \ l:icon,
        \ ]
  return join(l:statusline_segments)
endfunction

function! picoline#toggle() abort
  if &laststatus == 2
    set laststatus=0
  else
    set laststatus=2
  endif
endfunction

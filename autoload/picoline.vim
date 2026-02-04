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

  let l:separator = '│'
  let l:icon = '(ᵔ◡ᵔ)'

  let l:fugitive = exists('*g:FugitiveHead') == 1
        \ ? l:separator . ' ' . '%{FugitiveHead()}'
        \ : ''
  let l:gutentags = exists('*gutentags#statusline') == 1
        \ ? l:separator . ' ' . '%{gutentags#statusline()}'
        \ : ''

  let l:statusline_hlgroup = '%#StatusLine#'
  let l:current_ft = empty(&filetype) ? '?' : '%{&filetype}'
  let l:mode_info = s:get_mode_info()

  let l:statusline_segments = [
        \ '%#Picoline' . l:mode_info . '#',
        \ '' . l:mode_info . '',
        \ l:statusline_hlgroup,
        \ l:separator,
        \ fnamemodify(getcwd(), ':t'),
        \ l:separator,
        \ '%{expand("%:.")} %m %r %h',
        \ '%=',
        \ l:gutentags,
        \ l:fugitive,
        \ l:separator,
        \ l:current_ft,
        \ l:separator,
        \ l:icon,
        \ ]
  return join(l:statusline_segments)
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

if exists('g:loaded_picoline') || &cp
  finish
endif
let g:loaded_picoline = 1

function! s:setup_picoline_colors() abort
  let l:default_bg = synIDattr(hlID('StatusLine'), 'bg', 'gui')
  let l:default_fg = synIDattr(hlID('StatusLine'), 'fg', 'gui')

  if l:default_bg ==# ''
    let l:default_bg = '#2e3440'
  endif
  if l:default_fg ==# ''
    let l:default_fg = '#d8dee9'
  endif

  let l:default_mode_colors = {
        \ 'NRM': {'fg': l:default_fg, 'bg': l:default_bg},
        \ 'INS': {'fg': '#ffffff', 'bg': '#bf616a'},
        \ 'VIS': {'fg': '#2e3440', 'bg': '#ebcb8b'},
        \ 'CMD': {'fg': '#2e3440', 'bg': '#d08770'},
        \ 'RPL': {'fg': '#ffffff', 'bg': '#b48ead'},
        \ 'SEL': {'fg': '#ffffff', 'bg': '#5e81ac'},
        \ 'TRM': {'fg': '#2e3440', 'bg': '#88c0d0'},
        \ 'PRO': {'fg': '#2e3440', 'bg': '#a3be8c'},
        \ 'EXT': {'fg': l:default_fg, 'bg': '#4c566a'},
        \ 'PEN': {'fg': '#2e3440', 'bg': '#8fbcbb'},
        \ 'SCH': {'fg': '#2e3440', 'bg': '#81a1c1'},
        \ }

  for [l:mode, l:colors] in items(l:default_mode_colors)
    let l:group_name = 'Picoline' . l:mode
    if hlID(l:group_name) == 0 || synIDattr(hlID(l:group_name), 'bg', 'gui') ==# ''
      execute printf(
            \ 'highlight %s guifg=%s guibg=%s ctermfg=white ctermbg=black',
            \ l:group_name,
            \ l:colors.fg,
            \ l:colors.bg
            \ )
    endif
  endfor
endfunction

augroup picoline
  autocmd!
  autocmd SigUSR1            *  call s:setup_picoline_colors()
  autocmd ColorScheme        *  call s:setup_picoline_colors()
  autocmd WinEnter,BufEnter  *  setlocal statusline=%!picoline#build(v:true)
  autocmd WinLeave,BufLeave  *  setlocal statusline=%!picoline#build(v:false)
augroup END

call s:setup_picoline_colors()

command! -bar PicolineToggle call picoline#toggle()


" functions for completion in vim scripts

function! s:get_input() abort
  let col = col( '.' )
  let line = getline( '.' )
  if col - 1 < len( line )
    return matchstr( line, '^.*\%' . col . 'c' )
  endif
  return line
endfunction

function! Vim_complete(findstart, base) abort
  let line_prefix = s:get_input()
  if a:findstart
    let ret = necovim#get_complete_position(line_prefix)
    if ret < 0
      return col( '.' ) " default to current
    endif
    return ret
  else
    let candidates = necovim#gather_candidates(line_prefix . a:base, a:base)
    let filtered_candidates = []
    for candidate in candidates
      if candidate.word =~? '^' . a:base
        call add(filtered_candidates, candidate)
      endif
    endfor
    return filtered_candidates
  endif
endfunctio

" FZF helper functions

function! FilesOrGfiles()
  if finddir('.git', ';') != ''
    :GFiles
  else
    :Files
  endif
endfunction

function! AgWithParam()
  call inputsave()
  let pattern = input('Enter pattern: ')
  call inputrestore()
  execute "Ag " . pattern
endfunction

function! TagsWithCword()
  execute "Tags " . expand('<cword>')
endfunction


" functions to map a key in a set of modes

function! Map_for_all(mapping, target, ...)
  let l:for_input = (a:0 >= 1) ? a:1 : 0
  let l:for_cmd = (a:0 >= 2) ? a:2 : 0
  let l:for_terminal = (a:0 >= 3) ? a:3 : 0

  for item in ['nnoremap', 'vmap', 'omap']
    execute item . ' ' . a:mapping . ' ' . a:target
  endfor

  if has("nvim") || has('terminal')
    if l:for_terminal != 0
      execute 'tnoremap '.a:mapping.' <C-\><C-n>'.a:target
    endif
  endif

  if l:for_cmd != 0
    execute 'cmap '.a:mapping.' '.a:target
  endif

  if l:for_input > 1
    execute 'imap ' . a:mapping . ' <esc>' . a:target
  else
    execute 'imap ' . a:mapping . ' ' . a:target
  endif
endfunction

function! Map_for_all_meta(mapping, target, ...)
  let l:for_input = (a:0 >= 1) ? a:1 : 2
  let l:for_cmd = (a:0 >= 2) ? a:2 : 1
  let l:for_terminal = (a:0 >= 3) ? a:3 : 1

  call Map_for_all('<A-'.a:mapping.'>', a:target, l:for_input, l:for_cmd, l:for_terminal)
  let l:mapping = split(a:mapping, '-')
  if len(l:mapping) == 2 && l:mapping[0] == "S"
    let l:mapping = toupper(l:mapping[1])
  else
    let l:mapping = a:mapping
  endif
  call Map_for_all('<Esc>'.l:mapping, a:target, l:for_input, l:for_cmd, l:for_terminal)
endfunction

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction


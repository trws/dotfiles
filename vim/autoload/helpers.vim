
" functions for completion in vim scripts

" function s:get_input() abort
"   let col = col( '.' )
"   let line = getline( '.' )
"   if col - 1 < len( line )
"     return matchstr( line, '^.*\%' . col . 'c' )
"   endif
"   return line
" endfunction
"
" function helpers#Vim_complete(findstart, base) abort
"   let line_prefix = s:get_input()
"   if a:findstart
"     let ret = necovim#get_complete_position(line_prefix)
"     if ret < 0
"       return col( '.' ) " default to current
"     endif
"     return ret
"   else
"     let candidates = necovim#gather_candidates(line_prefix . a:base, a:base)
"     let filtered_candidates = []
"     for candidate in candidates
"       if candidate.word =~? '^' . a:base
"         call add(filtered_candidates, candidate)
"       endif
"     endfor
"     return filtered_candidates
"   endif
" endfunctio

" FZF helper functions

function helpers#FilesOrGfiles()
  if finddir('.git', ';') != ''
    :GFiles
  else
    :Files
  endif
endfunction

function helpers#AgWithParam()
  call inputsave()
  let pattern = input('Enter pattern: ')
  call inputrestore()
  execute "Ag " . pattern
endfunction

function helpers#TagsWithCword()
  execute "Tags " . expand('<cword>')
endfunction


" functions to map a key in a set of modes

function helpers#Map_for_all(mapping, target, ...)
  let l:for_input = (a:0 >= 1) ? a:1 : 0
  let l:for_cmd = (a:0 >= 2) ? a:2 : 0
  let l:for_terminal = (a:0 >= 3) ? a:3 : 0

  execute 'noremap ' . a:mapping . ' ' . a:target

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

function helpers#Map_for_all_meta(mapping, target, ...)
  let l:for_input = (a:0 >= 1) ? a:1 : 2
  let l:for_cmd = (a:0 >= 2) ? a:2 : 1
  let l:for_terminal = (a:0 >= 3) ? a:3 : 1

  call helpers#Map_for_all('<A-'.a:mapping.'>', a:target, l:for_input, l:for_cmd, l:for_terminal)
  let l:split_mapping = split(a:mapping, '-')
  if len(l:split_mapping) == 2 && l:split_mapping[0] == "S"
    let l:mapping = toupper(l:split_mapping[1])
  else
    let l:mapping = a:mapping
  endif
  call helpers#Map_for_all('<Esc>'.l:mapping, a:target, l:for_input, l:for_cmd, l:for_terminal)
endfunction

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function helpers#AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction

" toggle a file browser on left
function helpers#ToggleVExplorer()
  if g:vimfiler_as_default_explorer
    VimFilerExplorer
  else
    if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
        let cur_win_nr = winnr()
        exec expl_win_num . 'wincmd w'
        close
        exec cur_win_nr . 'wincmd w'
        unlet t:expl_buf_num
      else
        unlet t:expl_buf_num
      endif
    else
      exec '1wincmd w'
      Vexplore
      exec 'wincmd H'
      let t:expl_buf_num = bufnr("%")
    endif
  endif
endfunction

function helpers#Find_main_latex()
  let latexmain = findfile("paper.tex", ".;")
  if (!empty(latexmain))
    return latexmain
  endif
  let latexmain = findfile("header.tex", ".;")
  if (!empty(latexmain))
    return latexmain
  endif
  let basedir = finddir(".git", ".;")
  if (isdirectory(basedir))
    let latexmain = glob(basedir . "/*.latexmain")
    if (filereadable(latexmain))
      return substitute(latexmain, ".latexmain", "", "")
    endif
  endif
  return ""
endfunction

fun helpers#TeX_fmt()
  if (getline(".") != "")
    let save_cursor = getpos(".")
    let op_wrapscan = &wrapscan
    set nowrapscan
    let par_begin = '^\(%D\)\=\s*\($\|\\begin\|\\end\|\\Start\|\\Stop\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\|\\noindent\>\)'
    let par_end   = '^\(%D\)\=\s*\($\|\\begin\|\\end\|\\Start\|\\Stop\|\\place\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\)'
    try
      exe '?'.par_begin.'?+'
    catch /E384/
      1
    endtry
    norm V
    try
      exe '/'.par_end.'/-'
    catch /E385/
      $
    endtry
    norm gq
    let &wrapscan = op_wrapscan
    call setpos('.', save_cursor)
  endif
endfun


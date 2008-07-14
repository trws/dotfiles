" emacsmodeline.vim
" Brief: Parse emacs mode line and setlocal in vim
" Version: 0.1
" Date: May.18, 2007
" Maintainer: Yuxuan 'fishy' Wang <fishywang@gmail.com>
"
" Installation: put this file under your ~/.vim/plugins/
"
" Usage:
"
" This script is used to parse emcas mode line, for example:
" -*- tab-width: 2 -*-
"
" Which is the same meaning as:
" vim:tabstop=2:
" 
" As I don't use emacs, I don't know all the emacs mode line commands, I only
" put a parser for "tab-width" into the code as an example. You can add your
" own.
"
" Revisions:
"
" 0.1, May.18, 2007:
"  * initial version with tab-width support
"

function! FindParameter(expr, para)
        let regmid = '.*[        ;]' . a:para . ':\(.\{-}\);.*'
        let regend = '.*[        ;]' . a:para . ':\(.*\)'
        if a:expr =~ regmid
                return substitute(a:expr, regmid, '\1', '')
        elseif a:expr =~ regend
                return substitute(a:expr, regend, '\1', '')
        endif
        return ''
endfunc

function! ParseEmacsModeLine()
        let fname = expand('%:p')
        for line in readfile(fname)
                if line =~ '-\*-.*-\*-'
                        let line = substitute(line, '.*-\*-\(.*\)-\*-.*', ' \1', '')
                        let pat = FindParameter(line, 'tab-width')
                        if strlen(pat)
                                let pat = substitute(pat, '\s', '', 'g')
                                exec 'setlocal tabstop=' . pat
                        endif
                        let pat = FindParameter(line, 'c-basic-offset')
                        if strlen(pat)
                                let pat = substitute(pat, '\s', '', 'g')
                                exec 'setlocal sts=' . pat
                                exec 'setlocal sw=' . pat
                                exec 'setlocal expandtab'
                        endif
                endif
        endfor
endfunc

autocmd BufReadPre * :call ParseEmacsModeLine()


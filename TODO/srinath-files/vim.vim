"        File: vim.vim
"      Author: Srinath Avadhanula
"     Created: Thu Mar 21 06:00 PM 2002 PST
" Last Change: Thu Jan 02 11:00 PM 2003 PST
" Description: ftplugin for vim
" 
" Installation:
"      History: 
"         TODO:
"=============================================================================

" b:forceRedoVim allows this plugin to be forcibly re-sourced.
if exists('b:didLocalVim') && !exists('b:forceRedoVim')
	finish
end
let b:didLocalVim = 1

au BufWritePre *.vim :set ff=unix

" Vim Mappings {{{
let s:ml = exists('g:mapleader') ? g:mapleader : '\'

call IMAP ('while'.s:ml,    "let <++> = <++>\<cr>while <++> <= <++>\<cr><++>\<cr>let <++> = <++> + 1\<cr>endwhile<++>", 'vim')
call IMAP ('fdesc'.s:ml,    "\"Description: ", 'vim')
call IMAP ('sec'.s:ml,      "\" \<esc>78a=\<esc>o\" \<cr> \<esc>78i=\<esc>", 'vim')
call IMAP ('func'.s:ml,     "\<C-r>=AskVimFunc()\<cr>", 'vim')
call IMAP ('()',     		"(<++>)<++>", 'vim')
call IMAP ('""',     		"\"<++>\"<++>", 'vim')
call IMAP ("''",     		"'<++>'<++>", 'vim')
call IMAP ('<<',            '<+ä+><++>', 'vim')
" end vim mappings }}}
" AskVimFunc: asks for function name and sets up template {{{
" Description: 
function! AskVimFunc()
	let name = input('Name of the function : ')
	if name == ''
		let name = "<+Function Name+>"
	end
	let islocal = input('Is this function scriptlocal ? [y]/n : ', 'y')
	if islocal == 'y'
		let sidstr = '<SID>'
	else
		let sidstr = ''
	endif
	return IMAP_PutTextWithMovement( 
		\ "\" ".name.": <+short description+> {{{\<cr>" .
		\ "\" Description: <+long description+>\<cr>" . 
		\ "\<C-u>function! ".name."(<+arguments+>)<++>\<cr>" . 
		\       "<+function body+>\<cr>" . 
		\ "endfunction \" }}}"
		\ )
endfunction " }}}

" ==============================================================================
" folding stuff.
" ============================================================================== 
" Function: MakeVimFolds (force) {{{
function! MakeVimFolds(force)
	if &ft != 'vim'
		return
	end

	let b:numFoldItems = 0

	" first priority to markers. ignore every other kind of fold in a marked
	" region.
	call AddSyntaxFoldItem (
		\ '{{{',
		\ '}}}',
		\ 0,
		\ 0,
		\ '{{{',
		\ '}}}'
		\ )

	" havent really come across a good looking vim syntax highlighting scheme.
	" just stick with markers. for example, this file, imho looks pretty good
	" with fdm=marker, imo. for another example, look at tex.vim
	
	" call AddSyntaxFoldItem (
	" 	\ '^" \w\+: ',
	" 	\ '\s*endf\(u\|un\|unc\|unct\|uncti\|unctio\|unction\)',
	" 	\ 0,
	" 	\ 0,
	" 	\ '', ''
	" 	\ )

	" " call FoldRegions('^" =\{70,}', '^[^"]*$', 1, 0)
	" call AddSyntaxFoldItem (
	" 	\ '^" \w\+: ',
	" 	\ '\s*endf\(u\|un\|unc\|unct\|uncti\|unctio\|unction\)',
	" 	\ 0,
	" 	\ 0, '', ''
	" 	\ )

	" call AddSyntaxFoldItem (
	" 	\ '^\s*f\(u\|un\|unc\|unct\|uncti\|unctio\|unction\)',
	" 	\ '\s*endf\(u\|un\|unc\|unct\|uncti\|unctio\|unction\)',
	" 	\ 0,
	" 	\ 0, '', ''
	" 	\ )

	call MakeSyntaxFolds(a:force)
endfunction
" }}}
" set up autocommands for folding {{{
if mapcheck('<F6>') == ""
	exe ':nnoremap <buffer> <F6> :call MakeVimFolds(1)<cr>'
endif
nnoremap <buffer> <leader>rf :call MakeVimFolds(1)<cr>
" }}}

" vim600:fdm=marker

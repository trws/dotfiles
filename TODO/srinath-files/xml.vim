"=============================================================================
" 	     File: d:/srinath/vimfiles/ftplugin/xml.vim
"      Author: Srinath Avadhanula
"=============================================================================

setlocal fdm=manual

inoremap <buffer> <silent> <C-_> <C-r>=CompleteTag()<CR>

vnoremap <buffer> <silent> `par <C-\><C-N>:call VEnclose('<para>', '</para>', '<para>', '</para>')<CR>
vnoremap <buffer> <silent> `tab <C-\><C-N>:call VEnclose('<table>', '</table>', '<table>', '</table>')<CR>
vnoremap <buffer> <silent> `row <C-\><C-N>:call VEnclose('<row>', '</row>', '<row>', '</row>')<CR>
vnoremap <buffer> <silent> `col <C-\><C-N>:call VEnclose('<col>', '</col>', '<col>', '</col>')<CR>

vnoremap <buffer> <silent> `ask <C-\><C-N>:call EncloseSelection()<CR>

" CompleteTag: makes a tag from last word {{{
" Description: 
function! CompleteTag()
	let line = strpart(getline('.'), 0, col('.'))
	
	let word = matchstr(line, '\w\+$')
	if word != ''
		let back = substitute(word, '.', "\<BS>", 'g')
		return IMAP_PutTextWithMovement(back."<".word."><++></".word."><++>")
	else
		return ''
	endif
endfunction " }}}
" EncloseSelection: enclose visual selection in tags {{{
" Description: prompts for tag name

let s:lastVal = ''
function! EncloseSelection()
	let name = input('Enter tag name:', s:lastVal)
	let s:lastVal = name
	let startTag = '<'.name.'>'
	let endTag = '</'.name.'>'
	call VEnclose(startTag, endTag, startTag, endTag)
endfunction " }}}

" vim:fdm=marker

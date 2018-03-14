" syn region texZone	start="\\begin{[^}]\+code}"		end="\\end{[^}]\+code}\|%stopzone\>"
" syn region texZone	start="\\begin{minted}"		end="\\end{minted}\|%stopzone\>"
" syn region texZone	start="|"		end="|"

" let s:current_syntax=b:current_syntax
" unlet b:current_syntax
" syntax include @C syntax/c.vim
" syn region texZone	start="\\begin{minted}{c}"		end="\\end{minted}\|%stopzone\>" contains=@C
" let b:current_syntax=s:current_syntax
"
" let s:current_syntax=b:current_syntax
" unlet b:current_syntax
" syntax include @CPP syntax/cpp.vim
" syn region texZone	start="\\begin{minted}{cpp}"		end="\\end{minted}\|%stopzone\>" contains=@CPP
" let b:current_syntax=s:current_syntax

" let s:current_syntax=b:current_syntax
" unlet b:current_syntax
" syntax include @F syntax/fortran.vim
" syn region texZone	start="\\begin{minted}{fortran}"		end="\\end{minted}\|%stopzone\>" contains=@F
" let b:current_syntax=s:current_syntax

" syn region baseBox	matchgroup=texBeginEnd	start="\\begin{boxedcode}"		end="\\end{boxedcode}\|%stopzone\>"
" syn region texParaZone	matchgroup=texSection	start="\\cspecificstart\>"		end="\\cspecificend\>"	contains=ALLBUT,cppBox,fBox,baseBox
" syn region texParaZone	matchgroup=texSection	start="\\\(cpp\|ccpp\)specificstart\>"		end="\\\(cpp\|ccpp\)specificend\>"	contains=ALLBUT,cBox,fBox,baseBox
" syn region texParaZone	matchgroup=texSection	start="\\fortranspecificstart\>"		end="\\fortranspecificend\>"	contains=ALLBUT,cppBox,cBox,baseBox
" hi! link baseBox	NONE
" hi! link cBox	NONE
" hi! link cppBox	NONE
" hi! link fBox	NONE

" syntax include @VimL syntax/vim.vim
" syntax region vimSnip matchgroup=htmlTag start="<pre>" end="</pre>" contains=@VimL


" let s:current_syntax=b:current_syntax
" unlet b:current_syntax
" syntax include @C syntax/c.vim
" syn region cBox	matchgroup=texBeginEnd	start="\\begin{boxedcode}"		end="\\end{boxedcode}\|%stopzone\>" contained contains=@C
" let b:current_syntax=s:current_syntax
"
" let s:current_syntax=b:current_syntax
" unlet b:current_syntax
" syntax include @CPP syntax/cpp.vim
" syn region cppBox	matchgroup=texBeginEnd	start="\\begin{boxedcode}"		end="\\end{boxedcode}\|%stopzone\>" contained contains=@CPP
" let b:current_syntax=s:current_syntax
"
" let s:current_syntax=b:current_syntax
" unlet b:current_syntax
" syntax include @F syntax/fortran.vim
" syn region fBox	matchgroup=texBeginEnd	start="\\begin{boxedcode}"		end="\\end{boxedcode}\|%stopzone\>" contained contains=@F
" let b:current_syntax=s:current_syntax

" syn region texZone	start="\\begin{boxedcode}"		end="\\end{boxedcode}\|%stopzone\>"
syn region texZone	start="\\begin{indentedcodelist}"		end="\\end{indentedcodelist}\|%stopzone\>"
syn region texZone	start="\\begin{ompcFunction}"		end="\\end{ompcFunction}\|%stopzone\>"
syn region texZone	start="\\vcode\*\=\z([^\ta-zA-Z]\)"	end="\z1\|%stopzone\>"		
syntax match texZone "\\code\s*\(\[.*\]\)\={.\{-}}"
syntax match texZone "\\scode\s*\(\[.*\]\)\={.\{-}}"
syntax match texZone "\\hcode\s*\(\[.*\]\)\={.\{-}}"
syntax match texZone "\\index\s*\(\[.*\]\)\={.\{-}}"
syntax match texZone "\\plc\s*\(\[.*\]\)\={.\{-}}"
syntax match texZone "\\splc\s*\(\[.*\]\)\={.\{-}}"
syntax match texZone "\\splc\s*\(\[.*\]\)\={.\{-}}"
syntax match texRefZone "\\specref\s*\(\[.*\]\)\={.\{-}}"
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


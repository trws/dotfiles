" include markdown syntax, tpope's specifically
runtime! syntax/markdown.vim

syn region	mailQuoted6	keepend start="^\z(\(\([a-z]\+>\|[]|}>]\)[ \t]*\)\{5}\([a-z]\+>\|[]|}>]\)\)" end="^\z1\@!" fold
syn region	mailQuoted5	keepend contains=mailQuoted6 start="^\z(\(\([a-z]\+>\|[]|}>]\)[ \t]*\)\{4}\([a-z]\+>\|[]|}>]\)\)" end="^\z1\@!" fold
syn region	mailQuoted4	keepend contains=mailQuoted5,mailQuoted6 start="^\z(\(\([a-z]\+>\|[]|}>]\)[ \t]*\)\{3}\([a-z]\+>\|[]|}>]\)\)" end="^\z1\@!" fold
syn region	mailQuoted3	keepend contains=mailQuoted4,mailQuoted5,mailQuoted6 start="^\z(\(\([a-z]\+>\|[]|}>]\)[ \t]*\)\{2}\([a-z]\+>\|[]|}>]\)\)" end="^\z1\@!" fold
syn region	mailQuoted2	keepend contains=mailQuoted3,mailQuoted4,mailQuoted5,mailQuoted6 start="^\z(\(\([a-z]\+>\|[]|}>]\)[ \t]*\)\{1}\([a-z]\+>\|[]|}>]\)\)" end="^\z1\@!" fold
syn region	mailQuoted1	keepend contains=mailQuoted2,mailQuoted3,mailQuoted4,mailQuoted5,mailQuoted6 start="^\z([a-z]\+>\|[]|}>]\)" end="^\z1\@!" fold

hi def link mailQuoted1		Comment
hi def link mailQuoted3		mailQuoted1
hi def link mailQuoted5		mailQuoted1
hi def link mailQuoted2		Identifier
hi def link mailQuoted4		mailQuoted2
hi def link mailQuoted6		mailQuoted2


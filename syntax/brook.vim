" Vim syntax file
" Language: Brook
" Maintainer: Roberto Bonvallet <rbonvall+vim@gmail.com>
" Repository: http://github.com/rbonvall/vim-scripts/
"
" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif
 
" Load C syntax
runtime! syntax/c.vim
unlet b:current_syntax
 
" Brook extentions
syn keyword brookKeyword kernel reduce out iter
syn keyword brookType float2 float3 float4
syn keyword brookStreamOp streamRead streamWrite streamGatherOp streamScatterOp
syn keyword brookOperator indexof
 
" Define highlighting
highlight def link brookKeyword Keyword
highlight def link brookType Type
highlight def link brookStreamOp Function
highlight def link brookOperator Operator
 
let b:current_syntax = "brook"

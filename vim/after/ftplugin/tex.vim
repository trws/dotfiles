" Highlight words I might use to mess up grammar
highlight whichthat ctermfg=Magenta guifg=#515996
match whichthat /\(\swhich\s\|\sthat\s\)/

" Disable spell checking in comments
let g:tex_comment_nospell= 1

setlocal formatoptions+=t
setlocal formatexpr=cindent

"latex options
let g:LatexBox_viewer = 'open -a Skim'
let g:LatexBox_quickfix = 0
let g:LatexBox_latexmk_options = '-pdf -shell-escape' "latter is needed for pygments
let g:LatexBox_latexmk_preview_continuously=0
let g:tex_flavor='latex'
let g:Imap_FreezeImap=1
let g:Tex_FormatDependency_pdf = 'pdf'
if has('macunix')
  let g:Tex_ViewRule_pdf = 'open '
  let g:Tex_ViewRuleComplete_pdf = 'open $*.pdf'
elseif has('unix')
  let g:Tex_ViewRule_pdf = 'evince '
  let g:Tex_ViewRuleComplete_pdf = 'evince $*.pdf'
endif
map <silent> <Leader>ls :silent
      \ !/Applications/Skim.app/Contents/SharedSupport/displayline
      \ <C-R>=line('.')<CR> "<C-R>=LatexBox_GetOutputFile()<CR>"
      \ "%:p" <CR>

nmap <silent> <Leader>wc bi\code{<esc>ea}<esc>
vmap <silent> <Leader>wc di\code{}<esc>P
nmap <silent> <Leader>wp bi\plc{<esc>ea}<esc>
vmap <silent> <Leader>wp di\plc{}<esc>P
vmap <silent> <Leader>wl di\lstinline{}<esc>P

nmap wil diwi\lstinline{}<Esc>P
nmap wip diwi\plc{}<Esc>P
nmap wic diwi\code{}<Esc>P

let g:Tex_DefaultTargetFormat='pdf'
setlocal spell spelllang=en_us
imap <buffer> <C-b> <Plug>Tex_MathBF
imap <buffer> <C-l> <Plug>Tex_LeftRight
imap <buffer> <A-i> <Plug>Tex_InsertItemOnThisLine
imap <buffer> <Esc>i <Plug>Tex_InsertItemOnThisLine
let b:main_tex_file=helpers#Find_main_latex()

let g:Tex_DefaultTargetFormat = 'pdf'

let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 --interaction=nonstopmode $*'

let g:Tex_ViewRule_pdf = 'Skim'


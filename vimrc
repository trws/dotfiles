"paths and includes
set runtimepath+=~/.vim/included/c-support
set runtimepath+=~/.vim/included/latex-suite
set runtimepath+=~/.vim/included/vimoutliner
runtime ftplugin/man.vim

"tags
set tags+=~/.vim-systags

"syntax/visual options
syn on
colorscheme murphy
set background=dark
set ruler
set wrap

if has("gui_running")
  set guioptions-=T
  if has("gui_macvim")
    set transparency=15
    set gfn=Courier:h11.00
    set fuopt=maxvert,maxhorz
  elseif has("gui_gtk2")
    set guifont=Terminus\ 8
  elseif has("x11")
    " Also for GTK 1
    set guifont=-misc-fixed-medium-r-normal-*-10-*-*-*-c-*-iso8859-15 
  endif
endif

if &term =~ ".*256color.*" || has("gui_running")
  set t_Co=256
  let g:inkpot_black_background=1
  colorscheme inkpot
endif

"mouse options
set mouse=a
set ttym=xterm2

if &term =~ "screen.*"
  set t_kb=
  set ttymouse=xterm2
  set t_ku=OA
  set t_kd=OB
  set t_kr=OC
  set t_kl=OD 
  set t_@7=[4~
  set t_kh=[1~
endif

"editing behavior
set backspace=2
set softtabstop=2
set shiftwidth=2
set expandtab
set hlsearch
set incsearch
set ignorecase

"indent
set autoindent
set smartindent
filetype indent on

filetype plugin on
runtime ftplugin/man.vim

"latex options
let g:Tex_FormatDependency_pdf = 'pdf'
if exists("$SYSTEM") 
  if $SYSTEM == "darwin"
    let g:Tex_ViewRule_pdf = 'open '
    let g:Tex_ViewRuleComplete_pdf = 'open $*.pdf' 
  elseif $SYSTEM == "linux"
    let g:Tex_ViewRule_pdf = 'evince '
    let g:Tex_ViewRuleComplete_pdf = 'evince $*.pdf' 
  endif
endif
au FileType tex TTarget pdf
au FileType tex set textwidth=80
au FileType tex setlocal spell spelllang=en_us
au FileType tex imap <C-b> <Plug>Tex_MathBF
au FileType tex imap <C-l> <Plug>Tex_LeftRight
au FileType tex imap <C-p> <Plug>Tex_InsertItemOnThisLine

"make file and command options
" Command Make will call make and then cwindow which
" opens a 3 line error window if any errors are found.
" if no errors, it closes any open cwindow.
command! -nargs=* Make make <args> | cwindow 3

au FileType make inoremap <tab> <tab>
au FileType make set softtabstop=0
au FileType make set shiftwidth=8
au FileType make set noexpandtab
au FileType make set noautoindent
au FileType make set nosmartindent

"general key remappings
map <S-Z><S-S> :up<CR>
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

if ! has("gui_macvim")
  nnoremap <special> <A-v> "+gP
  cnoremap <special> <A-v> <C-R>+
  execute 'vnoremap <script> <special> <A-v>' paste#paste_cmd['v']
  execute 'inoremap <script> <special> <A-v>' paste#paste_cmd['i']
endif

if ! has("gui_running")
  if $SYSTEM == "darwin"
    vmap <C-y> y:call system("pbcopy", getreg("\""))<CR>
  elseif $SYSTEM == "linux"
    vmap <C-y> y:call system("xclip", getreg("\""))<CR>
  endif
endif

nnoremap  <C-c>  <ESC>
vmap      <C-c>  <ESC>
imap      <C-c>  <ESC>
cmap      <C-c>  <ESC>
omap      <C-c>  <ESC>

if ! has("gui_macvim")
  nnoremap  <A-}>  :tabNext<CR>
  vmap      <A-}>  :tabNext<CR>
  imap      <A-}>  :tabNext<CR>
  cmap      <A-}>  :tabNext<CR>
  omap      <A-}>  :tabNext<CR>
  nnoremap  <A-{>  :tabprevious<CR>
  vmap      <A-{>  :tabprevious<CR>
  imap      <A-{>  :tabprevious<CR>
  cmap      <A-{>  :tabprevious<CR>
  omap      <A-{>  :tabprevious<CR>
endif

"general options
set grepprg=grep\ -nH\ $*

"winmanager
let g:winManagerWindowLayout = "Project|TagList"

"project plugin options
map           <A-S-o> :Project<CR>:redraw<CR>
map           <A-S-p> <Plug>ToggleProject
nmap <silent> <F3>    <Plug>ToggleProject
let g:proj_window_width = 30
let g:proj_window_increment = 50 

" --------------------
" TagList
" --------------------
" F4:  Switch on/off TagList
nnoremap <silent> <F4> :TlistToggle<CR>
nnoremap <silent> <A-S-t> :TlistToggle<CR>

" TagListTagName  - Used for tag names
highlight MyTagListTagName gui=bold guifg=Black guibg=Green cterm=bold ctermfg=Black ctermbg=Green
" TagListTagScope - Used for tag scope
highlight MyTagListTagScope gui=NONE guifg=Blue ctermfg=Blue
" TagListTitle    - Used for tag titles
highlight MyTagListTitle gui=bold guifg=DarkRed guibg=LightGray cterm=bold ctermfg=DarkRed ctermbg=LightGray
" TagListComment  - Used for comments
highlight MyTagListComment guifg=DarkGreen ctermfg=DarkGreen
" TagListFileName - Used for filenames
highlight MyTagListFileName gui=bold guifg=Black guibg=LightBlue cterm=bold ctermfg=Black ctermbg=LightBlue

"let Tlist_Ctags_Cmd = $VIM.'/vimfiles/ctags.exe' " location of ctags tool
let Tlist_Show_One_File = 1 " Displaying tags for only one file~
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_Use_Right_Window = 1 " split to the right side of the screen
let Tlist_Sort_Type = "order" " sort by order or name
let Tlist_Display_Prototype = 0 " do not show prototypes and not tags in the taglist window.
let Tlist_Compart_Format = 1 " Remove extra information and blank lines from the taglist window.
let Tlist_GainFocus_On_ToggleOpen = 1 " Jump to taglist window on open.
let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
let Tlist_Close_On_Select = 1 " Close the taglist window when a file or tag is selected.
let Tlist_Enable_Fold_Column = 0 " Don't Show the fold indicator column in the taglist window.
let Tlist_WinWidth = 30
"let Tlist_Ctags_Cmd = 'ctags --c++-kinds=+p --fields=+iaS --extra=+q --languages=c++'
" very slow, so I disable this
"let Tlist_Process_File_Always = 1 " To use the :TlistShowTag and the :TlistShowPrototype commands without the taglist window and the taglist menu, you should set this variable to 1.
":TlistShowPrototype [filename] [linenumber]



"paths and includes
set runtimepath+=~/.vim/included/c-support
set runtimepath+=~/.vim/included/latex-suite
set runtimepath+=~/.vim/included/vimoutliner
set runtimepath+=~/.vim/included/enhanced-commentify
runtime ftplugin/man.vim


"outliner checkboxes
au FileType otl source ~/.vim/plugin/vo_checkbox.vim
au FileType otl setlocal spell spelllang=en_us

"additional buffer types
au BufNewFile,BufRead *.cu set ft=cuda
au BufNewFile,BufRead *.cl set ft=opencl
au BufNewFile,BufRead *.br set ft=brook
au BufRead COMMIT_EDITMSG set backupcopy=no


"automatic formatting options
set textwidth=80
" set formatoptions=croql
set fo-=t
au FileType tex set formatoptions+=a
au FileType tex set formatoptions+=t
"set formatoptions+=a

"tags
set tags+=~/.vim-systags

if exists("$SYSTEM")
  if $SYSTEM == "darwin"
    let include_paths = '/opt/local/include /usr/local/include /usr/include /Developer/Headers'
  elseif $SYSTEM == "linux"
    let include_paths = '/usr/local/include /usr/include'
  endif
else
  let include_paths = '/usr/local/include /usr/include'
endif

map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q $PWD<CR>
execute 'map <C-S-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f - ' . include_paths . ' > ~/.vim-systags'

"syntax/visual options
set vb
set t_vb=
syn on
colorscheme slate
set background=dark
set ruler
set nowrap

if has("gui_running")
  set guioptions=egmt
  if has("gui_macvim")
    set transparency=15
    "set gfn=Courier:h11.00
    set gfn=Monaco:h9.00
    set noantialias
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

map  <BS>
cmap  <BS>
"keyboard options
set t_kb=
  nnoremap    <BS>
  vmap        <BS>
  imap        <BS>
  cmap        <BS>
  omap        <BS>

"screen session key remapping to fix issues
if &term =~ "screen.*-bce"
    set term=screen-256color
endif

  nnoremap      <BS>
  vmap          <BS>
  imap          <BS>
  cmap          <BS>
  omap          <BS>

if &term =~ "screen.*"
  set ttymouse=xterm
  set t_ku=OA
  set t_kd=OB
  set t_kr=OC
  set t_kl=OD
  set t_@7=OF
  set t_kh=[1~

  nnoremap <Esc>[C     <Right>
  vmap     <Esc>[C     <Right>
  imap     <Esc>[C     <Right>
  cmap     <Esc>[C     <Right>
  omap     <Esc>[C     <Right>
  nnoremap <Esc>[D     <Left>
  vmap     <Esc>[D     <Left>
  imap     <Esc>[D     <Left>
  cmap     <Esc>[D     <Left>
  omap     <Esc>[D     <Left>
  nnoremap <Esc>[A     <Up>
  vmap     <Esc>[A     <Up>
  imap     <Esc>[A     <Up>
  cmap     <Esc>[A     <Up>
  omap     <Esc>[A     <Up>
  nnoremap <Esc>[B     <Down>
  vmap     <Esc>[B     <Down>
  imap     <Esc>[B     <Down>
  cmap     <Esc>[B     <Down>
  omap     <Esc>[B     <Down>
  " map OB <Down>
  " map OA <Up>
  " map OD <Left>
  " map OC <Right>


  nnoremap  <Esc>[4~ <End>
  vmap      <Esc>[4~ <End>
  imap      <Esc>[4~ <End>
  cmap      <Esc>[4~ <End>
  omap      <Esc>[4~ <End>
  nnoremap  <Esc>[1~  <Home>
  vmap      <Esc>[1~  <Home>
  imap      <Esc>[1~  <Home>
  cmap      <Esc>[1~  <Home>
  omap      <Esc>[1~  <Home>

  nnoremap  <Esc>0F <End>
  vmap      <Esc>0F <End>
  imap      <Esc>0F <End>
  cmap      <Esc>0F <End>
  omap      <Esc>0F <End>
  nnoremap  <Esc>OH  <Home>
  vmap      <Esc>OH  <Home>
  imap      <Esc>OH  <Home>
  cmap      <Esc>OH  <Home>
  omap      <Esc>OH  <Home>
  nnoremap  <Esc>[F <End>
  vmap      <Esc>[F <End>
  imap      <Esc>[F <End>
  cmap      <Esc>[F <End>
  omap      <Esc>[F <End>
  nnoremap  <Esc>[H  <Home>
  vmap      <Esc>[H  <Home>
  imap      <Esc>[H  <Home>
  cmap      <Esc>[H  <Home>
  omap      <Esc>[H  <Home>
endif

"enhanced commentify
let g:EnhCommentifyUseAltKeys='No'
let g:EnhCommentifyAltOpen='/\\*'
let g:EnhCommentifyAltClose='*\\/'
let g:EnhCommentifyTraditionalMode='No'
let g:EnhCommentifyFirstLineMode='Yes'
let g:EnhCommentifyUserMode='No'
let g:EnhCommentifyRespectIndent='Yes'
let g:EnhCommentifyPretty='Yes'
let g:EnhCommentifyMultiPartBlocks='Yes'
let g:EnhCommentifyBindInInsert='No'
"csupport, but very commentify related...
let g:C_TypeOfH="c"

"editing behavior
set backspace=2
set softtabstop=2
set shiftwidth=2
set expandtab
set hlsearch
set incsearch
set ignorecase
set smartcase
set modeline
set modelines=5

"indent
set autoindent
set smartindent

"c/c++ options
au FileType c set foldmethod=syntax
"cuda file hilighting
au BufNewFile,BufRead *.cu set ft=cuda

"latex options
let g:tex_flavor='latex'
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
au FileType tex let g:Tex_DefaultTargetFormat='pdf'
au FileType tex setlocal spell spelllang=en_us
au FileType tex imap <C-b> <Plug>Tex_MathBF
au FileType tex imap <C-l> <Plug>Tex_LeftRight
au FileType tex imap <C-p> <Plug>Tex_InsertItemOnThisLine
au FileType tex imap <A-i> <Plug>Tex_InsertItemOnThisLine

au FileType txt set textwidth=80
au FileType txt setlocal spell spelllang=en_us
"build system options
" Command Make will call make and then cwindow which
" opens a 3 line error window if any errors are found.
" if no errors, it closes any open cwindow.
command! -nargs=* Make make <args> | cwindow 3
command! -nargs=* Scons scons <args> | cwindow 3

au BufRead,BufNewFile SConstruct set filetype=python

au FileType make inoremap <tab> <tab>
au FileType make set softtabstop=0
au FileType make set shiftwidth=8
au FileType make set noexpandtab
au FileType make set noautoindent
au FileType make set nosmartindent

"general key remappings
function! Map_for_all(mapping, target, for_cmd)
  for item in ['nnoremap', 'vmap', 'omap']
    execute item . ' ' . a:mapping . ' ' . a:target 
  endfor
  
  execute 'imap <Esc>' . a:mapping . ' ' . a:target 
  
  if a:for_cmd != 0
    execute 'cmap '.a:mapping.' '.a:target
  endif
endfunction

call Map_for_all("<C-c>","<Esc>", 1)

map <S-Z><S-S> :up<CR> 

if ! has("gui_macvim")
  nnoremap <special> <A-v> "+gP
  cnoremap <special> <A-v> <C-R>+
  execute 'vnoremap <script> <special> <A-v>' paste#paste_cmd['v']
  execute 'inoremap <script> <special> <A-v>' paste#paste_cmd['i']
  nnoremap  <Esc>[1;3C <End>
  vmap      <Esc>[1;3C <End>
  imap      <Esc>[1;3C <End>
  cmap      <Esc>[1;3C <End>
  omap      <Esc>[1;3C <End>
  nnoremap  <Esc>[1;3D <Home>
  vmap      <Esc>[1;3D <Home>
  imap      <Esc>[1;3D <Home>
  cmap      <Esc>[1;3D <Home>
  omap      <Esc>[1;3D <Home>
  nnoremap  <Esc>[1;9D <C-Left>
  vmap      <Esc>[1;9D <C-Left>
  imap      <Esc>[1;9D <C-Left>
  cmap      <Esc>[1;9D <C-Left>
  omap      <Esc>[1;9D <C-Left>
  nnoremap  <Esc>[1;9C <C-Right>
  vmap      <Esc>[1;9C <C-Right>
  imap      <Esc>[1;9C <C-Right>
  cmap      <Esc>[1;9C <C-Right>
  omap      <Esc>[1;9C <C-Right>

endif

if ! has("gui_running")
  if $SYSTEM == "darwin"
    vmap <C-y> y:call system("pbcopy", getreg("\""))<CR>
    vmap <A-y> y:call system("pbcopy", getreg("\""))<CR>
  elseif $SYSTEM == "linux"
    vmap <C-y> y:call system("xclip", getreg("\""))<CR>
  endif
endif

""tag jump remappings, makes <C-]> list if more than 1, immediate if only 1,
""alt does the same, but in a new vertical split so you can look at both
""together, awesome for looking at function arguments and defs together
function! Vertical_tag_jump()
  execute "vert rightb stj " . expand("<cword>")
endfunction
map  <C-]>   g<C-]>
imap  <C-]>  <Esc>g<C-]>
cmap  <C-]>  g<C-]>

map <silent> <A-]>  :call Vertical_tag_jump()<CR>
imap <silent> <A-]>  <Esc>:call Vertical_tag_jump()<CR>

if ! has("gui_macvim")
  "alt
  nnoremap  <A-}>  :tabNext<CR>
  vmap      <A-}>  :tabNext<CR>
  imap      <A-}>  <Esc>:tabNext<CR>
  cmap      <A-}>  <Esc>:tabNext<CR>
  omap      <A-}>  :tabNext<CR>
  nnoremap  <A-{>  :tabprevious<CR>
  vmap      <A-{>  :tabprevious<CR>
  imap      <A-{>  <Esc>:tabprevious<CR>
  cmap      <A-{>  <Esc>:tabprevious<CR>
  omap      <A-{>  :tabprevious<CR>
endif

"general options
set grepprg=grep\ -nH\ $*
set wildmenu
set foldmethod=syntax
filetype indent on
filetype plugin on
runtime ftplugin/man.vim

"winmanager
let g:winManagerWindowLayout = "Project|TagList"

"project plugin options
map           <A-S-o> :Project<CR>:redraw<CR>
map           <D-O> :Project<CR>:redraw<CR>
map           <A-S-p> <Plug>ToggleProject
map           <D-P> <Plug>ToggleProject
nmap <silent> <F3>    <Plug>ToggleProject
let g:proj_window_width = 30
let g:proj_window_increment = 50 
let g:proj_run_fold1 = ":!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f - %f > %d/tags"


" --------------------
" TagList
" --------------------
" F4:  Switch on/off TagList
nnoremap <silent> <F4> :TlistToggle<CR>
nnoremap <silent> <A-S-t> :TlistToggle<CR>
nnoremap <silent> <D-T> :TlistToggle<CR>

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

"unsorted, deal with later
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

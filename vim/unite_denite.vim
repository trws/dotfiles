"Unite and denite
let  g:notes_directories = ['~/Projects/notes']
if( ! has("python3")) " using unite
  let g:unite_data_directory = '~/.vim/unite'
  " let g:unite_source_bookmark_directory = '~/.vim/unite-bookmarks'
  let g:unite_source_history_yank_enable = 1
  let g:unite_source_grep_max_candidates = 500
  " call unite#filters#matcher_default#use(['converter_relative_word', 'matcher_fuzzy'])
  call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])
  call unite#filters#sorter_default#use(['sorter_rank'])
  call unite#custom#profile('files', 'filters', 'sorter_rank')
  call unite#custom#source('buffer,file,file/rec,file/rec/async', 'sorters', 'sorter_selecta')
  " call unite#custom#source('buffer,file,file/rec,file/rec/async', 'matchers',['converter_relative_word', 'matcher_fuzzy'])
  nnoremap <leader>ur  :<C-u>Unite -start-insert file/rec/async:!<CR>
  nnoremap <leader>ub  :<C-u>Unite buffer        file_mru bookmark<CR>
  nnoremap <leader>uB  :<C-u>Unite bookmark<CR>
  nnoremap <leader>uY  :<C-u>Unite history/yank<CR>
  nnoremap <leader>uf  :<C-u>Unite -start-insert file<CR>
  nnoremap <leader>un  :<C-u>Unite -start-insert file/rec:~/Projects/notes/<CR>
  nnoremap <leader>ug  :<C-u>Unite grep:.<CR>
  nnoremap <leader>uG  :<C-u>Unite grep:.:-i<CR>
  nnoremap <leader>utc :<C-u>Unite gtags/context<CR>
  nnoremap <leader>utr :<C-u>Unite gtags/ref<CR>
  nnoremap <leader>utd :<C-u>Unite gtags/def<CR>
  nnoremap <leader>utg :<C-u>Unite gtags/grep<CR>
  nnoremap <leader>utf :<C-u>Unite gtags/file<CR>
  nnoremap <leader>utC :<C-u>Unite gtags/completion<CR>
  augroup UniteTagsRemap
    autocmd BufEnter *
          \   if empty(&buftype)
          \|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
          \|  endif
  augroup END
else
  autocmd FileType denite call s:denite_my_settings()
  function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
          \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
          \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
          \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
          \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
          \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
          \ denite#do_map('toggle_select').'j'
  endfunction

  autocmd FileType denite-filter call s:denite_filter_my_settings()
  function! s:denite_filter_my_settings() abort
    imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
    inoremap <silent><buffer><expr> <C-y> denite#do_map('do_action')
    " inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  endfunction


  call denite#custom#alias('source', 'file/rec/git', 'file/rec')
  call denite#custom#var('file/rec/git', 'command',
        \ ['git', 'ls-files', '-co', '--exclude-standard'])
  " nnoremap <silent> <leader>ur :<C-u>Denite
  "       \ `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>

  nnoremap <silent> <leader>ur :<C-u>Denite `'file/rec:' . Find_ur_dir()`<CR>
  " nnoremap <silent> <leader>ur :<C-u>Denite file/rec<CR>
  " function! Enter_and_open(dirs)
  "   echo a:dirs
  "   echo a:dirs[0]
  "   " cd a:dirs[0]
  "   " Denite "file/rec:" . a:dirs[0]
  " endfunction
  " call denite#custom#action('directory', 'enter_and_open',
  "       \ {context -> Enter_and_open(context['targets'])})

  nnoremap <leader>ub  :Denite buffer file_mru<CR>
  nnoremap <leader>uY  :Denite neoyank<CR>
  nnoremap <leader>uf  :<C-u>Denite `'file/rec:' . expand('%:p:h')`<CR>
  nnoremap <leader>up  :<C-u>Denite `'file::' . expand('~/projects')`<CR>
  nnoremap <leader>un  :Denite file/rec:~/Projects/notes/<CR>
  nnoremap <leader>ug  :Denite grep:.<CR>
  nnoremap <leader>uG  :Denite grep:.:-i<CR>
  nnoremap <leader>ul  :Denite line<CR>
  nnoremap <leader>uT  :Denite outline<CR>
  nnoremap <leader>ut  :Denite tag<CR>
  nnoremap <leader>u]  :DeniteCursorWord -immediately-1 -mode=normal tag<CR>
  " nnoremap <leader>utc :DeniteCursorWord -buffer-name=gtags_context -immediately-1 -mode=normal gtags_context<CR>
  " nnoremap <leader>utr :DeniteCursorWord -buffer-name=gtags_ref -immediately-1 -mode=normal gtags_ref<CR>
  " nnoremap <leader>utd :DeniteCursorWord -buffer-name=gtags_def -immediately-1 -mode=normal gtags_def<CR>
  " nnoremap <leader>utg :DeniteCursorWord -buffer-name=gtags_grep -mode=normal gtags_grep<CR>
  " nnoremap <leader>utf :Denite           -buffer-name=gtags_file -mode=normal gtags_file<CR>
  " nnoremap <leader>utC :Denite           -buffer-name=gtags_completion -mode=normal gtags_completion<CR>
  augroup DeniteTagsRemap
    autocmd BufEnter *
          \   if empty(&buftype)
          \|      nnoremap <buffer> <C-]> :<C-u>DeniteCursorWord -immediately-1 tag<CR>
          \|  endif
  augroup END
  call denite#custom#map('normal', 'v', '<denite:do_action:vsplit>')

  if executable('ag')
    " Change file/rec command.
    call denite#custom#var('file/rec', 'command',
          \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

    " Ag command on grep source
    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'default_opts',
          \ ['-i', '--vimgrep'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
  elseif executable('rg')
    " For ripgrep
    " Note: It is slower than ag
    call denite#custom#var('file/rec', 'command',
          \ ['rg', '--files', '--glob', '!.git', ''])

    " Ripgrep command on grep source
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
          \ ['--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])

    " For Pt(the platinum searcher)
    " NOTE: It also supports windows.
  elseif executable('pt')
    call denite#custom#var('file/rec', 'command',
          \ ['pt', '--follow', '--nocolor', '--nogroup',
          \  (has('win32') ? '-g:' : '-g='), ''])

    " Pt command on grep source
    call denite#custom#var('grep', 'command', ['pt'])
    call denite#custom#var('grep', 'default_opts',
          \ ['--nogroup', '--nocolor', '--smart-case'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
  endif
  if executable('fd')
    call denite#custom#var('file/rec', 'command',
          \ ['fd', '--type', 'f', '--follow', '--color', 'never', ''])
  endif

  " Change mappings.
  call denite#custom#map(
        \ 'insert',
        \ '<C-j>',
        \ '<denite:move_to_next_line>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'insert',
        \ '<C-k>',
        \ '<denite:move_to_previous_line>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'insert',
        \ '<C-a>',
        \ '<denite:move_caret_to_head>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'insert',
        \ '<C-e>',
        \ '<denite:move_caret_to_tail>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'insert',
        \ '<A-b>',
        \ '<denite:move_caret_to_one_word_left>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'insert',
        \ '<A-f>',
        \ '<denite:move_caret_to_one_word_right>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'insert',
        \ '<A-BS>',
        \ '<denite:delete_word_before_caret>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'insert',
        \ '<A-d>',
        \ '<denite:delete_word_under_caret>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'insert',
        \ '<Up>',
        \ '<denite:move_to_previous_line>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'insert',
        \ '<Down>',
        \ '<denite:move_to_next_line>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'insert',
        \ '<S-Up>',
        \ '<denite:assign_previous_matched_text>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'insert',
        \ '<S-Down>',
        \ '<denite:assign_next_matched_text>',
        \ 'noremap'
        \)

  " Change matchers.
  call denite#custom#source(
        \ 'file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
  call denite#custom#source(
        \ 'file/rec', 'matchers', ['matcher_cpsm'])

  " Change sorters.
  call denite#custom#source(
        \ 'file/rec', 'sorters', ['sorter_sublime'])


  " Define alias
  call denite#custom#alias('source', 'file/rec/git', 'file/rec')
  call denite#custom#var('file/rec/git', 'command',
        \ ['git', 'ls-files', '-co', '--exclude-standard'])

  " Change default prompt
  " call denite#custom#option('default', 'prompt', '>')

  " Change ignore_globs
  call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
        \ [ '.git/', '.ropeproject/', '__pycache__/',
        \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])
endif

if executable('rg')
  let unite_ignores = ["!CMakeFiles",
        \"!*.dSYM",
        \"!*.dat",
        \"!*.pdf",
        \"!*.bib"]
  let unite_globs = []
  for ig in unite_ignores
    call add(unite_globs, "--glob '" . ig . "'")
  endfor
  " Use rg in unite grep source.
  let g:unite_source_grep_command = 'rg'
  let g:unite_source_grep_default_opts = ' --smart-case -n --no-heading --color never --no-messages ' .
        \ join(unite_globs) . ' -e '
  let g:unite_source_grep_separator = "" "avoid having unite add '--' where it doesn't go
  let g:unite_source_grep_recursive_opt = ''
  " The empty perens set the pattern, all files should match
  let unite_globs2 = []
  for ig in unite_ignores
    call add(unite_globs2, '--glob')
    call add(unite_globs2, ig)
  endfor
  let g:unite_source_rec_async_command = ['rg', '--color', 'never', '--no-heading', '--files'] + unite_globs2
elseif executable('pt')
  " Use pt in unite grep source.
  " https://github.com/monochromegane/the_platinum_searcher
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = ' --smart-case --nogroup --nocolor ' .
        \ '--ignore ''*.dat'' --ignore ''*.pdf'' --ignore ''*.bib'' -e '
  let g:unite_source_grep_recursive_opt = ''
  " The empty perens set the pattern, all files should match
  let g:unite_source_rec_async_command = ['pt', '--nocolor', '--nogroup', '-g', ".", ""]
elseif executable('ag')
  " Use ag in unite grep source.
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
        \ '--line-numbers --nocolor --nogroup --hidden ' .
        \ '--ignore ''CMakeFiles'' ' .
        \ '--ignore ''*.dat'' --ignore ''*.pdf'' --ignore ''build*''  '
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_rec_async_command = ['ag', '-i', '--nocolor', '--nogroup', '--ignore', 'build*', '--ignore', '.git', '--ignore', '.bzr', '--ignore', 'node_modules', '--hidden', '-g', ""]
else
  let g:unite_source_rec_find_args = ['-path', '*/.git/*', '-prune', '-o', '-path', '*/build*/*', '-prune', '-o', '-print']
endif


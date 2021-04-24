"YouCompleteMe
nnoremap <leader>yg :YcmCompleter GoTo<CR>
nnoremap <leader>yG :YcmCompleter GoToImprecise<CR>
nnoremap <leader>yf :YcmCompleter FixIt<CR>
nnoremap <leader>yt :YcmCompleter GetType<CR>
nnoremap <leader>yp :YcmCompleter GetParent<CR>
nnoremap <leader>yd :YcmCompleter GetDoc<CR>

let g:ycm_semantic_triggers =  {
      \ 'c' : ['_'],
      \ 'vim' : ['_'],
      \}
let g:ycm_complete_in_strings = 1
let g:ycm_extra_conf_vim_data=['&filetype']
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist = ['~/Dropbox/*','~/projects/*','~/Projects/*']
let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_key_invoke_completion = '<C-S-Space>'
let g:ycm_key_invoke_completion = '<C-Space>'
" let g:ycm_key_invoke_completion = '<Tab>'
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>', '<Tab>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>', '<S-Tab>']
let g:ycm_min_num_of_chars_for_completion = 99
let g:ycm_min_num_identifier_candidate_chars = 99



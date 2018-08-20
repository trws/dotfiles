function! ExportColors(scheme_name, ...)

    " Save registers we will use
    let l:a=@a


    redir @a
    silent! hi
    redir END
    new

    " paste in the results of the :hi command, and process it into
    " valid :hi ... commands
    normal gg"ap
    silent! %s/\(\w*\)\s*xxx\s*links to \(\w*\)/hi link \1 \2/ge
    silent! %s/\(\w*\)\s*\(\w*\)\s*cleared/hi clear \1/ge
    silent! %s/\(\w*\)\s*xxx\s*\(.*\)/hi \1 \2/ge

    " Write the colorscheme preamble
    normal gg
    if a:0 > 0
        let @a = a:1
    else
        let @a = "dark"
    endif
    normal iset background="apa
    normal ihi clear
    normal iif exists("syntax_on")
    normal i    syntax reset
    normal iendif

    let @a=a:scheme_name
    normal ilet g:colors_name=""apa"

    " Restore registers we used
    let @a = l:a

endfunction

command! -nargs=+ ExportColors call ExportColors(<q-args>)

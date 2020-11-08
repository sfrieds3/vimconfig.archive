if exists('g:loaded_whitespace')
    finish
endif
let g:loaded_whitespace = 1

" returns an extranous 0...
function! whitespace#StripTrailingWhitespace() range
    if !&binary && &filetype != 'diff'
        execute "redir => numclean"
        silent! execute "%s/\\s\\+$//en"
        execute "redir END"
        silent! call preserve#Preserve(":%s/\\s\\+$//e")
        execute "echo numclean"
    endif
endfunction

if exists('g:loaded_gitgrep')
    finish
endif
let g:loaded_gitgrep = 1

function! gitgrep#GitGrep(...)
    " store grepprg to restore after running
    let save = &grepprg
    " set grepprg to git grep for use in function
    set grepprg=git\ grep\ -n\ $*
    let s = 'grep!'
    let s = 'silent ' . s
    for i in a:000
        let s = s . ' ' . i
    endfor
    let s = s . ' | copen'
    execute s
    " restore grepprg to original setting
    let &grepprg = save
endfunction

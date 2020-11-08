if exists('g:loaded_lnum')
    finish
endif
let g:loaded_lnum = 1

function! lnum#ToggleLineNum()
    if &number || &relativenumber
        set nonumber
        set norelativenumber
    else
        set number
        set relativenumber
    endif
endfunction


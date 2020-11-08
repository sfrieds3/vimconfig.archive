if exists('g:loaded_buftab')
    finish
endif
let g:loaded_buftab = 1

function! buftag#BuffNext(arg)
    :bnext
endfunction
function! buftag#BuffPrev(arg)
    :bprevious
endfunction
function! buftag#TabNext(arg)
    :tabnext
endfunction
function! buftag#TabPrev(arg)
    :tabprevious
endfunction

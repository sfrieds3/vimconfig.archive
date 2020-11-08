if exists('g:loaded_buftab')
    finish
endif
let g:loaded_buftab = 1

function! buftab#BuffNext(arg)
    :bnext
endfunction
function! buftab#BuffPrev(arg)
    :bprevious
endfunction
function! buftab#TabNext(arg)
    :tabnext
endfunction
function! buftab#TabPrev(arg)
    :tabprevious
endfunction

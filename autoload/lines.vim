if exists('g:loaded_lines')
    finish
endif
let g:loaded_lines = 1

function! lines#MoveLineUp(arg)
    execute ":.m-2<CR>"
endfunction

function! lines#MoveLineDown(arg)
    execute ":.m+1<CR>"
endfunction

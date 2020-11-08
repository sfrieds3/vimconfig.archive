if exists('g:loaded_lists')
    finish
endif
let g:loaded_lists = 1

" these are hacked together and likely could be improved...
function! lists#CNext(arg)
    try
        :cnext
    catch /E553:/
        :cc
    catch /E42:/
        echo "No quickfix errors!"
    endtry
endfunction
function! lists#CPrevious(arg)
    try
        :cprevious
    catch /E553:/
        :cc
    catch /E42:/
        echo "No quickfix errors!"
    endtry
endfunction
function! lists#LNext(arg) abort
    try
        :lnext
    catch /E553:/
        :ll
    catch /E42:/
        echo "No location list errors!"
    endtry
endfunction
function! lists#LPrevious(arg) abort
    try
        :lprevious
    catch /E553:/
        :ll
    catch /E42:/
        echo "No location list errors!"
    endtry
endfunction

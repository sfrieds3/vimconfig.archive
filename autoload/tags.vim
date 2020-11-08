if exists('g:loaded_tags')
    finish
endif
let g:loaded_tags = 1

function! tags#GenerateTags()
    :! ctags -R
endfunction

if exists('g:loaded_highlights')
    finish
endif
let g:loaded_highlights = 1

function! highlights#MyHighlights() abort
    if g:colors_name == 'apprentice'
        highlight Comment ctermfg=242
    highlight Todo cterm=reverse ctermbg=226 ctermfg=235
    endif
    if g:colors_name == 'flattened_dark'
        highlight Todo term=NONE cterm=reverse ctermfg=8 ctermbg=226
    endif
endfunction

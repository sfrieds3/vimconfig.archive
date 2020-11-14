if exists('g:loaded_highlights')
    finish
endif
let g:loaded_highlights = 1

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

function! highlights#MyHighlights() abort
    if exists('g:colors_name') && g:colors_name ==# 'apprentice'
        highlight Comment ctermfg=242
        highlight Todo cterm=reverse ctermbg=226 ctermfg=235
    endif
    if exists('g:colors_name') && g:colors_name ==# 'lucius'
        LuciusDark
    endif
    if exists('g:colors_name') && g:colors_name ==# 'gooddog'
        "set cursorline
    endif
endfunction

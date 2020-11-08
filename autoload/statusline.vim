if exists('g:loaded_statusline')
    finish
endif
let g:loaded_statusline = 1

function! statusline#StatusLineBuffNum()
    let bnum = expand(bufnr('%'))
    return printf("[%d]\ ", bnum)
endfunction

function! statusline#StatusLineFileName()
    let fname = '' != expand('%:t') ? printf("%s\ ", expand('%:f')) : '[No Name] '
    return printf("%s", fname)
endfunction

function! statusline#StatusLineFiletype()
    return (strlen(&filetype) ? printf("(%s)", &filetype) : '(no ft)')
endfunction

function! statusline#StatusLineFormat()
    return winwidth(0) > 160 ? printf("%s | %s", &ff, &fenc) : ''
endfunction

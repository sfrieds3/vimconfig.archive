setlocal shiftwidth=4 softtabstop=4 tabstop=4

nnoremap <buffer> K :silent execute ':help ' . expand('<cword>')<CR>

setlocal foldmethod=manual

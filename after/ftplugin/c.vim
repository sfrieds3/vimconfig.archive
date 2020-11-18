if executable('clang')
    setlocal makeprg=clang
else
    setlocal makeprg=gcc
endif

"let &l:errorformat="%f:%l:%c:\ %t%s:\ %m"

nnoremap <buffer> \<Space><Space> :FSHere<CR>
nnoremap <buffer> \<Space>h :FSSplitLeft<CR>
nnoremap <buffer> \<Space>j :FSSplitBelow<CR>
nnoremap <buffer> \<Space>k :FSSplitAbove<CR>
nnoremap <buffer> \<Space>l :FSSplitRight<CR>

setlocal shiftwidth=8 softtabstop=8 tabstop=8
setlocal foldmethod=syntax
setlocal nofoldenable

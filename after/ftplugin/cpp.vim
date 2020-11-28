setlocal suffixesadd=.h

setlocal shiftwidth=4 softtabstop=4 tabstop=4
setlocal foldmethod=syntax
setlocal nofoldenable

nnoremap <buffer> \<Space><Space> :FSHere<CR>
nnoremap <buffer> \<Space>h :FSSplitLeft<CR>
nnoremap <buffer> \<Space>j :FSSplitBelow<CR>
nnoremap <buffer> \<Space>k :FSSplitAbove<CR>
nnoremap <buffer> \<Space>l :FSSplitRight<CR>

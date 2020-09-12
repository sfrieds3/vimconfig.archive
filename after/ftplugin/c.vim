if executable('clang')
    setlocal makeprg=clang
else
    setlocal makeprg=gcc
endif

" TODO: this doesn't work entirely..
let &l:errorformat="%f:%l:%c:\ %t%s:\ %m"

setlocal shiftwidth=8 softtabstop=8 tabstop=8
setlocal foldmethod=syntax
setlocal nofoldenable

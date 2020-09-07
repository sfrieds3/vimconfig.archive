if executable('clang')
    setlocal makeprg=clang
else
    setlocal makeprg=gcc
endif

setlocal shiftwidth=8 softtabstop=8 tabstop=8

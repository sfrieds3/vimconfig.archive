if executable('clang')
    set makeprg=clang
else
    set makeprg=gcc
endif

setlocal shiftwidth=8 softtabstop=8 tabstop=8

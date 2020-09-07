setlocal shiftwidth=2 softtabstop=2 tabstop=2

if exists("g:scala_makeprg")
    let &l:makeprg=expand(g:scala_makeprg)
else
    let &l:makeprg=sbt
endif

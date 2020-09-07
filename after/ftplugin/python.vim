function! PythonFuncGrep()
    exec("vimgrep /def /j %")
    exec("copen")
endfunction

setlocal shiftwidth=4 softtabstop=4 tabstop=4 foldmethod=indent

" open quickfix with list of functions
nnoremap <silent> \f call PythonFuncGrep()

if exists("g:py_formatprg")
    let &l:formatprg=expand(g:py_formatprg)
else
    let &l:formatprg=autopep8\ -
endif

if exists("g:py_makeprg")
    let &l:makeprg=expand(g:py_makeprg)
else
    let &l:makeprg=pylint\ --output-format=parseable
endif

if exists("g:py_equalprg")
    let &l:equalprg=expand(g:py_equalprg)
else
    let &l:equalprg=pylint\ --output-format=parseable
endif

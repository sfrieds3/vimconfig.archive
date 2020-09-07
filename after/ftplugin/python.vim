function! PythonFuncGrep()
    exec("vimgrep /def /j %")
    exec("copen")
endfunction

setlocal shiftwidth=4 softtabstop=4 tabstop=4 foldmethod=indent

" open quickfix with list of functions
nnoremap <silent> \f call PythonFuncGrep()

if exists("g:py_dir")
    setlocal formatprg=expand(g:py_dir) . 'autopep8\ -'
    setlocal makeprg=expand(g:py_dir) . 'pylint\ --output-format=parseable'
else
    setlocal formatprg=autopep8\ -
    setlocal makeprg=pylint\ --output-format=parseable
endif

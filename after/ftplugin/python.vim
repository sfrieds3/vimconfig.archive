function! PythonFuncGrep()
    exec("vimgrep /def /j %")
    exec("copen")
endfunction

setlocal shiftwidth=4 softtabstop=4 tabstop=4

" open quickfix with list of functions
nnoremap <silent> \f call PythonFuncGrep()

if executable('autopep8')
    "autopep8 on gq, if available
    setlocal formatprg=autopep8\ -
endif

if executable('pylint')
    setlocal makeprg=pylint\ --output-format=parseable
endif

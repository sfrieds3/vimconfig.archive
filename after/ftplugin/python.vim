function! PythonFuncGrep()
    exec("vimgrep /def /j %")
    exec("copen")
endfunction

setlocal shiftwidth=4 softtabstop=4 tabstop=4

" open quickfix with list of functions
nnoremap <silent> \f call PythonFuncGrep()

setlocal formatprg=/home/scwfri/.local/bin/autopep8\ -

setlocal makeprg=/home/scwfri/.local/bin/pylint\ --output-format=parseable

setlocal foldmethod=indent

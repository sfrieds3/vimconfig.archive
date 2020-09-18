setlocal shiftwidth=4 softtabstop=4 tabstop=4 foldmethod=indent nofoldenable

function! PythonFuncGrep() abort
    exec("vimgrep /def /j %")
    exec("copen")
endfunction

" open quickfix with list of functions
nnoremap <buffer> <silent> \f call PythonFuncGrep()

if exists("g:py_formatprg")
    let &l:formatprg=expand(g:py_formatprg)
else
    let &l:formatprg=autopep8\ -
endif

if exists("g:py_makeprg")
    let &l:makeprg=expand(g:py_makeprg)
else
    let &l:makeprg=pycodestyle
endif

" pylint
let &l:errorformat^="%A%f:%l:\ %m,%C,%Z%m"
" pep8/pycodestyle
let &l:errorformat^="%f:%l:%c:\ %m"

let g:python_highlight_space_errors = 0

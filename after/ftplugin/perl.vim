" do not include ':' as part of word
set iskeyword-=:

" if perltidy available, use that for formatting
if executable('perltidy')
    setlocal equalprg=perltidy\ -st
endif

" settings for vim-perl
let perl_include_pod = 1
let perl_no_scope_in_variables = 0
let perl_no_extended_vars = 0

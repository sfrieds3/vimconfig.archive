" vim settings {{{

" local settings {{{
" load local pre vimrc settings
runtime! local_pre.vim
" }}}

" plugins {{{

"use pathogen if not on vim8, otherwise use vim8 packages
if filereadable(glob('$HOME/.vim/autoload/pathogen.vim')) && v:version < 800
    execute pathogen#infect('pack/bundle/start/{}')
    execute pathogen#infect('pack/bundle/opt/{}')
    execute pathogen#helptags()
endif

" }}}

" colorscheme {{{

set t_Co=256
set t_ut=
set background=dark

augroup CustomizeTheme
    autocmd!
    autocmd ColorScheme * call highlights#MyHighlights()
augroup END

colorscheme lucius
LuciusDark

" }}}

" initial settings {{{

" basic settings {{{
filetype plugin indent on

set hidden
set autoread
set nomodeline
set ignorecase
set smartcase
set showmatch
set splitbelow
set splitright
set autoindent
set incsearch
set hlsearch

" indentation
set shiftwidth=4
let softtabstop = &shiftwidth
set tabstop=4
set shiftround
set expandtab
set smarttab
" commands for adjusting indentation rules manually
command! -nargs=1 Spaces let b:wv = winsaveview() | execute "setlocal tabstop=" . <args> . " expandtab"   | silent execute "%!expand -it "  . <args> . "" | call winrestview(b:wv) | setlocal ts? sw? sts? et?
command! -nargs=1 Tabs   let b:wv = winsaveview() | execute "setlocal tabstop=" . <args> . " noexpandtab" | silent execute "%!unexpand -t " . <args> . "" | call winrestview(b:wv) | setlocal ts? sw? sts? et?

" other setting stuff
set laststatus=2
set backspace=indent,eol,start
set encoding=utf8
set fileencoding=utf8
set showtabline=3
set clipboard^=unnamed,unnamedplus
set foldmethod=marker
set foldcolumn=0
set formatoptions=qrn1j
set showbreak=↪

" timeout on key codes but not on mappings
set notimeout
set ttimeout
set ttimeoutlen=10

" }}}

let mapleader = "\\"
let maplocalleader = "_"

" enable syntax
if !exists("g:syntax_on")
    syntax enable
endif

set wildmenu
set wildignore+=*.pyc
set wildignorecase
set wildmode=list,full
set wildcharm=<C-z>

set tags=./tags;,tags;

" better completion
set omnifunc=syntaxcomplete#Complete
set complete+=d
set completeopt=longest,menuone,preview

" simple default path
set path+=.,,

" use matchit
runtime! macros/matchit.vim

" easy manpages with <leader>K or :Man <manpage>
runtime! ftplugin/man.vim

" open quickfix or location-list automatically when there is something to show
" source: https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
augroup AutoQuickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
augroup END

" }}}

" backup settings {{{

set undofile
set backup
set backupext=.bak
set noswapfile

" save lots of history
set viminfo='1000,f1,<500
set history=500

set undodir=~/.vim/tmp/undo// " undo files
set backupdir=~/.vim/tmp/backup// " backups

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif

" }}}

" statusline {{{
set laststatus=2

" format the statusline
set statusline=
set statusline+=%{statusline#StatusLineBuffNum()}
set statusline+=%<
set statusline+=%{statusline#StatusLineFileName()}
set statusline+=%m
set statusline+=%{statusline#StatusLineFiletype()}

" right section
set statusline+=%=
" file format
set statusline+=\ %{statusline#StatusLineFormat()}

" line number
set statusline+=\ [%l/%L
" column number
set statusline+=:%c
" % of file
set statusline+=\ %p%%]
" }}}

" tabline {{{
set tabline=%!tabline#Tabline()
" }}}

"}}}

" plugin config {{{

" ctrlp {{{
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_extensions = ['mixed', 'buffertag', 'tag', 'line', 'changes', 'undo', 'quickfix']
""}}}

" tagbar {{{
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:show_linenumbers = 1
nnoremap <Space>f :echo tagbar#currenttag('[%s]', '')<CR>
" }}}

" sneak {{{
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
" }}}

" undotree {{{
let g:undotree_WindowLayout = 2
nnoremap _U :exec("UndotreeToggle")<CR>
nnoremap <Space>u :exec("UndotreeFocus")<CR>

function! g:Undotree_CustomMap()
    nmap <buffer> K <plug>UndotreeNextState
    nmap <buffer> J <plug>UndotreePreviousState
    nmap <buffer> <Space>u q
    nmap <buffer> _U q
endfunction
" }}}

" linediff {{{
nnoremap <Bslash>db ggVG:LinediffAdd<CR><C-o><C-o>
nnoremap <Bslash>ds :LinediffShow<CR>
" }}}

" }}}

" functions {{{

" Append modeline after last line in buffer. {{{
nnoremap <silent> _ml :call modeline#AppendModeline()<CR>
" }}}

" gitgrep {{{
command! -nargs=+ GitGrep call gitgrep#GitGrep(<f-args>)
" }}}

" generate tags quickly {{{
command! Tags call tags#GenerateTags()
" }}}

" highlight interesting words {{{
nnoremap <silent> _1 :call hiwords#HiInterestingWord(1)<cr>
nnoremap <silent> _2 :call hiwords#HiInterestingWord(2)<cr>
nnoremap <silent> _3 :call hiwords#HiInterestingWord(3)<cr>
nnoremap <silent> _4 :call hiwords#HiInterestingWord(4)<cr>
nnoremap <silent> _5 :call hiwords#HiInterestingWord(5)<cr>
nnoremap <silent> _6 :call hiwords#HiInterestingWord(6)<cr>
" }}}

" trim trailing whitespace {{{
command! CleanWhitespace call echo whitespace#StripTrailingWhitespace()<CR>
nnoremap _W :echo whitespace#StripTrailingWhitespace()<CR>
" }}}

" line number management {{{
command! ToggleLineNum call lnum#ToggleLineNum()
nnoremap _n :call lnum#ToggleLineNum()<cr>
" }}}

" move lines {{{
nnoremap <silent> _j :set operatorfunc=lines#MoveLineUp<CR>g@<Space>
nnoremap <silent> _k :set operatorfunc=lines#MoveLineDown<CR>g@<Space>
" }}}

" show declaration {{{
" from https://gist.github.com/romainl/a11c6952f012f1dd32c26fad4fa82e43
nnoremap _d :call showdecl#ShowDeclaration(0)<CR>
nnoremap _D :call showdecl#ShowDeclaration(1)<CR>
" }}}

" substitute operator {{{
nmap <silent> _s  m':set operatorfunc=substitute#Substitute<CR>g@
" }}}

" Global <pattern> -> location list {{{
" original soure: https://gist.github.com/romainl/f7e2e506dc4d7827004e4994f1be2df6
set errorformat^=%f:%l:%c\ %m
" command! -nargs=1 Global lgetexpr filter(map(getline(1,'$'), {key, val -> expand("%") . ":" . (key + 1) . ":1 " . val }), { idx, val -> val =~ <q-args> })
command! -nargs=1 Global lgetexpr filter(map(getline(1,'$'), 'expand("%") . ":" . (v:key + 1) . ":1 " . v:val'), 'v:val =~ <q-args>') | lopen

nnoremap gsg :Global<Space>
" }}}

" cdo/cfdo if not available {{{
" from: https://www.reddit.com/r/vim/comments/iiatq6/is_there_a_good_way_to_do_vim_global_find_and/
if !exists(':cdo')
    command! -nargs=1 -complete=command Cdo try | sil cfirst |
                \ while 1 | exec <q-args> | sil cn | endwhile |
            \ catch /^Vim\%((\a\+)\)\=:E\%(553\|42\):/ |
            \ endtry

    command! -nargs=1 -complete=command Cfdo try | sil cfirst |
                \ while 1 | exec <q-args> | sil cnf | endwhile |
            \ catch /^Vim\%((\a\+)\)\=:E\%(553\|42\):/ |
            \ endtry
endif
" }}}

" buffer/tab switching {{{
nnoremap gb :set operatorfunc=buftab#BuffNext<CR>g@<Space>
nnoremap gB :set operatorfunc=buftab#BuffPrev<CR>g@<Space>
nnoremap gt :set operatorfunc=buftab#TabNext<CR>g@<Space>
nnoremap gT :set operatorfunc=buftab#TabPrev<CR>g@<Space>
" }}}

" quickfix / location list shortcuts {{{
nnoremap ]q :set operatorfunc=lists#CNext<CR>g@<Space>
nnoremap [q :set operatorfunc=lists#CPrevious<CR>g@<Space>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>
nnoremap _Q :cclose<CR>
nnoremap ]l :set operatorfunc=lists#LNext<CR>g@<Space>
nnoremap [l :set operatorfunc=lists#LPrevious<CR>g@<Space>
nnoremap [L :lfirst<CR>
nnoremap ]L :llast<CR>
nnoremap _L :lclose<CR>
" }}}

" diff from original file {{{
command! -nargs=? Diff call diff#Diff(<q-args>)
nnoremap <Bslash>dh :Diff HEAD<CR>
nnoremap <Bslash>dd :Diff<CR>
" }}}

" redir {{{
command! -nargs=1 -complete=command -bar -range Redir silent call redir#Redir(<q-args>, <range>, <line1>, <line2>)
" }}}

"}}}

" custom mappings and stuff {{{

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" easily switch windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" easy switch to prev buffer
nnoremap <BS> <C-^>

" default Y mapping is just.. wrong
nnoremap Y y$

" no Explore shortcut..
cabbrev E e

" insert current line into command line
if !has('patch-8.0.1787')
    cnoremap <C-r><C-l> <C-r>=getline('.')<CR>
endif

" \s toggles spell checking
nnoremap <Bslash>s :<C-U>setlocal spell! spell?<CR>

" git shortcuts
nnoremap <Bslash>gg :echo system('git branch && git status')<CR>
nnoremap <Bslash>gd :echo system('git diff ' . expand("%"))<CR>
nnoremap <Bslash>gD :!clear && git diff %<CR>

" poor man's c_CTRL-G/c_CTRL-T.. use c-j/c-k to move thru search res as typing
cnoremap <expr> <C-j> getcmdtype() =~ '[\/?]' ? "<CR>/<C-r>/" : "<C-j>"
cnoremap <expr> <C-k> getcmdtype() =~ '[\/?]' ? "<CR>?<C-r>/" : "<C-k>"

" ilist
nnoremap <Bslash>i :Ilist!<Space>
nnoremap gsi :Ilist! <C-r>=expand("<cword>")<CR><CR>

" ijump
nnoremap gsj :ijump! <C-r>=expand("<cword>")<CR><CR>

" quick jump to tag under curosr
nnoremap gst :tjump /<C-r>=expand("<cword>")<CR><CR>

" g search
nnoremap gsw :g//#<Left><Left>
nnoremap gsW :g/<C-r>=expand("<cword>")<CR>/#<CR>

" quick search and replace
" https://github.com/romainl/minivimrc/blob/master/vimrc
nnoremap _rp :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap _ra :%s/\<<C-r>=expand("<cword>")<CR>\>//c<Left><Left>

" :help include-search shortcuts
nnoremap <Space>p :<C-u>psearch <C-r><C-w><CR>
nnoremap <Space>i [<C-i>
nnoremap <Space>d [<C-d>

" echo current file full path
nnoremap _fp :echo expand("%:p")<cr>

" quick make to location list
nnoremap <F5> :lmake %<CR>

" view all todo in quickfix window
nnoremap <silent> _vt :exec("lvimgrep /todo/j %")<cr>:exec("lopen")<cr>

" vimgrep for word under cursor in current file and open in location list
nnoremap <silent> gr :exec("lvimgrep /".expand("<cword>")."/j %")<cr>:exec("lopen")<cr>

" vimgrep for word under cursor in current directory open in quickfix
nnoremap <silent> gR :exec("vimgrep /".expand("<cword>")."/j **/*")<cr>:exec("copen")<cr>

" Do and insert results of fancy math equations via python
" from https://github.com/alerque/que-vim/blob/master/.config/nvim/init.vim
command! -nargs=+ Calc :r! python3 -c 'from math import *; print (<args>)'

" show list of digraphs -- special symbols
nnoremap _vd :help digraphs<cr>:179<cr>zt

" \v shows all global variables
nnoremap <Bslash>v :<C-U>let g: v:<CR>
" \V shows all local variables
nnoremap <Bslash>V :<C-U>let b: t: w:<CR>

" \y shows all registers
nnoremap <Bslash>y :<C-U>registers<CR>

" search for non-ASCII characters
nnoremap _Va /[^\x00-\x7F]<CR>

" toggle line and column markers
nnoremap <silent> <Bslash>c :exec("set cursorcolumn!")<cr>
nnoremap <silent> <Bslash>r :exec("set cursorline!")<cr>

" upper case last word using ctrl+u
inoremap <C-u> <Esc>gUiwea

" Shift-Tab enters actual tab
inoremap <S-Tab> <C-v><Tab>

" stay where you are on * from fatih (http://www.github.com/fatih/dotfiles)
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" tagbar
nnoremap <silent> <Bslash><Bslash> :exec("TagbarOpen('j')")<cr>

" Disable highlight
nnoremap <silent> <space><cr> :nohlsearch<cr>

" Switch CWD to the directory of the open buffer
nnoremap _Cd :cd %:p:h<cr>:pwd<cr>

" netrw
nnoremap <leader>o :Sexplore!<cr>
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_winsize = 25

" terminal mode {{{
if has('terminal')
    " easy terminal exit
    tnoremap <esc> <C-\><C-n>
endif
" }}}

" easy editing {{{
nnoremap <Space>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <Space>es :source $MYVIMRC<cr> :echo "sourced"$MYVIMRC""<cr>
" }}}

" operator mappings {{{
onoremap p i(
onoremap in( :<C-u>normal! f(vi(<cr>
onoremap il( :<C-u>normal! F)vi(<cr>
" }}}

" }}}

" vim settings {{{

"use pathogen if not on vim8, otherwise use vim8 packages
if filereadable(glob('$HOME/.vim/autoload/pathogen.vim')) && v:version < 800
    execute pathogen#infect('pack/bundle/start/{}')
    execute pathogen#infect('pack/bundle/opt/{}')
    execute pathogen#helptags()
else
    " let vim8 handle packages; generate all helptags
    try | execute "helptags ALL" |
            \ catch /^Vim\%((\a\+)\)\=:E\%(151\|152\):/ |
            \ endtry
endif

" colorscheme {{{

set t_Co=256
set t_ut=
set background=dark

augroup CustomizeTheme
    autocmd!
    autocmd ColorScheme * call highlights#MyHighlights()
augroup END

colorscheme oasis

" }}}

" initial settings {{{

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
set nrformats-=octal
set showbreak=...
set listchars+=extends:>       " Unwrapped text to screen right
set listchars+=precedes:<      " Unwrapped text to screen left
set listchars+=tab:>-          " Tab characters, preserve width
set listchars+=trail:_         " Trailing spaces
silent! set listchars+=nbsp:+  " Non-breaking spaces

" allow moving beyond buffer text in visual block
if exists('+virtualedit')
  set virtualedit+=block
endif

" timeout on key codes but not on mappings
set notimeout
set ttimeout
set ttimeoutlen=10

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

" no ruler by default
if &ruler
  set noruler
endif

" }}}

" backup settings {{{

set undofile
set backup
set backupext=.bak
set noswapfile

" save lots of history
set viminfo='1000,f1,<500
set history=5000

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
" statusline only if more than one buffer
if &laststatus != 1
  set laststatus=1
endif

" toggle statusline
command! ToggleStatusline call statusline#ToggleStatusline()
nnoremap _S :<C-u>:call statusline#ToggleStatusline()<CR>

" toggle ruler
nnoremap _N :<C-u>set ruler! ruler?<CR>
if exists(':xnoremap')
  xnoremap _N :<C-u>set ruler! ruler?<CR>gv
endif

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
let g:ctrlp_match_window = 'results:100'
""}}}

" tagbar {{{
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:show_linenumbers = 1
nnoremap \f :echo tagbar#currenttag('[%s]', '')<CR>
nnoremap <silent> \\ :exec("TagbarOpen('j')")<cr>
" }}}

" sneak {{{
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
" }}}

" undotree {{{
let g:undotree_WindowLayout = 2
nnoremap _u :exec("UndotreeToggle")<CR>
nnoremap \U :exec("UndotreeFocus")<CR>

function! g:Undotree_CustomMap()
    nmap <buffer> K <plug>UndotreeNextState
    nmap <buffer> J <plug>UndotreePreviousState
    nmap <buffer> \u q
endfunction
" }}}

" linediff {{{
nnoremap _da ggVG:LinediffAdd<CR><C-o><C-o>
nnoremap _ds :LinediffShow<CR>
" }}}

" }}}

" mappings {{{
" Some basics when it comes to mappings:
" 1) gs-prefix for jumping to result
" 2) \ for most other things
" 3) _ for <buffer> mappings

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" allow c-j/c-k for cycling through insert mode completions
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" easy switch to prev buffer
nnoremap <BS> <C-^>

" pages through current buffer, then through arglist
nnoremap <expr> <C-j>
            \ line('w$') < line('$')
            \ ? "\<PageDown>"
            \ : ":\<C-U>next\<CR>"
nnoremap <expr> <C-k>
            \ line('w0') > line('0')
            \ ? "\<PageUp>"
            \ : ":\<C-U>previous\<CR>"

" default Y mapping is just.. wrong
nnoremap Y y$

" insert current line into command line
if !has('patch-8.0.1787')
    cnoremap <C-r><C-l> <C-r>=getline('.')<CR>
endif

" buffer/tab switching
nnoremap gb :bnext<CR>
nnoremap gB :bprevious<CR>
nnoremap ]b :next<CR>
nnoremap [b :bprevious<CR>
nnoremap ]t :tabnext<CR>
nnoremap [t :tabprevious<CR>

" arglist / quickfix / location list shortcuts
nnoremap ]a :next<CR>
nnoremap [a :previous<CR>
nnoremap [A :first<CR>
nnoremap ]A :last<CR>
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>
nnoremap \q :cclose<CR>
nnoremap ]l :lnext<CR>
nnoremap [l :lprevious<CR>
nnoremap [L :lfirst<CR>
nnoremap ]L :llast<CR>
nnoremap \l :lclose<CR>

" Leader,{ and Leader,} move to top and bottom of indent region
nmap \{ <Plug>(VerticalRegionUp)
nmap \} <Plug>(VerticalRegionDown)
omap \{ <Plug>(VerticalRegionUp)
omap \} <Plug>(VerticalRegionDown)
if exists(':xmap')
  xmap \{ <Plug>(VerticalRegionUp)
  xmap \} <Plug>(VerticalRegionDown)
endif

" adjust indent of last edit
nnoremap \< :<C-U>'[,']<<CR>
nnoremap \> :<C-U>'[,']><CR>

" buffer jump list
nnoremap \j :buffers<CR>:b

" gitgrep
command! -nargs=+ GitGrep call gitgrep#GitGrep(<f-args>)

" highlight interesting words
nnoremap _1 :call hiwords#HiInterestingWord(1)<cr>
nnoremap _2 :call hiwords#HiInterestingWord(2)<cr>
nnoremap _3 :call hiwords#HiInterestingWord(3)<cr>
nnoremap _4 :call hiwords#HiInterestingWord(4)<cr>
nnoremap _5 :call hiwords#HiInterestingWord(5)<cr>
nnoremap _6 :call hiwords#HiInterestingWord(6)<cr>

" trim trailing whitespace
nnoremap \w :call whitespace#StripTrailingWhitespace()<CR>

" toggle list
nnoremap _L :<C-U>setlocal list! list?<CR>
if exists(':xnoremap')
  xnoremap _L :<C-U>setlocal list! list?<CR>gv
endif

" line number management
command! ToggleLineNum call lnum#ToggleLineNum()
nnoremap _n :call lnum#ToggleLineNum()<cr>

" show declaration
" from https://gist.github.com/romainl/a11c6952f012f1dd32c26fad4fa82e43
nnoremap \d :call showdecl#ShowDeclaration(0)<CR>
nnoremap \D :call showdecl#ShowDeclaration(1)<CR>

" substitute operator
nmap <silent> \s  m':set operatorfunc=substitute#Substitute<CR>g@

" Global <pattern> -> location list
" original soure: https://gist.github.com/romainl/f7e2e506dc4d7827004e4994f1be2df6
set errorformat^=%f:%l:%c\ %m
" command! -nargs=1 Global lgetexpr filter(map(getline(1,'$'), {key, val -> expand("%") . ":" . (key + 1) . ":1 " . val }), { idx, val -> val =~ <q-args> })
command! -nargs=1 Global lgetexpr filter(map(getline(1,'$'), 'expand("%") . ":" . (v:key + 1) . ":1 " . v:val'), 'v:val =~ <q-args>') | lopen
nnoremap gsg :Global<Space>
nnoremap <Space> :Global<Space>

" cdo/cfdo if not available
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

" redir
command! -nargs=1 -complete=command -bar -range Redir silent call redir#Redir(<q-args>, <range>, <line1>, <line2>)

" toggle paste mode and enter insert mode
nnoremap _p :set paste! paste?<CR>i
" just toggle paste..
nnoremap _P :set paste! paste?<CR>

" toggle spell checking
nnoremap _s :<C-u>setlocal spell! spell?<CR>

" echo filetype
nnoremap _t :<C-u>set filetype?<CR>

" reload filetype plugins
nnoremap _T :<C-u>doautocmd filetypedetect BufRead<CR>

" echo current file full path
nnoremap _f :echo expand("%:p")<cr>

" git and diff shortcuts
nnoremap _gg :echo system('git branch && git status')<CR>
nnoremap _gd :echo system('git diff ' . expand("%"))<CR>
nnoremap _gD :!clear && git diff %<CR>
command! -nargs=? Diff call diff#Diff(<q-args>)
nnoremap _dh :Diff HEAD<CR>
nnoremap _dd :Diff<CR>

" quick shell command
nnoremap _! :!<Space>

" show all registers
nnoremap \y :<C-u>registers<CR>
" show marks
nnoremap \k :<C-u>marks<CR> 
" command history
nnoremap \H :<C-u>history :<CR>
nnoremap \h q:
" search history
nnoremap \/ q/

" toggle showing tab, end-of-line, and trailing whitespace
nnoremap _l :<C-u>setlocal list! list?<CR>
if exists(':xnoremap')
  xnoremap _l :<C-u>setlocal list! list?<CR>gv
endif

" normal maps
nnoremap _m :<C-u>map<CR>
" buffer-local normal maps
nnoremap _M :<C-u>map <buffer><CR>
" show global variables
nnoremap _v :<C-u>let g: v:<CR>
" show local variables
nnoremap _V :<C-u>let b: t: w:<CR>

" echo current highlight
nnoremap _h :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>

" toggle line and column markers
nnoremap \c :set cursorline! cursorline?<cr>
nnoremap \C :set cursorcolumn! cursorcolumn?<cr>

" Switch CWD to the directory of the open buffer
nnoremap _Cd :cd %:p:h<cr>:pwd<cr>

" open scratch buffers
nnoremap \~ :<C-U>ScratchBuffer<CR>
nnoremap \` :<C-U>vertical ScratchBuffer<CR>

" search for non-ASCII characters
nnoremap \a /[^\x00-\x7F]<CR>

" poor man's c_CTRL-G/c_CTRL-T.. use c-j/c-k to move thru search res as typing
cnoremap <expr> <C-j> getcmdtype() =~ '[\/?]' ? "<CR>/<C-r>/" : "<C-j>"
cnoremap <expr> <C-k> getcmdtype() =~ '[\/?]' ? "<CR>?<C-r>/" : "<C-k>"

" ilist
nnoremap \i :Ilist!<Space>
nnoremap \I :Ilist! <C-r>=expand("<cword>")<CR><CR>

" ijump
nnoremap gsj :ijump! <C-r>=expand("<cword>")<CR><CR>

" quick jump to tag under curosr
nnoremap gst :tjump /<C-r>=expand("<cword>")<CR><CR>

" g search
nnoremap \gw :g//#<Left><Left>
nnoremap \gW :g/<C-r>=expand("<cword>")<CR>/#<CR>

" quick search and replace
" https://github.com/romainl/minivimrc/blob/master/vimrc
nnoremap \rp :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap \ra :%s/\<<C-r>=expand("<cword>")<CR>\>//c<Left><Left>

" :help include-search shortcuts
nnoremap gsp :<C-u>psearch <C-r><C-w><CR>
nnoremap gsi [<C-i>
nnoremap gsd [<C-d>

" quick make to location list
nnoremap <F5> :lmake %<CR>

" view all todo in quickfix window
nnoremap <silent> \vt :exec("lvimgrep /todo/j %")<cr>:exec("lopen")<cr>

" vimgrep for word under cursor in current file and open in location list
nnoremap <silent> gr :exec("lvimgrep /".expand("<cword>")."/j %")<cr>:exec("lopen")<cr>

" vimgrep for word under cursor in current directory open in quickfix
nnoremap <silent> gR :exec("vimgrep /".expand("<cword>")."/j **/*")<cr>:exec("copen")<cr>

" Do and insert results of fancy math equations via python
" from https://github.com/alerque/que-vim/blob/master/.config/nvim/init.vim
command! -nargs=+ Calc :r! python3 -c 'from math import *; print (<args>)'

" show list of digraphs -- special symbols
nnoremap \vd :help digraphs<cr>:179<cr>zt

" upper case last word using ctrl+u
inoremap <C-u> <Esc>gUiwea

" Shift-Tab enters actual tab
inoremap <S-Tab> <C-v><Tab>

" stay where you are on * from fatih (http://www.github.com/fatih/dotfiles)
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Disable highlight
nnoremap <C-l> :nohlsearch<cr>

if has('terminal')
    " easy terminal exit
    tnoremap <esc> <C-\><C-n>
endif

nnoremap \ev :vsplit $MYVIMRC<cr>
nnoremap \es :source $MYVIMRC<cr> :echo "sourced"$MYVIMRC""<cr>

" operator mappings {{{
onoremap p i(
onoremap in( :<C-u>normal! f(vi(<cr>
onoremap il( :<C-u>normal! F)vi(<cr>
" last changed text as an object
onoremap \_ :<C-U>execute 'normal! `[v`]'<CR>
" }}}

" }}}

" Source any .vim files from ~/.vim/config {{{
runtime! config/*.vim
" }}}

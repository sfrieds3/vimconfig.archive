" vim settings {{{

" plugins {{{

if filereadable(glob('$HOME/.vim/autoload/pathogen.vim'))
  " always load these plugins
  execute pathogen#infect('bundle/all/{}')
  execute pathogen#infect('bundle/colors/{}')

  " put test plugins in $HOME/.vim/plugtest and they will be autoloaded
  if isdirectory(glob('$HOME/.vim/plugtest'))
    execute pathogen#infect('plugtest/{}')
  endif

  " load nvim specific plugins
  if has('nvim') && isdirectory(glob('$HOME/.vim/bundle/nvim'))
    execute pathogen#infect('bundle/nvim/{}')
  else
    execute pathogen#infect('bundle/vim/{}')
  endif

  augroup pload
    autocmd!

    autocmd FileType python execute pathogen#infect('bundle/python/{}')
    autocmd FileType perl execute pathogen#infect('bundle/perl/{}')
    autocmd FileType ruby,eruby execute pathogen#infect('bundle/ruby/{}')
    autocmd FileType lisp execute pathogen#infect('bundle/lisp/{}')

    " generate helptags
    autocmd FileType * execute pathogen#helptags()
  augroup END
endif

" }}}

" nvim/vim specific settings {{{

if has('nvim')
  set termguicolors
  set inccommand=split

  augroup HighlightOnYank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup END

  " exit terminal with esc
  tnoremap <esc> <C-\><C-n>
else
  set nocompatible
  set t_Co=256

  " :h xterm-true-color
  let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
  let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"

  if v:version > 800
    "set termguicolors
    " exit terminal with esc
    tnoremap <esc> <C-\><C-n>
  endif
endif

" }}}

" colorscheme {{{

" customizations for codedark colorscheme {{{
highlight IncSearch term=reverse ctermbg=24 cterm=undercurl
highlight Search term=reverse ctermbg=24 cterm=undercurl

" }}}

" gruvbox {{{
let g:gruvbox_contrast_dark = 'hard'
let g:gitgutter_override_sign_column_highlight = 1
" }}}

" gruvbox-material {{{
let g:gruvbox_material_background = 'hard'
" }}}

set background=dark
colorscheme paramount

highlight Todo ctermbg=226 ctermfg=52

" }}}

" initial settings {{{

" basic settings {{{
set showcmd
set autoread
set modeline
set ignorecase
set smartcase
set showmatch
set splitbelow
set splitright
set autoindent
set expandtab
set smarttab
set wrap
set incsearch
set showmatch
set hlsearch
set nonumber
set novisualbell
set magic

set laststatus=2
set backspace=2
set matchtime=3
set encoding=utf8
set tabstop=4
set shiftwidth=4
set softtabstop=4
set showtabline=3
set clipboard=unnamed
set foldmethod=marker
set foldcolumn=0
set formatoptions=qrn1j

" }}}

" space as leader, unmap it from normal and select-mode
nnoremap <space> <nop>
let mapleader = "\<space>"
let maplocalleader = "\\"

" enable syntax
if !exists("g:syntax_on")
  syntax enable
endif

filetype plugin on
filetype indent on

set wildmenu
set wildignorecase
set wildmode=list:longest,full
set omnifunc=syntaxcomplete#Complete
set ttyfast

" better completion
set complete=.,w,b,u,t,i
set completeopt=longest,menuone

" pwd is path
set path=,,

" do not close hidden buffers
set hidden

" set lines above/below cursor
set scrolloff=0

" timeout on key codes but not mappings
" for terminal vim
set notimeout
set ttimeout
set ttimeoutlen=10

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" }}}

" backup settings {{{

set undofile
set backup
set noswapfile
set undodir=~/.vim/tmp/undo// " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap// " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

" }}}

" sessions {{{

let g:session_dir = '~/.vim/vim-session'

if !isdirectory(expand(g:session_dir))
  call mkdir(expand(g:session_dir), "p")
endif

" }}}

" statusline {{{

set laststatus=2

function! StatusLineBuffNum()
  let bnum = expand(bufnr('%'))
  return printf("[%d]", bnum)
endfunction

function! StatusLineFiletype()
  return winwidth(0) > 160 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! StatusLineFormat()
  return winwidth(0) > 160 ? printf("%s | %s", &ff, &fenc) : ''
endfunction

function! StatusLineFileName()
  let fname = '' != expand('%:f') ? expand('%:f') : '[No Name]'
  return printf("%s", fname)
endfunction

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf(' [+%d ~%d -%d]', a, m, r)
endfunction

" format the statusline
set statusline=
set statusline+=%{StatusLineBuffNum()}
set statusline+=\ %{StatusLineFileName()}
set statusline+=%m
" git changes from vim-signify
set statusline+=\%{GitStatus()}
" syntastic status
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" right section
set statusline+=%=
" current function
set statusline+=%{tagbar#currenttag('[%s]','')}
" file format
set statusline+=\ %{StatusLineFormat()}
" file type
set statusline+=\ %{StatusLineFiletype()}
" line number
set statusline+=\ [%l:
" column number
set statusline+=%c
" % of file
set statusline+=\ %p%%]

" }}}

" tabline {{{

" a lot of this taken from https://github.com/mkitt/tabline.vim
" with a few slight tweaks
function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")
    let gstatus = expand(fugitive#statusline())
    let ostatus = expand(ObsessionStatus())

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab .':'
    let s .= (bufname != '' ? '['. fnamemodify(bufname, ':t') . ']' : '[No Name]')

    if bufmodified
      let s .= '[+] '
    endif
  endfor

  let s .= '%#TabLineFill#'
  if (exists("g:tablineclosebutton"))
    let s .= '%=%999XX'
  endif

  " right align this portion
  let s .= '%=%'
  let s .= (tab == tabpagenr() ? printf('[%s%s', gstatus, ostatus) : '')
  return s
endfunction

set tabline=%!Tabline()

" }}}

"}}}

" plugin config {{{

" gitgutter {{{

let g:gitgutter_set_sign_backgrounds = 1

" }}}

" tagbar {{{

let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:show_linenumbers = 1

" }}}

" jedi {{{
let g:jedi#show_call_signatures = 1
let g:jedi#auto_close_doc = 1

" }}}

" vlime {{{

let g:vlime_cl_use_terminal = 1

" }}}

" syntastic {{{

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

" set syntastic checkers
let g:syntastic_json_checkers=['jsonlint', 'jsonval']
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl', 'perlcritic', 'podchecker']
let g:syntastic_python_checkers = ['pylint', 'pep8', 'python', 'pyflakes']
let g:syntastic_ruby_checkers=['mri', 'rubocop']
let g:syntastic_sh_checkers=['sh','shellcheck','checkbashisms']
let g:syntastic_vim_checkers=['vimlint']
let g:syntastic_yaml_checkers=['jsyaml']

" custom checker location
"let g:syntastic_python_pylint_exec = $HOME . '/anaconda3/bin/pylint'

" }}}

" ale {{{
"let g:ale_completion_enabled = 1
"set omnifunc=ale#completion#OmniFunc
"
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_insert_leave = 0
"let g:ale_lint_on_enter = 0
"
"" and use a simpler warning
"let g:ale_sign_warning = '∘'
"" set erorr sign
"let g:ale_sign_error = '●'
"
"" update error msg
"let g:ale_echo_msg_error_str = 'E'
"let g:ale_echo_msg_warning_str = 'W'
"let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"
"" ignore annoying erorrs
"let g:ale_python_flake8_options = '--ignore=E501'
"
"let g:ale_linters = {
"      \   'python': ['flake8', 'pylint', 'mypy'],
"      \   'perl': ['perlcritic']
"      \}

" }}}

" undotree {{{

let g:undotree_WindowLayout = 2
nnoremap U :exec("UndotreeToggle")<cr>

" }}}

" obsession {{{

function! MakeSession()
  ":Obsession g:session_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
  let s = 'Obsession'
  execute s
endfunction
nnoremap <Leader>ss :call MakeSession()<cr>

function! RestoreSession()
  :source ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>
endfunction
nnoremap <Leader>sr :call RestoreSession()<cr>

" freeze session
nnoremap <Leader>sf :Obsession<CR>
 
" }}}

" }}}

" general language settings {{{

augroup lang
  autocmd!

  autocmd FileType c,go setlocal shiftwidth=8 softtabstop=8 tabstop=8
  autocmd FileType python setlocal shiftwidth=4 softtabstop=4 tabstop=4
  autocmd FileType vim,perl,ruby,eruby,html setlocal shiftwidth=2 softtabstop=2 tabstop=2

augroup END

" python {{{
augroup python
  autocmd!
  " open quickfix with list of functions
  nnoremap <silent> <localleader>f :exec("vimgrep /def /j %")<cr> :exec("copen")<cr>

  if executable('autopep8')
    "autopep8 on gq, if available
    autocmd FileType python setlocal formatprg=autopep8\ -
  endif
augroup END
" }}}

" {{{ HTML
iabbrev </ </<C-X><C-O>
imap <C-Space> <C-X><C-O>
" }}}

" markdown {{{

" some versions of vim think .md means modula2 source code..
" thats not right, so fix it here
" this really should go in ~/.vim/ftdetect/markdown.vim
" but I'm too lazy
augroup markdown
  autocmd!
  autocmd BufNewFile,BufRead *.md set filetype=markdown
augroup END

" }}}

" perl {{{

augroup perl
  autocmd!
  " do not include ':' as part of word
  autocmd FileType perl set iskeyword-=:

  " if perltidy available, use that for formatting
  if executable('perltidy')
    autocmd FileType perl setlocal equalprg=perltidy\ -st
  endif
augroup END

" settings for vim-perl
let perl_include_pod = 1
let perl_no_scope_in_variables = 0
let perl_no_extended_vars = 0

" }}}

" ruby {{{

if has('ruby')
  let g:rubycomplete_buffer_loading = 1
  let g:rubycomplete_classes_in_global = 1
  let g:rubycomplete_rails = 1
endif

" }}}

" }}}

" functions {{{

" Append modeline after last line in buffer. {{{
" from https://vim.fandom.com/wiki/Modeline_magic
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d fdm=%s %set:",
        \ &tabstop, &shiftwidth, &textwidth, &foldmethod, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <localleader>ml :call AppendModeline()<CR>

" }}}

" pretty format xml {{{
" https://vim.fandom.com/wiki/Pretty-formatting_XML
" use vat to select tags and inside
" vit to select data inside tag
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
" }}}}

" quick way to open quickfix window {{{
function! OpenQuickfix()
  :copen
endfunction
command! C call OpenQuickfix()
nnoremap <leader>q :call OpenQuickfix()<cr>
" }}}

" use ctrl-s to vimgrep and open uesults in quickfix window {{{
function! FindAll()
  call inputsave()
  let p = input('Enter pattern:')
  call inputrestore()
  execute 'vimgrep! "'.p.'" % | copen'
endfunction
"nnoremap <leader>s :call FindAll()<cr>
"nnoremap <leader>S :call FindAll()<cr><cword><cr>
" }}}

" gitgrep {{{
function! GitGrep(...)
    " store grepprg to restore after running
    let save = &grepprg
    " set grepprg to git grep for use in function
    set grepprg=git\ grep\ -n\ $*
    let s = 'grep!'
    let s = 'silent ' . s
    for i in a:000
        let s = s . ' ' . i
    endfor
    let s = s . ' | copen'
    execute s
    " restore grepprg to original setting
    let &grepprg = save
endfunction
command! -nargs=+ GitGrep call GitGrep(<f-args>)
" }}}

" git grep for word under cursor {{{
function! GitGrepWord()
    normal! "zyiw
    call GitGrep('-w -e ', getreg('z'))
endfunction
nnoremap <C-x>G :call GitGrepWord()<cr>
" }}}

" generate tags quickly {{{
function! GenerateTags()
    :! ctags -R
endfunction
command! T call GenerateTags()
" }}}

" verbose debugging {{{

function! ToggleVerbose()
  if !&verbose
    set verbosefile=~/.vim/log/verbose.log
    set verbose=15
  else
    set verbose=0
    set verbosefile=
  endif
endfunction

" }}}

" highlight interesting words {{{

" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.

" credit: https://github.com/paulirish/dotfiles/blob/master/.vimrc

function! HiInterestingWord(n) " {{{
  " Save our location.
  normal! mz

  " Yank the current word into the z register.
  normal! "zyiw

  " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
  let mid = 86750 + a:n

  " Clear existing matches, but don't worry if they don't exist.
  silent! call matchdelete(mid)

  " Construct a literal pattern that has to match at boundaries.
  let pat = '\V\<' . escape(@z, '\') . '\>'

  " Actually match the words.
  call matchadd("InterestingWord" . a:n, pat, 1, mid)

  " Move back to our original location.
  normal! `z
endfunction " }}}

" Mappings {{{
nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>
" }}}

" Default Highlights {{{
hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195
" }}}
" }}}

"}}}

" custom mappings and stuff {{{

" echo current file full path
nnoremap <leader>fp :echo expand("%:p")<cr>

" view all todo in quickfix window
nnoremap <silent> <leader>vt :exec("lvimgrep /todo/j %")<cr>:exec("lopen")<cr>

" vimgrep for word under cursor in current file and open in quickfix
nnoremap <silent> gr :exec("lvimgrep /".expand("<cword>")."/j %")<cr>:exec("lopen")<cr>

" vimgrep for word under cursor in current directory open in quickfix
nnoremap <silent> gR :exec("vimgrep /".expand("<cword>")."/j **/*")<cr>:exec("copen")<cr>

" Do and insert results of fancy math equations via python
" from https://github.com/alerque/que-vim/blob/master/.config/nvim/init.vim
:command! -nargs=+ Calc :r! python -c 'from math import *; print (<args>)'

" various command shortcuts
cnoreabbrev f find
cnoreabbrev F find
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev B b
cnoreabbrev E e

" auto center when going to prev/next function definition
nnoremap [[ [[zz
nnoremap ]] ]]zz

" show list of digraphs -- special symbols
nnoremap <leader>vd :help digraphs<cr>:179<cr>zt

" toggle line and column markers
nnoremap <silent> <localleader>c :exec("set cursorcolumn!")<cr>
nnoremap <silent> <localleader>r :exec("set cursorline!")<cr>

" upper case last word using ctrl+u
inoremap <C-u> <esc>mzgUiw`za

" Shift-Tab enters actual tab
inoremap <S-Tab> <C-v><Tab>

" stay where you are on * from fatih (http://www.github.com/fatih/dotfiles)
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" move line of text up/down
nnoremap <C-Down> mz:m+<cr>`z
nnoremap <C-Up> mz:m-2<cr>`z
vnoremap <C-Down> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <C-Up> :m'<-2<cr>`>my`<mzgv`yo`z

" tagbar
nnoremap <silent> <localleader><localleader> :exec("TagbarOpen('j')")<cr>

" use sane regex (source: https://bitbucket.org/sjl/dotfiles/src/default/vim/vimrc)
nnoremap / /\v
vnoremap / /\v

" toggle line numbers
nnoremap <silent> <Leader>n :set invnumber!<cr>
"nnoremap <silent> <Leader>N :set relativenumber!<cr>

" show avilable marks and be ready to swtich
nnoremap <leader>M :<C-u>marks<cr>:normal! `

" show buffers and be ready to switch
nnoremap <silent> <localleader>bb :<C-u>:buffers<cr>:buffer<space>

" Disable highlight
nnoremap <silent> <leader><cr> :nohlsearch<cr>

" higlight whitespace, but do not highlight in insert mode
"highlight ExtraWhitespace ctermbg=red guibg=red
"match ExtraWhitespace /\s\+$/
"augroup hiwhitespace
"  autocmd!
"  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"  autocmd BufWinLeave * call clearmatches()
"augroup END

" Clean trailing whitespace
nnoremap <silent> <leader>W mz:%s/\s\+$//<cr>:let @/=''<cr>`z :exec("echo \"Cleaned Whitespace..\"")<cr>

" Switch CWD to the directory of the open buffer
nnoremap <leader>Cd :cd %:p:h<cr>:pwd<cr>

" resize splits when window is resized
augroup resize
  autocmd!
  autocmd VimResized * :wincmd =
augroup END

" netrw
nnoremap <Leader>o :Sexplore!<cr>

let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_winsize = 25

" highlighting under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" terminal mode {{{
" easily get into terminal normal mode
if has('terminal')
  tnoremap <esc> <C-w>N
endif
" }}}

" easy editing {{{
nnoremap <leader><space>ev :vsplit ~/.vimrc<cr>
nnoremap <silent> <leader><space>es :source ~/.vimrc<cr> :echo "sourced ~/.vimrc"<cr>
" }}}

" operator mappings {{{
onoremap p i(
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
" }}}

" }}}

" moving around, tabs, windows and buffers {{{

" windows {{{
" Smart way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <leader>ww <C-w>w
nmap <leader>w <C-W>

" resize splits
" 10<c-w><
" 10<c-w>>
" 10<c-w>-
" 10<c-w>+

" }}}

" buffers and tabs {{{
" tab and buffer management
nnoremap <leader>bp :bprevious<cr>
nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bd :bdelete<cr>
nnoremap <C-left> :bprevios<cr>
nnoremap <C-right> :bnext<cr>
nnoremap <leader>tp :tabprevious<cr>
nnoremap <leader>tn :tabnext<cr>
nnoremap <leader>tt :tabnext<cr>
nnoremap <C-left> :tabprevious<cr>
nnoremap <C-right> :tabnext<cr>

" Useful mappings for managing tabs
nnoremap <leader>tN :tabnew<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>th :-tabmove<cr>
nnoremap <leader>tl :+tabmove<cr>

" }}}

"}}}

" notes {{{

" :helpgrep <text> - grep for <text> in all help docs
" :cn :cp to go to next or previous result from :helpgrep
" Tags:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

"}}}
" vim: set ts=2 sw=2 tw=78 fdm=marker et:

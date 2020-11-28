" File: hickop.vim
" Version: 1.3
" Author: hickop <hickop@gmail.com>
" Description: simple dark colorscheme for vim and gvim

hi clear

set background=dark

if exists("syntax_on")
    syntax reset
endif

let g:colors_name="hickop"

set t_Co=256

"colors{{{
"let s:gui_black="#262626"
"let s:gui_white="#c6c6c6"
"let s:gui_gray1="#6c6c6c"
"let s:gui_gray2="#303030"
"let s:gui_red="#af5f5f"
"let s:gui_green="#87af87"
"let s:gui_brown="#af875f"
"let s:gui_yellow="#d7af5f"
"let s:gui_purple="#af5f87"
"let s:gui_blue="#5f87af"
"let s:gui_cyan="#87afd7"

"let s:cterm_black="235"
"let s:cterm_white="251"
"let s:cterm_gray1="242"
"let s:cterm_gray2="236"
"let s:cterm_red="131"
"let s:cterm_green="108"
"let s:cterm_brown="137"
"let s:cterm_yellow="179"
"let s:cterm_purple="132"
"let s:cterm_blue="67"
"let s:cterm_cyan="110"
"}}}

"gui
hi Normal           guifg=#c6c6c6   guibg=#262626

hi NonText          guifg=#6c6c6c                   gui=NONE
hi ErrorMsg         guifg=#af5f5f   guibg=bg
hi IncSearch        guifg=bg        guibg=fg        gui=NONE
hi Search           guifg=bg        guibg=#af875f
hi MoreMsg          guifg=fg                        gui=NONE
hi LineNr           guifg=#6c6c6c   guibg=#303030
hi CursorLineNr     guifg=fg        guibg=#303030
hi Question         guifg=fg                        gui=NONE
hi StatusLine       guifg=fg        guibg=#303030   gui=NONE
hi StatusLineNC     guifg=#6c6c6c   guibg=#303030   gui=NONE
hi VertSplit        guifg=#303030   guibg=#303030   gui=NONE
hi Title            guifg=fg                        gui=NONE
hi Visual           guifg=bg        guibg=fg
hi WarningMsg       guifg=fg                        gui=NONE
hi WildMenu         guifg=bg        guibg=#af875f
hi Folded           guifg=#6c6c6c   guibg=#303030
hi FoldColumn       guifg=#6c6c6c   guibg=#303030
hi DiffAdd          guifg=bg        guibg=#87af87
hi DiffChange       guifg=bg        guibg=#5f87af
hi DiffDelete       guifg=#af5f5f   guibg=#af5f5f   gui=NONE
hi DiffText         guifg=bg        guibg=#87afd7   gui=NONE
hi SignColumn       guifg=fg        guibg=bg
hi Pmenu            guifg=bg        guibg=#6c6c6c
hi PmenuSel         guifg=fg        guibg=#6c6c6c
hi PmenuSbar                        guibg=#6c6c6c
hi PmenuThumb       guifg=fg
hi TabLine          guifg=#6c6c6c   guibg=#303030   gui=NONE
hi TabLineSel       guifg=fg        guibg=bg        gui=NONE
hi TabLineFill      guifg=bg        guibg=#303030   gui=NONE
hi CursorLine                       guibg=#303030   gui=NONE
hi ColorColumn                      guibg=#303030   gui=NONE

hi MatchParen       guifg=bg        guibg=#af875f
hi Comment          guifg=#6c6c6c
hi Constant         guifg=#af5f87
hi Error            guifg=fg        guibg=#af5f5f
hi Identifier       guifg=#87afd7                   gui=NONE
hi PreProc          guifg=#5f87af                   gui=NONE
hi Special          guifg=#d7af5f
hi SpecialKey       guifg=#6c6c6c
hi Statement        guifg=#af875f                   gui=NONE
hi Todo             guifg=bg        guibg=#af875f
hi Type             guifg=#87af87                   gui=NONE

"cterm
hi Normal           ctermfg=251     ctermbg=235

hi NonText          ctermfg=242                     cterm=NONE
hi ErrorMsg         ctermfg=131     ctermbg=bg
hi IncSearch        ctermfg=bg      ctermbg=fg      cterm=NONE
hi Search           ctermfg=bg      ctermbg=137
hi MoreMsg          ctermfg=fg                      cterm=NONE
hi LineNr           ctermfg=242     ctermbg=236
hi CursorLineNr     ctermfg=fg      ctermbg=236
hi Question         ctermfg=fg                      cterm=NONE
hi StatusLine       ctermfg=fg      ctermbg=236     cterm=NONE
hi StatusLineNC     ctermfg=242     ctermbg=236     cterm=NONE
hi VertSplit        ctermfg=236     ctermbg=236     cterm=NONE
hi Title            ctermfg=fg                      cterm=NONE
hi Visual           ctermfg=bg      ctermbg=fg
hi WarningMsg       ctermfg=fg                      cterm=NONE
hi WildMenu         ctermfg=bg      ctermbg=137
hi Folded           ctermfg=242     ctermbg=236
hi FoldColumn       ctermfg=242     ctermbg=236
hi DiffAdd          ctermfg=bg      ctermbg=108
hi DiffChange       ctermfg=bg      ctermbg=67
hi DiffDelete       ctermfg=131     ctermbg=131     cterm=NONE
hi DiffText         ctermfg=bg      ctermbg=110     cterm=NONE
hi SignColumn       ctermfg=fg      ctermbg=bg
hi Pmenu            ctermfg=bg      ctermbg=242
hi PmenuSel         ctermfg=fg      ctermbg=242
hi PmenuSbar                        ctermbg=242
hi PmenuThumb       ctermfg=fg
hi TabLine          ctermfg=242     ctermbg=236     cterm=NONE
hi TabLineSel       ctermfg=fg      ctermbg=bg      cterm=NONE
hi TabLineFill      ctermfg=bg      ctermbg=236     cterm=NONE
hi CursorLine                       ctermbg=236     cterm=NONE
hi ColorColumn                      ctermbg=236     cterm=NONE

hi MatchParen       ctermfg=bg      ctermbg=137
hi Comment          ctermfg=242
hi Constant         ctermfg=132
hi Error            ctermfg=fg      ctermbg=131
hi Identifier       ctermfg=110                     cterm=NONE
hi PreProc          ctermfg=67                      cterm=NONE
hi Special          ctermfg=179
hi SpecialKey       ctermfg=242
hi Statement        ctermfg=137                     cterm=NONE
hi Todo             ctermfg=bg      ctermbg=137
hi Type             ctermfg=108                     cterm=NONE


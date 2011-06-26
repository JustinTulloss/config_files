" Vim indent file
" Language: Bujagali HTML Template
" Maintainer: Brian Ferrell
" Last Change: 2011 May 18

if exists("b:did_indent")
  finish
endif

let b:did_indent = 1

setlocal autoindent
setlocal indentexpr=GetBujagaliIndent(v:lnum)
" Only define the function once
if exists("*GetBujagaliIndent")
  finish
endif

function! GetBujagaliIndent()
  " TODO add some indent logic
endfunction

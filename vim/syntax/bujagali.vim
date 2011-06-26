" Vim syntax file
" Language: Bujagali HTML Template
" Maintainer: Brian Ferrell
" Last Change: 2011 May 18

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'html'
endif

if version < 600
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

if version < 508
  command! -nargs=+ BujHiLink hi link <args>
else
  command! -nargs=+ BujHiLink hi def link <args>
endif

syn keyword bujagaliCommentTodo TODO FIXME XXX TBD contained

syn match   bujagaliImport   "#.*$" display

syn cluster bujagaliBlocks add=bujagaliTagBlock,bujagaliVarBlock,bujagaliComBlock

syn region  bujagaliTagBlock start="{%" keepend end="%}" contains=@htmlJavaScript display containedin=ALLBUT,@bujagaliBlocks
syn region  bujagaliVarBlock start="{{" keepend end="}}" contains=@htmlJavaScript display containedin=ALLBUT,@bujagaliBlocks
syn region  bujagaliComBlock start="{#" end="#}" contains=bujagaliCommentTodo

BujHiLink bujagaliCommentTodo    Todo
BujHiLink bujagaliComBlock       Comment
BujHiLink bujagaliImport         Include

delcommand BujHiLink

let b:current_syntax = "bujagali"

" Vim ftplugin file
" Language: Bujagali HTML Template
" Maintainer: Brian Ferrell
" Last Change: 2011 May 18

if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

" TODO these are copied from another ftplugin and don't make sense here
" what *does* make sense here?

setlocal formatoptions-=t formatoptions+=croql
setlocal comments=:#
setlocal commentstring=#\ %s

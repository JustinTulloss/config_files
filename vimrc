" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set nowritebackup
set history=50    " keep 50 lines of command line history
set ruler    " show the cursor position all the time
set showcmd    " display incomplete commands
set incsearch    " do incremental searching
set exrc " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files
set clipboard=unnamed " share clipboard with the system
set encoding=utf-8

filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off

call plug#begin('~/.vim/plugged')
" install vim plugs
if filereadable(expand("~/.vimrc.plugs"))
  source ~/.vimrc.plugs
endif
call plug#end()

" Don't use Ex mode, use Q for formatting
map Q gq

" Make sure we're recognizing 256 color terminals
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

set tabstop=4
set shiftwidth=2
set smartindent
set smarttab

filetype plugin indent on

if has("folding")
  set nofoldenable
endif

map <silent><C-,> :bn
map <silent><C-.> :bp
map <silent><C-/> :b#

set hidden

" \ is the leader character
let mapleader = "\\"

" Hide search highlighting
map <Leader>h :set invhls <CR>

" NERD Tree
map <Leader>ls :NERDTreeToggle <CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
" map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Set debugging
map <Leader>p Iimport pdb;pdb.set_trace()<CR><ESC>

map <Leader>d Idebugger;<CR><ESC>

" Semantic gd with golang
au FileType go nmap gd <Plug>(go-def)

" Go rename variable
au FileType go nmap <Leader>n <Plug>(go-rename)

" Open up go definitions in different splits
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

" Go tools
au FileType go nmap <Leader>gr <Plug>(go-run)
au FileType go nmap <Leader>gb <Plug>(go-build)
au FileType go nmap <Leader>gt <Plug>(go-test)
au FileType go nmap <Leader>gc <Plug>(go-coverage)

" Go docs in a browser
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

" Interface inspection
au FileType go nmap <Leader>s <Plug>(go-implements)

" Type inspection
au FileType go nmap <Leader>i <Plug>(go-info)

let g:go_fmt_command = "goimports"

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Maps autocomplete to tab
imap <C-Tab> <C-N>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" No Help, please
nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Numbers
set number
set numberwidth=5

" case only matters with mixed case expressions
set ignorecase
set smartcase


"less highlighting
au BufNewFile,BufRead *.less set filetype=less

" Color scheme
colorscheme vividchalk
highlight NonText guibg=#060606

" Highlight everything that overflows 80 chars
highlight OverLength ctermbg=red ctermfg=white guibg=#FCA08D
au FileType markdown highlight OverLength none
match OverLength /\%81v.*/

set laststatus=2

" show a navigable menu for tab completion
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc,*.pyc
set wildmenu
set wildmode=longest,list,full

"Use locally installed flow if available
let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
    let local_flow= getcwd() . "/" . local_flow
endif
if executable(local_flow)
  let g:syntastic_javascript_flow_exe = local_flow
endif

" let g:syntastic_go_checkers = []
let g:syntastic_javascript_checkers = ['flow', 'eslint']

" Disable flow on save, since syntastic will do that
let g:flow#enable = 0

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --nogroup --column'

  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Use ripgrep
if executable('rg')
  let g:ackprg = 'rg --vimgrep'

  " Use rg over ag
  set grepprg=rg\ --vimgrep
endif

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if (!has('nvim') && exists('$TMUX')) " Support resizing in tmux
  set ttymouse=xterm2
endif

" NeoComplete config
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

"ale config
let g:ale_fixers = {
  \  'javascript': ['eslint'],
\}

let g:ale_fix_on_save = 1

" Tagbar config for go
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


" FZF config
set rtp+=/usr/local/bin/fzf
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <c-p> :FZF<cr>

" Do jsx highlighting even on .js files
let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1

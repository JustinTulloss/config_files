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
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" install Vundle bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" Make sure we're recognizing 256 color terminals
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

" Softtabs, 4 spaces by default, but let language indent prefs override below
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd BufReadPost * :DetectIndent
    :let g:detectindent_preferred_expandtab = 1
    :let g:detectindent_preferred_indent = 4
  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")

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

" Ctrlp shortcuts
" https://github.com/kien/ctrlp.vim
map <Leader>t :CtrlP <CR>

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

" For Haml
au! BufRead,BufNewFile *.haml         setfiletype haml

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
match OverLength /\%81v.*/

" Powerline setup
"set rtp+=./powerline/powerline/bindings/vim
set laststatus=2

" show a navigable menu for tab completion
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc,*.pyc
set wildmenu
set wildmode=longest,list,full

" YouCompleteMe configuration
set completeopt=menuone
let g:ycm_add_preview_to_completeopt = 0

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

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif

" Utilisnips expand on carriage return 
" Taken from https://github.com/Valloric/YouCompleteMe/issues/420#issuecomment-55940039
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"


" Window size
set winwidth=85
let g:halfsize = 86
let g:fullsize = 171
set lines=41
let &columns = g:halfsize

" Font
"set guifont=Monaco:h15.00 "Mac
set guifont=Courier\ 10\ Pitch\ Bold\ 12 "Linux

" No toolbar
set guioptions-=T

" Use console dialogs
set guioptions+=c

" Color scheme
colorscheme vividchalk
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

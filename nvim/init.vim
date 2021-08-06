set number
set tabstop=2
set sts=2
set expandtab
set shiftwidth=2
set hlsearch
set incsearch
set encoding=utf-8
set guifont=Mononoki\ Regular\ 12

" Key mappings
noremap <SPACE> <Nop>
let mapleader = " "
let g:pymode_python = 'python3'
" Yank to system clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p
" H and L by default move the cursor to top and bottom of buffer
noremap H 0
noremap L $
" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Move cursor and screen with JK
noremap K <C-u> 
noremap J <C-d>

syntax on
colorscheme desert
let python_highlight_all=1 " Mark bad whitespaces 

" JS, HTML, CSS indenting
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

" Python indenting
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set smartindent |
    \ set fileformat=unix



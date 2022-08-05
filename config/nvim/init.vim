call plug#begin("~/.vim/plugged")

Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'https://github.com/ycm-core/YouCompleteMe.git'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'rust-lang/rust.vim'
Plug 'vim-syntastic/syntastic'
" Plug 'frazrepo/vim-rainbow'
Plug 'tpope/vim-surround'
Plug 'ludovicchabant/vim-gutentags'

call plug#end()

" runtime! archlinux.vim
let g:python3_host_prog = '/usr/bin/python'

syntax on

set noerrorbells
set clipboard+=unnamedplus
set number
set incsearch
set shiftwidth=4
set tabstop=4
set smartindent
set nowrap
set expandtab
set laststatus=2
set cursorline
set colorcolumn=80
set undodir=$HOME/.vim/undodir
set undofile
set nohls
set mouse=a

" language specific tab widths etc
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype cpp setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype c setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype make setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype rust setlocal keywordprg=rusty-man colorcolumn=100


autocmd VimEnter * hi Normal ctermbg=none

autocmd VimEnter * hi TrailingWhitespace ctermbg=red guibg=red
" autocmd VimEnter * call matchadd("TrailingWhitespace", '\v\s+$')



" colorscheme shit
let g:airline_theme='angr'
" let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:gruvbox_transparent_bg = 1
set background=dark
colorscheme gruvbox

"au FileType c,cpp,rust call rainbow#load()

if executable('rg')
    let g:rg_derive_root='true'
endif

let mapleader = " "
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader><TAB> :bn<CR>
nnoremap <leader><S-TAB> :bp<CR>
" indent with only one arrow
nnoremap < <<
nnoremap > >>
" keep visual mode when inventing
vnoremap < <gv
vnoremap > >gv
" tab selecting
map <leader>1 :b 1<CR>
map <leader>2 :b 2<CR>
map <leader>3 :b 3<CR>
map <leader>4 :b 4<CR>
map <leader>5 :b 5<CR>
map <leader>6 :b 6<CR>
" paragraph jumping
map <C-k> {
map <C-j> }

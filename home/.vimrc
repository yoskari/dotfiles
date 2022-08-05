" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1"


syntax on

set noerrorbells
set clipboard=unnamedplus
set number
set incsearch
set shiftwidth=4
set tabstop=4
set smartindent
set nowrap
set expandtab
set laststatus=2
set cursorline
set colorcolumn=100
set undodir=$HOME/.vim/undodir
set undofile

autocmd VimEnter * hi Normal ctermbg=none

autocmd VimEnter * hi TrailingWhitespace ctermbg=red guibg=red
autocmd VimEnter * call matchadd("TrailingWhitespace", '\v\s+$')

" colorscheme shit "
let g:airline_theme='base16'
let g:gruvbox_transparent_bg = 1
set background=dark
colorscheme gruvbox

call plug#begin("~/.vim/plugged")

Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'git@github.com:Valloric/YouCompleteMe.git'"
Plug 'jremmen/vim-ripgrep'

call plug#end()

if executable('rg')
    let g:rg_derive_root='true'
endif

let mapleader = " "
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader><TAB> :bn<CR>
nnoremap <leader><S-TAB> :bp<CR>

call plug#begin("~/.vim/plugged")

Plug 'morhetz/gruvbox'
"Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
"Plug 'https://github.com/ycm-core/YouCompleteMe.git'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' },
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'patstockwell/vim-monokai-tasty'
Plug 'rust-lang/rust.vim'
"Plug 'vim-syntastic/syntastic'
" Plug 'frazrepo/vim-rainbow'
Plug 'tpope/vim-surround'
Plug 'ludovicchabant/vim-gutentags'
Plug 'justinmk/vim-syntax-extra'
Plug 'ravishi/vim-gnu-c'
Plug 'farmergreg/vim-lastplace'
Plug 'https://github.com/de-vri-es/vim-urscript'
Plug 'LnL7/vim-nix'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" runtime! archlinux.vim
let g:python3_host_prog = '/usr/bin/python'

syntax on

set noerrorbells
set clipboard+=unnamedplus
set number
set incsearch
set shiftwidth=2
set tabstop=2
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
"set autochdir
set autoindent
set hls

" language specific tab widths etc
autocmd VimEnter * autocmd Filetype python setlocal autoindent expandtab textwidth=80 tabstop=4 shiftwidth=4 softtabstop=4
autocmd VimEnter * autocmd Filetype urscript setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd VimEnter * autocmd Filetype cpp setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd VimEnter * autocmd Filetype yacc setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd VimEnter * autocmd Filetype htmldjango setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd VimEnter * autocmd Filetype html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd VimEnter * autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd VimEnter * autocmd Filetype svelte setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd VimEnter * autocmd Filetype c setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd VimEnter * autocmd Filetype go setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd VimEnter * autocmd Filetype make setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd VimEnter * autocmd Filetype rust setlocal keywordprg=rusty-man colorcolumn=100
au BufReadPost *.lox set syntax=javascript
au BufReadPost *.qss set syntax=css
" au BufReadPost *.ec set syntax=rust
" au BufReadPost *.e set syntax=javascript expandtab tabstop=2 shiftwidth=2 softtabstop=2

" autocmd VimEnter * hi Normal ctermbg=none

autocmd VimEnter * hi TrailingWhitespace ctermbg=red guibg=red
" autocmd VimEnter * call matchadd("TrailingWhitespace", '\v\s+$')

" colorscheme shit
" let g:airline_theme='catppuccin'
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:gruvbox_transparent_bg = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
" disable YCM error checking
let g:ycm_show_diagnostics_ui = 0
colorscheme gruvbox

"au FileType c,cpp,rust call rainbow#load()

if executable('rg')
    let g:rg_derive_root='true'
endif

let mapleader = " "
nnoremap <esc> :noh<CR><esc>
nnoremap <leader>f :Files<CR>
nnoremap <leader>d :bd<CR>
nnoremap <leader><TAB> :bn<CR>
nnoremap <leader><S-TAB> :bp<CR>
" indent with only one arrow
nnoremap < <<
nnoremap > >>
nnoremap n nzz
nnoremap N Nzz
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

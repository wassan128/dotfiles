syntax on

" minimum
set number
set ruler
set tabstop=4
set smartindent
set shiftwidth=4

" search
set incsearch
set hlsearch
set ignorecase
set smartcase

" display
set showmatch

" color
set background=dark
set t_Co=256

" customize
let mapleader="\<Space>"
"" reload vimrc
noremap <Leader>r :source ~/.vimrc<CR>:noh<CR>

" for vim-go
set autowrite

call plug#begin()
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
call plug#end()

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <Leader>a :cclose<CR>

autocmd FileType go nmap <Leader>b <Plug>(go-build)
autocmd FileType go nmap <Leader>r <Plug>(go-run)

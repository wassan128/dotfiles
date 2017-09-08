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
" dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/dein/dein.vim

" Required:
call dein#begin('~/.vim/dein')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')

call dein#add('scrooloose/nerdtree')
nnoremap :tree :NERDTree

" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif


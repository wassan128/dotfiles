" minimum
set encoding=utf-8
set number
set ruler
set tabstop=4
set expandtab
set smartindent
set autoindent
set shiftwidth=4
set backspace=indent,eol,start
set clipboard=unnamed,autoselect

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

" cache
set viminfo+=n~/.cache/vim/viminfo
set dir=~/.cache/vim/swap
set backup
set backupdir=~/.cache/vim/backup
set undofile
set undodir=~/.cache/vim/undo
for d in [&dir, &backupdir, &undodir]
	if !isdirectory(d)
		call mkdir(iconv(d, &encoding, &termencoding), "p")
	endif
endfor

" keymap
"" omni
imap <C-Space> <C-x><C-o>
"" window
nnoremap s <Nop>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap s> <C-w>>
nnoremap s< <C-w><
nnoremap s+ <C-w>+
nnoremap s- <C-w>-
"" line
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" settings for dein.vim
let s:dein_dir = expand("~/.cache/dein")
let s:dein_repo_dir = s:dein_dir."/repos/github.com/Shougo/dein.vim"

if &compatible
	set nocompatible
endif

if &runtimepath !~# "/dein.vim"
	if !isdirectory(s:dein_repo_dir)
		execute "!git clone https://github.com/Shougo/dein.vim" s:dein_repo_dir
	endif
	execute "set runtimepath^=".fnamemodify(s:dein_repo_dir, ":p")
endif

if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	let g:rc_dir = expand("~/.vim/rc")
	let s:toml = g:rc_dir."/dein.toml"

	call dein#load_toml(s:toml, {"lazy": 0})

	call dein#end()
	call dein#save_state()
endif

if dein#check_install()
	call dein#install()
endif

" settings for airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline_theme = 'raven'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" settings for indentLine
let g:indentLine_char = ":"

syntax enable


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

" completion
"" lsp settings
command RN LspRename
let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_smart_completion = 1
let g:asyncomplete_auto_popup = 1

"" omni
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
        \   if &omnifunc == "" |
        \           setlocal omnifunc=syntaxcomplete#Complete |
        \   endif
endif

"" golang
if executable('go-langserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'go-langserver',
        \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
        \ 'whitelist': ['go'],
        \ })
    autocmd BufWritePre *.go LspDocumentFormatSync
endif

" syntax check
"" ale
let g:ale_linters = {
\ 'javascript': ['eslint'],
\}
let g:ale_fixers = {
\ 'javascript': ['eslint'],
\}
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_echo_msg_error_str = '⨉'
let g:ale_echo_msg_warning_str = '⚠'
let g:ale_echo_msg_format = '%severity% %s [%linter%]'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_lint_on_text_changed = 0
let g:ale_open_list = 1
let g:ale_lint_on_enter = 0

" tabs
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2

nnoremap [Tag] <Nop>
nmap t [Tag]

for n in range(1, 9)
    execute 'nnoremap <silent> [Tag]'.n ':<C-u>tabnext'.n.'<CR>'
endfor

map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]x :tabclose<CR>
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]p :tabprevious<CR>

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
imap <C-x><C-x> <C-x><C-o>
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
"" highlight
nnoremap <silent> <Esc><Esc> :noh<CR>
"" vimgrep
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :<C-u>cfirst<CR>
nnoremap ]Q :<C-u>clast<CR>
"" lsp
nnoremap <C-b> :LspDefinition<CR>
nnoremap <C-h> :LspReferences<CR>

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
    let s:toml_lazy = g:rc_dir."/dein_lazy.toml"

    call dein#load_toml(s:toml, {"lazy": 0})
    call dein#load_toml(s:toml_lazy, {"lazy": 1})

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
let g:airline_theme = 'nord'

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

" settings for nerdtree
let NERDTreeWinSize=25
let NERDTreeShowHidden = 1
let g:nerdtree_tabs_open_on_console_startup=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-x><C-n> :NERDTreeTabsToggle<CR>

"" settings for nerdtree git
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "+",
    \ "Untracked" : "~",
    \ "Renamed"   : "*",
    \ "Unmerged"  : "!",
    \ "Deleted"   : "*",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

"" settings for vim-submode
call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

"" setings for vimshell
nnoremap <silent> vp :10sp<CR><C-w>r:VimShell<CR>

" color scheme
colorscheme nord

syntax enable


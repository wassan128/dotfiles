" keymap
"" omni
imap <C-x><C-x> <C-x><C-o>
"" window
nnoremap s <Nop>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sr <C-w>r
nnoremap sR <C-w>R
nnoremap sx <C-w>x
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
autocmd QuickFixCmdPost *grep* cwindow

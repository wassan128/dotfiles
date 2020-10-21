" settings for dein.vim
let s:dein_dir = expand("~/.nvim/cache/dein")
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

  let g:rc_dir = expand("~/.nvim/rc")
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

augroup vimrc
  autocmd!
augroup END

" settings for nerdtree
let NERDTreeWinSize=25
let NERDTreeShowHidden = 1
let g:nerdtree_tabs_open_on_console_startup=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-x><C-n> :NERDTreeTabsToggle<CR>

"" settings for nerdtree git
let g:NERDTreeGitStatusIndicatorMapCustom = {
  \ "Modified"  : "*",
  \ "Staged"  : "+",
  \ "Untracked" : "~",
  \ "Renamed"   : "*",
  \ "Unmerged"  : "!",
  \ "Deleted"   : "*",
  \ "Dirty"   : "✗",
  \ "Clean"   : "✔︎",
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

"" lsp
nnoremap <C-b> :vs<CR>:LspDefinition<CR>
nnoremap <C-h> :LspReferences<CR>
nnoremap <C-k> :LspHover<CR>
nnoremap <C-i> :LspImplementation<CR>
nnoremap <silent> ]e :LspNextError<CR>
nnoremap <silent> [e :LspPreviousError<CR>

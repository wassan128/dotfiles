" completion
"" lsp settings
command RN LspRename
command CA LspCodeAction
command WSS LspWorkspaceSymbol

let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_smart_completion = 1
let g:asyncomplete_auto_popup = 1

"" omni
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
    \ if &omnifunc == "" |
    \   setlocal omnifunc=syntaxcomplete#Complete |
    \ endif
endif

"" golang
if executable('go-langserver')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'go-langserver',
    \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
    \ 'whitelist': ['go'],
    \ })
  autocmd BufWritePre *.go LspDocumentFormatSync
  autocmd FileType go nnoremap <buffer><silent> K :<C-u>LspHover<CR>
endif

"" typescript
if executable('typescript-language-server')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'javascript support using typescript-language-server',
    \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
    \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
    \ 'whitelist': ['javascript', 'javascript.jsx', 'javascriptreact', 'typescript']
    \ })
endif

" syntax check
"" ale
let g:ale_linters = {
\ 'javascript': ['eslint'],
\}
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'javascript': ['eslint'],
\ 'css': ['prettier'],
\}
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1

let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_statusline_format = [' %d', ' %d', '⬥ ok']
let g:ale_echo_msg_error_str = ''
let g:ale_echo_msg_warning_str = ''
let g:ale_echo_msg_format = '%severity% %s [%linter%]'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_lint_on_text_changed = 0
let g:ale_open_list = 1
let g:ale_lint_on_enter = 0
highlight clear ALEErrorSign
highlight clear ALEWarningSign

" cache
set viminfo+=n~/.vim/cache/viminfo
set dir=~/.vim/cache/swap
set backup
set backupdir=~/.vim/cache/backup
set undofile
set undodir=~/.vim/cache/undo
for d in [&dir, &backupdir, &undodir]
  if !isdirectory(d)
    call mkdir(iconv(d, &encoding, &termencoding), "p")
  endif
endfor

"" lsp
nnoremap <C-b> :vs<CR>:LspDefinition<CR>
nnoremap <C-h> :LspReferences<CR>
nnoremap <C-k> :LspHover<CR>
nnoremap <C-i> :LspImplementation<CR>
nnoremap <silent> ]e :LspNextError<CR>
nnoremap <silent> [e :LspPreviousError<CR>

"" java
if executable('java') && filereadable(expand('~/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.300.v20190213-1655.jar'))
    au User lsp_setup call lsp#register_server({
        \ 'name': 'eclipse.jdt.ls',
        \ 'cmd': {server_info->[
        \     'java',
        \     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        \     '-Dosgi.bundles.defaultStartLevel=4',
        \     '-Declipse.product=org.eclipse.jdt.ls.core.product',
        \     '-Dlog.level=ALL',
        \     '-noverify',
        \     '-Dfile.encoding=UTF-8',
        \     '-Xmx1G',
        \     '-jar',
        \     expand('~/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.300.v20190213-1655.jar'),
        \     '-configuration',
        \     expand('~/lsp/eclipse.jdt.ls/config_win'),
        \     '-data',
        \     getcwd()
        \ ]},
        \ 'whitelist': ['java'],
        \ })
endif
let g:lsp_signs_error = {'text': ''}
let g:lsp_signs_warning = {'text': ''}
autocmd ColorScheme * highlight LspErrorText ctermfg=9
autocmd ColorScheme * highlight LspWarningText ctermfg=11
autocmd ColorScheme * highlight LspErrorHighlight ctermbg=NONE ctermfg=9

" settings for dein.vim
let s:dein_dir = expand("~/.vim/cache/dein")
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

"" setings for vimshell
nnoremap <silent> vp :10sp<CR><C-w>r:VimShell<CR>
nnoremap <silent> vs :VimShell<CR>

"" settings for change spaces
nnoremap <silent> ts2 :set tabstop=2<CR>:set shiftwidth=2<CR>
nnoremap <silent> ts4 :set tabstop=4<CR>:set shiftwidth=4<CR>

" color scheme
colorscheme nord

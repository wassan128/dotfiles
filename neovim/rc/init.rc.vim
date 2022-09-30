command RN LspRename

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

" cache
set viminfo+=n~/.nvim/cache/viminfo
set dir=~/.nvim/cache/swap
set backup
set backupdir=~/.nvim/cache/backup
set undofile
set undodir=~/.nvim/cache/undo
for d in [&dir, &backupdir, &undodir]
  if !isdirectory(d)
    call mkdir(iconv(d, &encoding, &termencoding), "p")
  endif
endfor

" settings for nerdtree
let NERDTreeWinSize=25
let NERDTreeShowHidden=1
let g:nerdtree_tabs_open_on_console_startup=0
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

autocmd! FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>L

"" lsp
nnoremap <C-b> :vs<CR>:LspDefinition<CR>
nnoremap <C-h> :LspReferences<CR>
nnoremap <C-k> :LspHover<CR>
nnoremap <C-i> :LspImplementation<CR>
nnoremap <silent> ]e :LspNextError<CR>
nnoremap <silent> [e :LspPreviousError<CR>
map <C-l> :LspNextError<CR>

"" setings for terminal emulator
nnoremap <silent> vp :10sp<CR><C-w>r:terminal<CR>:set nonumber<CR>i
nnoremap <silent> vm :tabnew<CR>:terminal<CR>:set nonumber<CR>i
nnoremap <silent> vr :50vs<CR><C-w>r:terminal<CR>:set nonumber<CR>i
nnoremap <silent> sn :set number<CR>
nnoremap <silent> sN :set nonumber<CR>
tnoremap <Esc> <C-\><C-n>

nnoremap <C-g> :GoImportRun<CR>

"" settings for debugger
autocmd FileType go nmap <silent> ;b :DlvToggleBreakpoint<CR>
autocmd FileType go nmap <silent> ;t :DlvToggleTracepoint<CR>
autocmd FileType go nmap <silent> ;c :DlvClearAll<CR>
autocmd FileType go nmap <silent> ;d :DlvDebug<CR>
let g:delve_breakpoint_sign="🔴"
let g:delve_breakpoint_sign_highlight=""
let g:delve_tracepoint_sign="🔷"
let g:delve_tracepoint_sign_highlight=""

set conceallevel=0
let g:vim_json_syntax_conceal=0

autocmd vimrc FileType go nnoremap <silent> gt :<C-u>silent call <SID>go_test_function()<CR>

function! s:go_test_function() abort
    let test_info = json_decode(system(printf('go-test-name -pos %s -file %s', s:cursor_byte_offset(), @%)))

    for b in nvim_list_bufs()
        if bufname(b) ==# 'vim-go-test-func'
            execute printf('bwipe! %s', b)
        endif
    endfor

    let dir = expand('%:p:h')

    if len(test_info.sub_test_names) > 0
        let cmd = printf("echo '「%s」を実行しています...👀\n-----\n'; go test -coverprofile='/tmp/go-coverage.out' -count=1 -v -race -run='^%s$'/'^%s$' $(go list %s) | go-test-colorful", test_info.test_func_name, test_info.test_func_name, test_info.sub_test_names[0], dir)
    else
        let cmd = printf("echo '「%s」を実行しています...👀\n-----\n'; go test -coverprofile='/tmp/go-coverage.out' -count=1 -v -race -run='^%s$' $(go list %s) | go-test-colorful", test_info.test_func_name, test_info.test_func_name, dir)
    endif

    let split = s:split_type()
    execut printf('%s gotest', split)

    if split ==# 'split'
        execute(printf('resize %s', floor(&lines * 0.3)))
    endif

    call termopen(cmd)
    setlocal bufhidden=delete
    setlocal noswapfile
    setlocal nobuflisted
    file vim-go-test-func
    wincmd p
endfunction

function! s:split_type() abort
    " NOTE: my cell ratio: width:height == 1:2.1
    let width = winwidth(win_getid())
    let height = winheight(win_getid()) * 2.1

    if height > width
        return 'split'
    else
        return 'vsplit'
    endif
endfunction

function! s:cursor_byte_offset() abort
    return line2byte(line('.')) + (col('.') - 2)
endfunction

" echo file name
nnoremap <silent> mm :echo expand("%:p")<CR>

nnoremap <silent> mw :set tabstop=2<CR>:set shiftwidth=2<CR>:set shiftwidth=2<CR>:echo "tab = 2 spaces"<CR>
nnoremap <silent> mf :set tabstop=4<CR>:set shiftwidth=4<CR>:set shiftwidth=4<CR>:echo "tab = 4 spaces"<CR>

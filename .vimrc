if has('nvim')
    let g:vim_home = expand('~/.nvim')
    let g:rc_dir = expand('~/.nvim/rc')
else
    let g:vim_home = expand('~/.vim')
    let g:rc_dir = expand('~/.vim/rc')
endif

function! s:source_rc(rc_file_name)
    let rc_file = expand(g:rc_dir . '/' . a:rc_file_name)
    if filereadable(rc_file)
        execute 'source' rc_file
    endif
endfunction

" 最小構成
call s:source_rc('minimum.rc.vim')

" ショートカットキー
call s:source_rc('keymap.rc.vim')

" メイン(移行中)
call s:source_rc('init.rc.vim')

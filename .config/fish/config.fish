## vi mode
fish_vi_key_bindings

## override to remove mark like [I]
function fish_mode_prompt
end

set -g theme_nerd_fonts yes
set -g theme_display_user yes

## starship prompt
/usr/local/bin/starship init fish | source

## aliases
alias la='ls -CFal'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias sc='screen'
alias g='cd (ghq root)/(ghq list | peco)'

source /usr/local/opt/asdf/asdf.fish

function fish_user_key_bindings
  bind \cr peco_select_history # Bind for prco history to Ctrl+r
end
set GHQ_SELECTOR peco

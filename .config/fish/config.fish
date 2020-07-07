## vi mode
fish_vi_key_bindings

## override to remove mark like [I]
function fish_mode_prompt
end

set -g theme_nerd_fonts yes
set -g theme_display_user yes

## aliases
alias la='ls -CFal'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias sc='screen'
alias g='cd (ghq root)/(ghq list | peco)'
alias gh='hub browse (ghq list | peco | cut -d "/" -f 2,3)'


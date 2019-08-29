# standard
## vi mode
set -o vi

## aliases
if [[ ! $OSTYPE =~ "darwin" ]]; then
    alias ls='ls -CF --color=auto'
    alias ll='ls -AlFh --show-control-chars --color=auto'
    alias ps='ps --sort=start_time'
fi

alias la='ls -CFal'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias sc='screen'

## standard env
export PATH=$PATH:/sbin:/usr/sbin
export PAGER='less'
export EDITOR='/usr/bin/vim'
export HISTSIZE=100000
export LANG='ja_JP.UTF-8'
case $TERM in
	linux) LANG=C ;;
	*) LANG=ja_JP.UTF-8 ;;
esac
export LC_ALL='ja_JP.UTF-8'
export LC_MESSAGES='ja_JP.UTF-8'
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH"

## pyenv
type pyenv > /dev/null 2>&1
status="$?"
if [[ "$status" != 0 ]]; then
    git clone git://github.com/yyuu/pyenv.git ~/.pyenv
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# view
## powerline
_update_ps1() {
	PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
	PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

## tmux
[[ $- != *i*  ]] && return
if [[ -z $TMUX ]]; then
    if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
        # detached session exists
        tmux list-sessions
        echo -n "Tmux: attach? (y/N/num) "
        read
        if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
            tmux attach-session
            if [ $? -eq 0 ]; then
                echo "$(tmux -V) attached session"
            fi
        elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
            tmux attach -t "$REPLY"
            if [ $? -eq 0 ]; then
                echo "$(tmux -V) attached session"
            fi
        fi
    else
        tmux new-session && echo "tmux created new session"
    fi
else
    echo
    echo $(tput setaf 31)'  o                                         '$(tput sgr0)
    echo $(tput setaf 32)' <|>   \o__ __o__ __o   o       o  \o    o/ '$(tput sgr0)
    echo $(tput setaf 33)' <o_/   |     |     |> <|>     <|>  v\  /v  '$(tput sgr0)
    echo $(tput setaf 34)'  |    / \   / \   / \ < >     < >   <\/>   '$(tput sgr0)
    echo $(tput setaf 35)' <|>   \o/   \o/   \o/  |       |    o/\o   '$(tput sgr0)
    echo $(tput setaf 36)'  o     |     |     |   o       o   /v  v\  '$(tput sgr0)
    echo $(tput setaf 37)'  <\__ / \   / \   / \  <\__ __/>  />    <\ '$(tput sgr0)
    echo
    echo $(tput setaf 6)' ==========================================='$(tput sgr0)
    echo $(tput setaf 6)' =  🐧 < Settings are loaded (@wassan128)  ='$(tput sgr0)
    echo $(tput setaf 6)' ==========================================='$(tput sgr0)
fi

# secrets
## for my private use
SECRETS_PATH="${HOME}/.secrets"
[ -f "$SECRETS_PATH" ] && source $SECRETS_PATH && \
    echo $(tput setaf 3)' [*] secrets loaded'$(tput sgr0)


# fish
exec fish


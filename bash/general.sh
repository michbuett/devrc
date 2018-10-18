# don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

export NODE_PATH="/usr/local/lib/jsctags/:$NODE_PATH"
export CLICOLOR=1
export PATH="$HOME/.local/bin/:$HOME/.cargo/bin/:$PATH"

# enable vi mode
set -o vi

# do not freeze terminal when using [ctrl]+[s]
if [ $(command -v stty) ]; then
    stty ixany
    stty ixoff -ixon
    stty stop undef
    stty start undef
fi

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if hash brew 2>/dev/null; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi

    if [ -f $(brew --prefix)/opt/fzf/shell/completion.zsh ]; then
        source $(brew --prefix)/opt/fzf/shell/key-bindings.bash
        source $(brew --prefix)/opt/fzf/shell/completion.bash
    fi

    # fzf + ag configuration
    if hash fzf 2>/dev/null && hash ag 2>/dev/null; then
        export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_DEFAULT_OPTS='
        --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
        --color info:108,prompt:109,spinner:108,pointer:168,marker:168
        '
    fi
fi

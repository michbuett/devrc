# don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

export MAVEN_OPTS="-Xms256m -Xmx512m -XX:MaxPermSize=256m"
export NODE_PATH="/usr/local/lib/jsctags/:$NODE_PATH"

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

# do not freeze terminal when using [ctrl]+[s]
stty ixany
stty ixoff -ixon
stty stop undef
stty start undef

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


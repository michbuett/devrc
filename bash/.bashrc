export PS1="\[\e[32;1m\]\u: ../\W> \[\e[0m\]"
source $HOME/git_prompt.sh

export MAVEN_OPTS="-Xms256m -Xmx512m -XX:MaxPermSize=256m"

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

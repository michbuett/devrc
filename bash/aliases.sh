# general shortcuts

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# search and replace
if  type "rg" &> /dev/null; then
    alias cs='rg'
elif  type "ack-grep" &> /dev/null; then
    alias cs='ack-grep'
elif type "ack" &> /dev/null; then
    alias cs='ack'
elif type "ag" &> /dev/null; then
    alias cs='ag'
else
    alias cs='grep -R'
fi
function search-n-replace() {
    pattern=$1
    replacement=$2
    #echo "cs -l \"$pattern\" | xargs perl -pi -E \"s/$pattern/$replacement/g\""
    cs -l "$pattern" | xargs perl -pi -E "s/$pattern/$replacement/g"
}

# git shortcuts
alias gst='git status'
alias gl='git lol'
alias gsh='git show'
alias gc='git commit'
alias gd='git diff'
alias gr='if [ "`git rev-parse --show-cdup`" != "" ]; then cd `git rev-parse --show-cdup`; fi'
alias gsd='if [ "`git rev-parse --show-cdup`" != "" ]; then cd `git rev-parse --show-cdup`; fi && git stash && mvn clean test && git svn dcommit && git stash pop'
alias gsr='git stash && git svn rebase && git stash pop'

# tags
alias phptags='ctags -R --php-kinds=-v --totals=yes --fields=+l'

#vim
if type "nvim" &> /dev/null; then
    alias v='nvim' # neo-vim
elif type "xvim" &> /dev/null; then
    alias v='xvim' # MacVim
else
    alias v='vim'
fi

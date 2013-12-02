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
alias ll='ls -alF --color'
alias la='ls -A'
alias l='ls -CF'

# search and replace
alias ack='ack-grep'
function search-n-replace() {
    pattern=$1
    replacement=$2
    #echo "ack -l \"$pattern\" | xargs perl -pi -E \"s/$pattern/$replacement/g\""
    ack -l "$pattern" | xargs perl -pi -E "s/$pattern/$replacement/g"
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

# maven shortcuts
alias mt='mvn clean test'

# dtmp shortcuts
alias rcg='cd /home/dtmp/workspace/trunk/gamesload-client'
alias rce='cd /home/dtmp/workspace/trunk/gamesload-client;vim -S /home/dtmp/dtmp.vim'
alias rcm='sudo dtmp-vm-mount-gamesload-client mount trunk'
alias rcu='sudo dtmp-vm-mount-gamesload-client umount trunk'
alias rccss='rcg; bash src/main/resources/sass/update-CSS.sh update force'
alias rcf='find . -name "*.sh" -exec chmod +x {} \;'
alias rci='curl -X POST http://seb.devvm01.v1.dtmp.seitenbau.net/dtmp-backend-search/1.0/search/products/recreateindex'
alias rcvm='ssh dtmp@deploy.devvm01.v1.dtmp.seitenbau.net'

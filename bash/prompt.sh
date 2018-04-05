source "$DEVRC_HOME/bash/colors.sh"

# Determines the status of the last command (a green checkmark for success
# and a red x for a failure)
function get_status {
    local last_status=$?
    local red="\e[1;31m"
    local green="\e[1;32m"
    local nocolor="\e[0m"

    if [ $last_status -eq 0 ]; then
        last_status="$green[✓]$nocolor"
    else
        last_status="$red[x]$nocolor"
    fi
    echo "$last_status"
}

# Determines the name of the current git branch
function get_git_branch {
    echo $(git branch --no-color 2> /dev/null | grep '*' | sed 's/\*//g' | sed 's/ //g')
}

# Determines the git status (M - modified, ? - untracked files, ...)
function get_git_flags {
    local tmp_flags=$(git status --porcelain 2> /dev/null | cut -c1-2 | sed 's/ //g' | cut -c1 | sort | uniq)
    echo "$(echo $tmp_flags | sed 's/ //g')"
}

jobscount() {
  local running=$(jobs -rp | wc -l)
  ((running)) && echo -n "(jobs: $running) "
}

function set_prompt {
    local last_status=$(get_status)
    local branch=$(get_git_branch)
    local cwd=$(pwd | sed "s|^$HOME|~|")
    local jobs=$(jobscount)
    local prompt="\n$last_status ${jobs}$cwd"

    if [ $branch ]; then
        local flags=$(get_git_flags)
        local cyan="\e[1;36m"
        local purple="\e[1;35m"
        local nocolor="\e[0m"

        prompt="$prompt ($cyan$branch$nocolor)"

        if [ $flags ]; then
            prompt="$prompt[$purple$flags$nocolor]"
        fi
    fi

    PS1="> "
    echo -e $prompt
}

PROMPT_COMMAND=set_prompt

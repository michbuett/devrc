source "$DEVRC_HOME/bash/colors.sh"

# Determines the status of the last command (a green checkmark for success
# and a red x for a failure)
function get_status {
    local last_status=$?
    if [ $last_status -eq 0 ]; then
        local checkmark=$(echo -e "\xE2\x9C\x93")
        last_status="$Green($checkmark)$Color_Off"
    else
        last_status="$Red(x)$Color_Off"
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

function set_prompt {
    local last_status=$(get_status)
    local branch=$(get_git_branch)
    local freemem=$(sed -n "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo)
    local totalmem=$(sed -n "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo)
    local c=$(if [ $UID == 0 ]; then echo $BRed; else echo $IWhite; fi)
    local build=$(if [ -e /var/lib/dtmp/dtmp-deployment/metadata/build_id ]; then echo "[$(cat /var/lib/dtmp/dtmp-deployment/metadata/build_id)]"; fi)
    local prompt="\n[\d] $last_status $Cyan$((freemem / 1024))/$((totalmem /1024))MB $c\u@\h:\w$Color_Off"

    if [ $branch ]; then
        local flags=$(get_git_flags)
        prompt="$prompt ($Cyan$branch$Color_Off)"

        if [ $flags ]; then
            prompt="$prompt[$BPurple$flags$Color_Off]"
        fi
    fi

    PS1="$prompt \n$BIGreen\$ $Color_Off"
}

PROMPT_COMMAND=set_prompt

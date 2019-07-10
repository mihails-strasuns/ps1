# Source this from actual bashrc

scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $scripts/formatting.sh

PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local status_code="$?"

    # First line

    PS1="${LightGray}${PathFull}${Reset}"

    git rev-parse --git-dir > /dev/null 2>&1
    if [ "$?" == "0" ]
    then
        PS1+=" [`git rev-parse --abbrev-ref HEAD`]"
        tag=`git describe --tags 2>&1`
        if [ "$?" == "0" ]
        then
            PS1+=" ${Green}[$tag]${Reset}"
        else
            PS1+=" ${Green}[`git rev-parse --short=10 HEAD`]${Reset}"
        fi
    fi

    # Second line

    PS1+="\n"

    if [ $status_code != 0 ]; then
        PS1+="${Red}✖ ${White}${RedBG}${status_code}${Reset} "
    else
        PS1+="${Green}✔ ${Reset}"
    fi

    PS1+="${DarkGray}${Host} ${Green}\$${Reset} "
}

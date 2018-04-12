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
        PS1+=" ${Green}[`git describe --tags --always`]${Reset}"
    fi

    # Second line

    PS1+="\n"

    if [ $status_code != 0 ]; then
        PS1+="${Red}✖ ${White}${RedBG}${status_code}${Reset} "
    else
        PS1+="${Green}✔ ${Reset}"
    fi

    PS1+="${DarkGray}${Time24h} ${Green}\$${Reset} "
}

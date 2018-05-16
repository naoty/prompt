setopt prompt_subst

git-prompt() {
    local message=""
    local message_color="%F{green}"

    local staged=$(git status --porcelain 2>/dev/null | grep "^M ")
    local unstaged=$(git status --porcelain 2>/dev/null | grep "^ M")
    local untracked=$(git status --porcelain 2>/dev/null | grep "^??")

    if [[ -n ${staged} ]]; then
        message_color="%F{yellow}"
    elif [[ -n ${unstaged} ]]; then
        message_color="%F{red}"
    elif [[ -n ${untracked} ]]; then
        message_color="%F{red}"
    fi

    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ -n ${branch} ]]; then
        message+=" ${message_color}${branch}%f"
    fi

    echo -n "${message}"
}

PROMPT='%# '
RPROMPT='%c$(git-prompt)'

# prompt configuration tips:
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html

function conda_prompt_info(){
    if [[ ! -z "$CONDA_DEFAULT_ENV" ]]; then
        echo "${ZSH_THEME_CONDA_PREFIX:=[}${%reset_color%}${CONDA_DEFAULT_ENV:t}${ZSH_THEME_CONDA_SUFFIX:=]} "
    else
        echo ""
    fi
}

PROMPT='$(conda_prompt_info)\
%{$fg_bold[red]%}%n@%m\
%{$reset_color%}:%{$fg[cyan]%}${PWD/#$HOME/~}\
%{$reset_color%}:%# 
%{$fg_bold[yellow]%}→ '

RPROMPT='%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}% '
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}%{$fg[red]%} ✗%{$fg[green]%}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}%{$fg[greed]%} ○%{$fg[green]%}%{$reset_color%}"

export PS1=$PROMPT

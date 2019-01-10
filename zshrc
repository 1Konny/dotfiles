##==== Set paths
export PATH=$HOME/bin:/usr/local/bin:/usr/local/cuda/bin:$PATH
export PATH=$HOME/anaconda3/bin:$PATH # anaconda3
export PATH=$HOME/.local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh # oh-my-zsh
export LANG=en_US.UTF-8


##==== Set terminal color bit?
#if [ -e /usr/share/terminfo/x/xterm-256color ]; then
#	export TERM='xterm-256color'
#else
#	export TERM='xterm-color'
#fi
export TERM='xterm-256color'


##==== OH-MY-ZSH
# themes: https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="mrtazz"          # set zsh theme
ZSH_THEME="mrtazz_custom"          # set zsh theme
DISABLE_AUTO_UPDATE="true"  # no automatically update oh-my-zsh
HIST_STAMPS="mm/dd/yyyy"    # history with date stamps

# set plugins
plugins=(
  # git
  # alias-tips
  zsh-syntax-highlighting
  zsh-autosuggestions
)

# load zsh
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  #export EDITOR='mvim'
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
# personal aliases
for alias_file in "$HOME/.aliases"/*
do
    source $alias_file
done

# =============================================================== #
# remove duplicates in PATH
export PATH="$(echo -n $PATH | awk -v RS=: -v ORS=: '!arr[$0]++')"

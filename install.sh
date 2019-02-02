#! /bin/bash

# Argument Parser
# USAGE : https://stackoverflow.com/questions/7069682/how-to-get-arguments-with-flags-in-bash
while getopts 'c' flag; do
  case "${flag}" in
    c) install_conda='true' ;;
  esac
done


#==================================================#
DF_DIR=$PWD
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$ZSH/custom


#==================================================#
# set zsh to the default shell
echo 'Set ZSH as default shell'
chsh -s $(which zsh)


#==================================================#
# function to backup existing dotfiles. 
# (buo : back-up-original)
function buo(){
    backup_dir="$HOME/dotfiles_backup"
    name=$1
    path="$HOME/$name"

    if [ -f $path ] || [ -h $path ] || [ -d $path ];
    then
        mkdir -p $backup_dir
        new_path="$backup_dir/$name"
        printf "Found '$path'. Backing up to '$new_path\n"
        mv $path $new_path
    fi
}

buo .Xmodmap; ln -sf $DF_DIR/Xmodmap $HOME/.Xmodmap 
buo .vim; buo .vimrc; ln -sf $DF_DIR/vimrc $HOME/.vimrc
buo .tmux.conf; ln -sf $DF_DIR/tmux.conf $HOME/.tmux.conf
buo .aliases; ln -sf $DF_DIR/aliases $HOME/.aliases
buo .gitconfig; ln -sf $DF_DIR/gitconfig $HOME/.gitconfig
buo .zshrc; ln -sf $DF_DIR/zshrc $HOME/.zshrc
buo .oh-my-zsh; bash $DF_DIR/install-omz.sh; ln -sf $DF_DIR/themes/mrtazz_custom.zsh-theme $HOME/.oh-my-zsh/themes/


#==================================================#
# download useful plugins

# zsh
# alias-tip 
git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-$ZSH/custom}/plugins/alias-tips
# zsh-syntax-highlighting 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-syntax-highlighting
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-autosuggestions

# vim 
# colorschemes
mkdir $HOME/.vim
git clone https://github.com/flazz/vim-colorschemes.git $HOME/.vim
# pathogen: vim plugins manager
mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle && curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
# nerdtree: file/directory browser
git clone https://github.com/scrooloose/nerdtree.git $HOME/.vim/bundle/nerdtree
# jedi-vim: jumps, auto-suggestions/completions
git clone --recursive https://github.com/davidhalter/jedi-vim.git $HOME/.vim/bundle/jedi-vim
# airline: status/tabline customization
git clone https://github.com/vim-airline/vim-airline $HOME/.vim/bundle/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes $HOME/.vim/bundle/vim-airline-themes


#==================================================#
# anaconda3
if [ "$install_conda" == "true" ]; 
then
    wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh -O anaconda.sh
    bash anaconda.sh -b -p $HOME/anaconda3
    rm anaconda.sh
    conda update conda --yes
    conda update anaconda --yes
fi


#==================================================#
exec zsh

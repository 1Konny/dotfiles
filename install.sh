#! /bin/bash

#==================================================#
# argument parser
# usage : https://stackoverflow.com/questions/7069682/how-to-get-arguments-with-flags-in-bash
while getopts 'cfu:' flag; do
  case "${flag}" in
    c) install_conda='true' ;;
    f) forced='true' ;;
    u) update="${OPTARG}" ;;
  esac
done


#==================================================#
DOT_DIR=$PWD
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$ZSH/custom


#==================================================#
source "$PWD/aliases/misc"
if [ "$forced" != "true" ]; then
    buo .Xmodmap .vim .vimrc .tmux.conf .aliases .gitconfig .gitconfig.secret .condarc .zshrc .oh-my-zsh
fi
ln -sf $DOT_DIR/Xmodmap $HOME/.Xmodmap 
ln -sf $DOT_DIR/vimrc $HOME/.vimrc
ln -sf $DOT_DIR/tmux.conf $HOME/.tmux.conf
ln -sf $DOT_DIR/aliases $HOME/.aliases
ln -sf $DOT_DIR/gitconfig $HOME/.gitconfig
ln -sf $DOT_DIR/condarc $HOME/.condarc
ln -sf $DOT_DIR/zshrc $HOME/.zshrc
echo; echo '** download oh-my-zsh.'
bash $DOT_DIR/install-omz.sh; 
ln -sf $DOT_DIR/themes/mrtazz_custom.zsh-theme $HOME/.oh-my-zsh/themes/


#==================================================#
# download useful plugins

# zsh
echo; echo '** download zsh plugins.'
# alias-tip 
git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-$ZSH/custom}/plugins/alias-tips
# zsh-syntax-highlighting 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-syntax-highlighting
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-autosuggestions

# vim 
echo; echo '** download vim plugins.'
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
if [ "$install_conda" = "true" ]; 
then
    source "$PWD/aliases/conda"
    if [ $(checkconda) = "true" ]; then
        echo; echo "** anaconda already exists."
    else
        echo; echo "** anaconda does not exist. download anaconda3."
        wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh -O anaconda.sh
        echo; echo "** install anaconda3."
        bash anaconda.sh -b -p $HOME/anaconda3
        rm anaconda.sh
        #conda update conda --yes
        #conda update anaconda --yes
    fi
fi


#==================================================#
# set zsh to the default shell
echo; echo '** set ZSH as default shell.'
echo "exec zsh" >> $HOME/.bash_profile
exec zsh

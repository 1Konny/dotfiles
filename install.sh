#! /bin/bash
##====
DF_DIR=$PWD
ZSH=~/.oh-my-zsh
ZSH_CUSTOM=$ZSH/custom


##==== set zsh to the default shell
chsh -s 'which zsh'


##==== make symlinks(after backing up original dotfiles)
function buo(){
	path=$1
	if [ -f $path ] || [ -h $path ] || [ -d $path ];
	then
		new_path=$path'.back-up-original'
		printf "Found '$path'. Backing up to '$new_path\n"
		mv $path $new_path
	fi
}

buo ~/.Xmodmap
ln -sf $DF_DIR/Xmodmap ~/.Xmodmap # set ALT(right) as KOR/ENG toggle key.

buo ~/.zshrc
ln -sf $DF_DIR/zshrc ~/.zshrc

buo ~/.vimrc
ln -sf $DF_DIR/vimrc ~/.vimrc

buo ~/.tmux.conf
ln -sf $DF_DIR/tmux.conf ~/.tmux.conf
#tmux show -g | sed 's/^/set-option -g /' > ~/.tmux.conf.back-up-original

buo ~/.aliases
ln -sf $DF_DIR/aliases ~/.aliases

buo ~/.gitconfig
ln -sf $DF_DIR/gitconfig ~/.gitconfig


##==== oh-my-zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" # one-liner
bash $DF_DIR/install-omz.sh
ln -sf $DF_DIR/themes/mrtazz_custom.zsh-theme ~/.oh-my-zsh/themes/


##==== zsh plugins
###==== alias-tip 
git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-$ZSH/custom}/plugins/alias-tips
###==== zsh-syntax-highlighting 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-syntax-highlighting
###==== zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-autosuggestions


##==== vim
###==== colorschemes
mkdir ~/.vim
git clone https://github.com/flazz/vim-colorschemes.git ~/.vim
###==== pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
###==== nerdtree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
###==== youcompleteme
cd ~/.vim/bundle
git clone https://github.com/Valloric/YouCompleteMe.git; cd YouCompleteMe
git submodule update --init --recursive
./install.sh
cd $DF_DIR


##==== anaconda3
wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh -O anaconda.sh
bash anaconda.sh -b -p $HOME/anaconda3
rm anaconda.sh
###==== update conda
#conda update conda --yes
#conda update anaconda --yes

exec zsh

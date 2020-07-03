#!/bin/bash

vimdir=${HOME}/.vim
vimbundledir=${vimdir}/bundle

# install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# symlink vimrc
DATETIME="`date +%Y%m%d%H%M%S`"
FILE=$HOME/.vimrc

if [ -f "$FILE" ]; then
    echo "$FILE already exists, renaming as $FILE.$DATETIME"
    mv $FILE $FILE.$DATETIME
fi

# to update submodules to latest master: git submodule update --remote --merge
echo "updating submodules with 'git submodule update --init --recursive..."
git submodule update --init --recursive

#TODO: check if these are already linked
echo "linking vimrc: ln -s $HOME/vimconfig/vimrc $HOME/.vimrc"
ln -s $HOME/vimconfig/vimrc $HOME/.vimrc

echo "linking plugins: ln -s $HOME/vimconfig/bundle $HOME/.vim/bundle"
ln -s $HOME/vimconfig/bundle $HOME/.vim/bundle

# below are handled by submodules now
#echo "Cloning vim-syntastic into ${vimbundledir}/vim-syntastic"
#git clone https://github.com/vim-syntastic/syntastic.git ${vimbundledir}/vim-syntastic
#echo "Cloning tagbar into ${vimbundledir}/tagbar"
#git clone https://github.com/majutsushi/tagbar.git ${vimbundledir}/tagbar
#echo "Cloning vim-code-dark into ${vimbundledir}/vim-code-dark"
#git clone https://github.com/tomasiser/vim-code-dark.git ${vimbundledir}/vim-code-dark
#echo "Cloning vim-fugitive into ${vimbundledir}/vim-fugitive"
#git clone https://github.com/tpope/vim-fugitive.git ${vimbundledir}/vim-fugitive
#echo "Cloning vim-signify into ${vimbundledir}/vim-signify"
#git clone https://github.com/mhinz/vim-signify.git ${vimbundledir}/vim-signify
#echo "Cloning vim-rails into ${vimbundledir}/vim-rails"
#git clone https://github.com/tpope/vim-rails.git ${vimbundledir}/vim-rails
#echo "Cloning vim-surround into ${vimbundledir}/vim-surround"
#git clone https://github.com/tpope/vim-surround.git ${vimbundledir}/vim-surround
#echo "Cloning vlime into ${vimbundledir}/vlime"
#git clone https://github.com/vlime/vlime.git ${vimbundledir}/vlime
#echo "Cloning jedi-vim into ${vimbundledir}/jedi-vim"
#git clone --recursive https://github.com/davidhalter/jedi-vim.git ${vimbundledir}/jedi-vim
#echo "Cloning vim-obsession into ${vimbundledir}/vim-obsession"
#git clone https://github.com/tpope/vim-obsession.git ${vimbundledir}/vim-obsession
#echo "Cloning vim-unimpaired into ${vimbundledir}/vim-unimpaired"
#git clone https://github.com/tpope/vim-unimpaired.git ${vimbundledir}/vim-unimpaired
#echo "Cloning vim-repeat into ${vimbundledir}/vim-repeat"
#git clone https://github.com/tpope/vim-repeat.git ${vimbundledir}/vim-repeat
#echo "Cloning tabular into ${vimbundledir}/tabular"
#git clone https://github.com/godlygeek/tabular.git ${vimbundledir}/tabular

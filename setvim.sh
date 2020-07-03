#!/bin/bash

DATETIME="`date +%Y%m%d%H%M%S`"
VIMRC=$HOME/.vimrc
PLUGDIR=$HOME/.vim/bundle

# to update submodules to latest master: git submodule update --remote --merge
echo "initializing local submodule config file with 'git submodule init'..."
git submodule init
echo "getting submodules with 'git submodule update --init --recursive..."
git submodule update --init --recursive

if [ -f "$VIMRC" ]; then
    echo "$VIMRC already exists, renaming as $VIMRC.$DATETIME..."
    mv $VIMRC $VIMRC.$DATETIME
fi
echo "linking vimrc: ln -s $HOME/vimconfig/vimrc $HOME/.vimrc..."
ln -s $HOME/vimconfig/vimrc $HOME/.vimrc

if [ -d "$PLUGDIR" ]; then
    echo "$PLUGDIR already exists, renaming as $PLUGDIR.$DATETIME..."
    mv $PLUGDIR $PLUGDIR.$DATETIME
fi
echo "linking plugins: ln -s $HOME/vimconfig/bundle $HOME/.vim/bundle..."
ln -s $HOME/vimconfig/bundle $HOME/.vim/bundle

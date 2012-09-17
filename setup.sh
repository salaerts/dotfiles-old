#!/bin/sh

DIR=$PWD

echo "Creating symbolic link for .vimrc"
ln -sf "$DIR/.vimrc" ~/.vimrc

if [ ! -d "~/.vim" ]; then
    echo "Creating .vim directory"
    mkdir -p ~/.vim
fi

if [ ! -d "~/.vim/bundle" ]; then
    echo "Creating .vim/bundle"
    mkdir -p ~/.vim/bundle
fi

fi [ ! -d "~/.vim/bundle/vundle" ]; then
    echo "Installing Vim plugin Vundle"
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi


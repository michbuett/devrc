#!/bin/bash

cd "$(dirname $0)/.."

DEVRC_ROOT="$(pwd)"
TIMESTAMP=$(date +%s)

echo ""
echo "#########################################################################"
echo "###                CONFIGURATION OF DEV ENVIRONMENT                   ###"
echo "#########################################################################"
echo ""
echo "SETUP VIM"
echo "-------------------------------------------------------------------------"

if [ -d ~/.vim ]; then
    echo -n "Backup existing vim files at .vim.$TIMESTAMP... "
    # mv ~/.vim ~/.vim.$TIMESTAMP
    echo "done"
fi

mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/colors

if [ -e ~/.vimrc ]; then
    if [ -L ~/.vimrc ]; then
        # .vimrc is a symbolic link -> remove it
        echo -n "Remove linked vim config file... "
        rm ~/.vimrc
        echo "done"
    else
        echo -n "Backup exiting vim configuration at .vimrc.$TIMESTAMP... "
        mv ~/.vimrc ~/vim.$TIMESTAMP
        echo "done"
    fi
fi

ln -s $DEVRC_ROOT/vim/.vimrc ~/.vimrc

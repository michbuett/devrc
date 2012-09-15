#!/bin/bash

cd "$(dirname $0)/.."

DEVRC_ROOT="$(pwd)"
TIMESTAMP=$(date +%s)
VUNDLE_REPO="https://github.com/gmarik/vundle.git"

echo ""
echo "#########################################################################"
echo "###                CONFIGURATION OF DEV ENVIRONMENT                   ###"
echo "#########################################################################"
echo ""
echo ""
echo " SETUP VIM"
echo "-------------------------------------------------------------------------"

if [ -d ~/.vim ]; then
    echo -n "Backup existing vim files at .vim.$TIMESTAMP... "
    mv ~/.vim ~/.vim.$TIMESTAMP
    echo "done"
fi

echo -n "Create vim folder structure... "
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/colors
echo "done"

echo -n "Get vundle repository: "
git clone $VUNDLE_REPO ~/.vim/bundle/vundle

if [ -L ~/.vimrc ]; then
    # .vimrc is a symbolic link -> remove it
    echo -n "Remove linked vim config file... "
    rm ~/.vimrc
    echo "done"
fi

if [ -e ~/.vimrc ]; then
    echo -n "Backup exiting vim configuration at .vimrc.$TIMESTAMP... "
    mv ~/.vimrc ~/vim.$TIMESTAMP
    echo "done"
fi

echo -n "Link .vimrc... "
ln -s $DEVRC_ROOT/vim/.vimrc ~/.vimrc
echo "done"

echo -n "Link color schemas... "
ln -s $DEVRC_ROOT/vim/desert256.vim ~/.vim/colors/
echo "done"

echo "Install vim bundles... "
vim +BundleInstall +qa


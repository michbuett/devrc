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

################################################################################
# STEP 1: configure vim
echo ""
echo " SETUP VIM"
echo "-------------------------------------------------------------------------"

install_vim=true
if [ -d ~/.vim ]; then
    echo "Vim directory already exists."
    while true; do
        read -p "(s)kip, (b)ackup, (o)verride or (e)xit? " input
        case $input in
            [Ss]* )
                install_vim=false
                break;;

            [Ee]* )
                echo "Exit! Dumbass!"
                exit 1
                break;;

            [Bb]* )
                echo -n "Backup existing vim files at .vim.$TIMESTAMP... "
                mv ~/.vim ~/.vim.$TIMESTAMP
                echo "done"
                break;;

            [Oo]* )
                echo -n "Remove exiting vim files... "
                rm  -rf ~/.vim
                echo "done"
                break;;

        esac
    done
fi

if [ $install_vim == true ]; then
    echo -n "Create vim folder structure... "
    mkdir -p ~/.vim/bundle
    mkdir -p ~/.vim/colors
    echo "done"

    echo -n "Get vundle repository: "
    git clone $VUNDLE_REPO ~/.vim/bundle/vundle
    echo "done"

    if [ -L ~/.vimrc ]; then
        # .vimrc is a symbolic link -> remove it
        echo -n "Remove linked vim config file... "
        rm ~/.vimrc
        echo "done"
    fi
    if [ -e ~/.vimrc ]; then
        echo "Vim config already exists."
        while true; do
            read -p "(b)ackup, (d)elete or use as (l)ocal config? " input
            case $input in
                [Ll]* )
                    echo -n "Renaming exiting vim configuration to .vimrc.local... "
                    mv ~/.vimrc ~/vimrc.local
                    echo "done"
                    break;;

                [Bb]* )
                    echo -n "Backup exiting vim configuration at .vimrc.$TIMESTAMP... "
                    mv ~/.vimrc ~/vimrc.$TIMESTAMP
                    echo "done"
                    break;;

                [Dd]* )
                    echo -n "Remove exiting vim config file... "
                    rm ~/.vimrc
                    echo "done"
                    break;;

            esac
        done
    fi

    echo -n "Link .vimrc... "
    ln -s $DEVRC_ROOT/vim/.vimrc ~/.vimrc
    echo "done"

    echo -n "Link color schemas... "
    ln -s $DEVRC_ROOT/vim/desert256.vim ~/.vim/colors/
    echo "done"

    echo "Install vim bundles... "
    vim +BundleInstall +qa

else
    echo "Skip vim setup"
fi


################################################################################
# STEP 2: SETUP BASH ENVIRONMENT
echo ""
echo " SETUP BASH"
echo "-------------------------------------------------------------------------"

if [ -e ~/.bashrc ]; then
    echo ".bashrc already exists."
    while true; do
        read -p "(b)ackup, (d)elete or use as (l)ocal config? " input
        case $input in
            [Ll]* )
                echo -n "Renaming exiting .bashrc to .bashrc.local... "
                mv ~/.bashrc ~/.bashrc.local
                echo "done"
                break;;

            [Bb]* )
                echo -n "Backup exiting .bashrc at .bashrc.$TIMESTAMP... "
                mv ~/.bashrc ~/.bashrc.$TIMESTAMP
                echo "done"
                break;;

            [Dd]* )
                echo -n "Remove exiting vim config file... "
                rm ~/.bashrc
                echo "done"
                break;;

        esac
    done
fi

echo -n "Create .bashrc... "
echo "[ -z "$PS1" ] && return" > .bashrc
echo "export DEVRC_HOME=$DEVRC_ROOT" >> ~/.bashrc
echo "source $DEVRC_ROOT/bash/.bashrc.general" >> ~/.bashrc
echo "source $DEVRC_ROOT/bash/.bashrc.aliases" >> ~/.bashrc
echo "source $DEVRC_ROOT/bash/.bashrc.prompt" >> ~/.bashrc
echo "if [ -f ~/.bashrc.local ]; then source ~/.bashrc.local fi" >> ~./.bashrc
echo "done"

#!/bin/sh
# This script creates symlinks based on the files present in dotfiles

alias ln="ln -fns"
BASE_DIR="$HOME/Documents/dotfiles"

# Scripts directory -> $HOME/scripts
# Check if directory exists

bashrc_append=$(cat <<- OEM
# Scripts directory is added (link) to home
# This add \$HOME/scripts to \$PATH
export PATH=\$HOME/scripts:\$PATH
OEM
) 

if [ ! -d "$HOME/scripts" ]; then
    ln -v $BASE_DIR/scripts $HOME/scripts

    # check if ~/.bashrc has been modified already
    if [ "$(grep -c "$bashrc_append" ~/.bashrc)" = 0 ]; then
        echo 'Lines added to ~/.bashrc:'
        echo '-----------------------------------'
        printf "\n$bashrc_append\n" | tee -a ~/.bashrc
        echo '-----------------------------------'
    fi
fi

# Bash files
ln -v $BASE_DIR/bash/aliases ~/.bash_aliases
ln -v $BASE_DIR/bash/bashrc ~/.bashrc

# Conda
if [ ! -z $(which conda) ]; then
    ln -v $BASE_DIR/conda/condarc ~/.condarc
fi

# Git
if [ ! -z $(which git) ]; then
    ln -v $BASE_DIR/git/gitconfig ~/.gitconfig
fi

# Vim
if [ ! -z $(which vim) ]; then
    ln -v $BASE_DIR/vim/vimrc ~/.vimrc
fi

# Ranger
if [ ! -z $(which ranger) ]; then
    if [ ! -d ~/.config/ranger ]; then
        echo "Generating rc.conf for ranger (default)."
        ranger --copy-config=rc
    fi
    ln -v $BASE_DIR/ranger/conf ~/.config/ranger/rc.conf
fi

# Conda startup default_profile
if [ -d ~/.ipython ]; then
    cp -frv $BASE_DIR/ipython/startup/* ~/.ipython/profile_default/startup
fi

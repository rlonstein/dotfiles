#!/usr/bin/env -S sh -xe

SOURCE=$HOME/repos/dotfiles/zsh

ln -sf $SOURCE $HOME/.zsh
ln -sf $SOURCE/zshrc $HOME/.zshrc
ln -sf $SOURCE/zshenv $HOME/.zshenv


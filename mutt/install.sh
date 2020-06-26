#!/usr/bin/env -S sh -xe

SOURCE=$HOME/repos/dotfiles/mutt
mkdir $HOME/.mutt/
mkdir $HOME/.mutt/cache/
ln -s $SOURCE/mailcap $HOME/.mutt/mailcap
ln -s $SOURCE/muttrc $HOME/.muttrc
ln -s $SOURCE/muttrc-bindings $HOME/.mutt/muttrc-bindings
ln -s $SOURCE/muttrc-macros $HOME/.mutt/muttrc-macros
ln -s $SOURCE/muttrc-colors $HOME/.mutt/muttrc-colors
echo "*** Create or copy ~/.mutt/muttrc-imap ***"

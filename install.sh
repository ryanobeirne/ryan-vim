#!/usr/bin/env bash
set -e

# Link repo files in home directory
rm -ri ~/{.vim,.vimrc} || :
ln -si "$(realpath "$(dirname "$0")")/.vim" ~/
ln -si "$(realpath "$(dirname "$0")")/.vimrc" ~/

# Make undo directory
[[ -d ~/.vimundodir ]] || mkdir ~/.vimundodir

# Update vim-plug plugins
vim -c PlugClean -c PlugInstall -c q -c Startify

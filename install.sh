#!/usr/bin/env bash
set -e

# Link repo files in home directory
rm -ri ~/{.vim,.vimrc} || :
ln -s "$(realpath $(dirname "$0"))/.vim" ~/
ln -s "$(realpath $(dirname "$0"))/.vimrc" ~/

# Make undo directory
[[ -d ~/.vimundodir ]] || mkdir ~/.vimundodir

# Checkout master branches of submodule plugins
cd -P ~/.vim
for dir in bundle/*/; do
	pushd "$dir" && git checkout master && git pull
	popd
done

# Update vim-plug plugins
vim -c PlugInstall -c q -c Startify
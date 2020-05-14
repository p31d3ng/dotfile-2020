#!/bin/bash

sudo apt udpate -y
sudo apt upgrade -y
sudo apt install -y neovim fish gcc jq ripgrep net-tools

# pre-setup
sudo hostnamectl set-hostname rpi4b
mkdir -p ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"
source ~/.bashrc
git clone https://github.com/p31d3ng/dotfile-2020.git
cd dotfile-2020
cp vimrc ~/.vimrc
cp tmux.conf ~/.tmux.conf

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
source ~/.bashrc
nvm install stable

# rust && rls
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source ~/.cargo/env
rustup component add rls rust-analysis rust-src

# nvim
## 1) vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

## 2) nvim-coc
mkdir ~/.config/nvim
cp init.vim ~/.config/nvim
cp coc-settings.json ~/.config/nvim

## 3) replace rust-analyzer with rls
sed -i 's/coc-rust-analyzer/coc-rls/g' ~/.config/nvim/init.vim
jq 'del(."rust-analyzer.serverPath")' coc-settings.json > /tmp/coc-settings.json
mv /tmp/coc-settings.json ~/.config/nvim/

## PlugInstall
nvim +PlugInstall +qa


#!/bin/bash

CYAN='\033[0;36m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
BASE_DIR=$PWD

# Tmux package manager
printf "${CYAN}== INSTALLING: TPM ==\n${NC}"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Neovim
printf "${CYAN}== INSTALLING: NEOVIM ==\n${NC}"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
rm -rf /opt/nvim-linux-x86_64
tar -C /opt -xzf nvim-linux-x86_64.tar.gz

if ! grep -q 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' ~/.bashrc; then
	echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.bashrc
fi

rm -rf nvim-linux-x86_64.tar.gz

# Lua
printf "${CYAN}== INSTALLING: LUA ==\n${NC}"
curl -L -R -O https://www.lua.org/ftp/lua-5.4.8.tar.gz
tar -C /opt -zxf lua-5.4.8.tar.gz
cd /opt/lua-5.4.8
make all test
cd $BASE
rm -rf lua-5.4.8.tar.gz

# LuaRocks
printf "${CYAN}== INSTALLING: LUAROCKS ==\n${NC}"
wget https://luarocks.org/releases/luarocks-3.12.2.tar.gz
tar -C /opt -zxpf luarocks-3.12.2.tar.gz
cd /opt/luarocks-3.12.2
./configure && make && make install
luarocks install luasocket
cd $BASE
rm -rf luarocks-3.12.2.tar.gz

printf "${GREEN}== ALL DONE!! ==\n${NC}"

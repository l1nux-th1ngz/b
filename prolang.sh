#!/bin/bash

# Install essential tools and libraries
sudo apt-get update
sudo apt-get -y install curl wget cmake cmake-extras gcc ninja-build autoconf automake cmake-data

# Install Python and necessary Python libraries
sudo apt-get -y install python3-full python3-pip libpangocairo-1.0-0 python3-cffi python3-xcffib

# Rust Installation
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile complete --default-toolchain nightly --no-modify-path
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Go Installation
wget https://go.dev/dl/go1.22.6.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.22.6.linux-amd64.tar.gz
rm go1.22.6.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' | tee -a ~/.bashrc
source ~/.bashrc

# NodeJS Installation
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get -y install nodejs

# Lua Installation
curl -L -R -O https://www.lua.org/ftp/lua-5.4.7.tar.gz
tar zxf lua-5.4.7.tar.gz
cd lua-5.4.7
make all test
sudo make install
cd ..
# Clean up
rm -rf lua-5.4.7
rm lua-5.4.7.tar.gz

# Perl Installation
wget https://www.cpan.org/src/5.0/perl-5.40.0.tar.gz
tar -xzf perl-5.40.0.tar.gz
cd perl-5.40.0
./Configure -des -Dprefix=/usr/local
make
sudo make install
cd ..
rm perl-5.40.0.tar.gz

# RBENV Installation
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

# Luarocks Installation
wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz
tar zxpf luarocks-3.11.1.tar.gz
cd luarocks-3.11.1
./configure && make && sudo make install
sudo luarocks install luasocket
cd ..
rm -rf luarocks-3.11.1 luarocks-3.11.1.tar.gz

# JDK Installation
wget https://download.oracle.com/java/22/latest/jdk-22_linux-x64_bin.deb
wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.deb

sudo dpkg -i jdk-22_linux-x64_bin.deb
sudo dpkg -i jdk-21_linux-x64_bin.deb
sudo dpkg -i jdk-17_linux-x64_bin.deb

# Fix any missing dependencies
sudo apt-get install -f

# Clean up the downloaded files
rm jdk-22_linux-x64_bin.deb
rm jdk-21_linux-x64_bin.deb
rm jdk-17_linux-x64_bin.deb

echo "Installation complete!"

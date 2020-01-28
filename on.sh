#!/usr/bin/env bash
cd $HOME/Faynl
rm -rf $HOME/.telegram-cli
install() {
rm -rf $HOME/.telegram-cli
sudo chmod +x tg
chmod +x Faynl
chmod +x ts
./ts
}
if [ "$1" = "ins" ]; then
install
fi
chmod +x td.sh
lua lite.lua

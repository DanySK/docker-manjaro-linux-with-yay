#!/bin/sh
set -e
cd /tmp
git clone 'https://aur.archlinux.org/yay.git' --depth=1
cd /tmp/yay
makepkg -si --noconfirm
cd ~
rm -rf /tmp/yay/

#!/bin/sh
cd
git clone https://aur.archlinux.org/yay.git --depth=1
cd yay
makepkg -si --noconfirm
cd ..

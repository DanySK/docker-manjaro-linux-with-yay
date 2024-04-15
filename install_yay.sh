#!/bin/sh
set -e
cd /tmp/yay
makepkg -si --noconfirm
cd ~
rm -rf /tmp/yay/

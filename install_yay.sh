#!/bin/sh
set -e
cd /tmp/yay
makepkg -si --noconfirm
cd ~

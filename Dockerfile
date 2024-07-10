FROM manjarolinux/base:20240707
RUN pacman -Sy --noconfirm --debug gawk gnupg libgpg-error gnupg gpgme
RUN pacman -Sy --noconfirm --debug archlinux-keyring manjaro-keyring
RUN rm -fr /etc/pacman.d/gnupg
RUN pacman-key --init
RUN pacman-key --populate archlinux manjaro
RUN pacman -Sc --noconfirm
RUN pacman -Syu --noconfirm && pacman -Sc --noconfirm
RUN pacman -S --needed \
# PACKAGES
base-devel \
binutils \
fakeroot \
gawk \
gettext \
gcc \
git \
make \
nano \
pigz \
pbzip2 \
openssh \
sudo \
which \
--noconfirm && pacman -Sc --noconfirm
## CREATE A NORMAL USER FOR YAY
RUN useradd builduser -m
# Delete the buildusers password
RUN passwd -d builduser
# Allow the builduser passwordless sudo
RUN printf 'root ALL=(ALL) ALL\n' | tee -a /etc/sudoers
RUN printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers
# Use parallel compression
COPY makepkg.conf /etc/makepkg.conf
RUN mkdir -p /tmp/yay/
RUN chmod 777 /tmp/yay/
COPY yay-repo/ /tmp/yay/
## INSTALL YAY
COPY install_yay.sh /usr/bin/install_yay.sh
RUN chmod +x /usr/sbin/install_yay.sh
RUN sudo -u builduser install_yay.sh
RUN rm -rf /tmp/yay/
RUN rm /usr/sbin/install_yay.sh
RUN sudo -u builduser yay -Sc --noconfirm
# Prepare easier commands
RUN mv /usr/bin/yay /usr/bin/yay-pure
COPY yay /usr/bin/yay
COPY yay-install /usr/bin/yay-install
CMD bash

FROM manjarolinux/base
RUN pacman -Sy --noconfirm gnupg archlinux-keyring manjaro-keyring
RUN rm -fr /etc/pacman.d/gnupg
RUN pacman-key --init
RUN pacman-key --populate archlinux manjaro
RUN pacman -Sc --noconfirm
RUN pacman -Syu --noconfirm && pacman -Sc --noconfirm
RUN pacman -S --needed git fakeroot sudo nano binutils make gcc gettext gawk pigz pbzip2 --noconfirm && pacman -Sc --noconfirm
## CREATE A NORMAL USER FOR YAY
RUN useradd builduser -m
# Delete the buildusers password
RUN passwd -d builduser
# Allow the builduser passwordless sudo
RUN printf 'root ALL=(ALL) ALL\n' | tee -a /etc/sudoers
RUN printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers
# Use parallel compression
COPY makepkg.conf /etc/makepkg.conf
## INSTALL YAY
COPY install_yay.sh /usr/bin/install_yay.sh
RUN chmod +x /usr/sbin/install_yay.sh
RUN sudo -u builduser install_yay.sh
RUN rm /usr/sbin/install_yay.sh
RUN sudo -u builduser yay -Sc --noconfirm
CMD bash

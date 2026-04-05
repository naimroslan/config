#!/bin/bash
set -e

sudo systemctl enable sddm
sudo systemctl enable NetworkManager

# Install VoidSDDM theme
if [ ! -d /usr/share/sddm/themes/voidsddm ]; then
    git clone https://github.com/talyamm/voidsddm.git /tmp/voidsddm
    sudo cp -r /tmp/voidsddm /usr/share/sddm/themes/voidsddm
    rm -rf /tmp/voidsddm
fi

printf '[Autologin]\nSession=hyprland\n\n[Theme]\nCurrent=voidsddm\n' | sudo tee /etc/sddm.conf

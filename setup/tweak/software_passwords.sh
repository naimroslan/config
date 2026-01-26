#!/bin/bash
sudo pacman -S --noconfirm rclone

# Create mount point
sudo mkdir -p /mnt/utility
# Create systemd mount unit (rclone)
sudo tee /etc/systemd/system/mnt-utility.mount > /dev/null <<'EOF'
[Unit]
Description=WebDAV mount for KeePass on utility server
After=network-online.target
Wants=network-online.target
[Mount]
What=:webdav:/
Where=/mnt/utility
Type=rclone
Options=rw,_netdev,allow_other,args2env,vfs-cache-mode=full,webdav-url=http://utility/
[Install]
WantedBy=multi-user.target
EOF
# Create systemd automount unit
sudo tee /etc/systemd/system/mnt-utility.automount > /dev/null <<'EOF'
[Unit]
Description=Automount WebDAV KeePass on access
After=network-online.target
[Automount]
Where=/mnt/utility
TimeoutIdleSec=300
[Install]
WantedBy=multi-user.target
EOF
# Enable FUSE allow_other
sudo sed -i 's/^#user_allow_other/user_allow_other/' /etc/fuse.conf
grep -q '^user_allow_other' /etc/fuse.conf || echo 'user_allow_other' | sudo tee -a /etc/fuse.conf > /dev/null

# Reload systemd and restart automount
sudo systemctl daemon-reload
sudo systemctl stop mnt-utility.mount 2>/dev/null || true
sudo systemctl enable --now mnt-utility.automount

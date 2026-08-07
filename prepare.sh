apt-get update
apt-get upgrade -y
useradd -m -G sudo -s /bin/bash builder
passwd -d builder

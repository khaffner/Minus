# Raspberry Pi OS Bullseye 64-bit with desktop

# Fix locale (select only en_US-UTF-8 UTF-8), patch
sudo raspi-config
sudo reboot
sudo apt update && sudo apt upgrade -y

# Docker
curl -sSL https://get.docker.com | sudo sh
sudo usermod -aG docker minus

# Docker Compose, https://dev.to/elalemanyo/how-to-install-docker-and-docker-compose-on-raspberry-pi-1mo
sudo apt-get install libffi-dev libssl-dev && sudo apt install python3-dev && sudo apt-get install -y python3 python3-pip && sudo pip3 install docker-compose

# GPSD
sudo apt install gpsd -y

cat /etc/default/gpsd | sudo sed -i 's;DEVICES="";DEVICES="/dev/serial/by-id/usb-Prolific_Technology_Inc._USB-Serial_Controller_D-if00-port0";' /etc/default/gpsd # Specifies what device is gps receiver

# SWAP https://askubuntu.com/questions/103915/how-do-i-configure-swappiness
sudo bash -c "echo 'vm.swappiness = 1' >> /etc/sysctl.conf"

# Clone project repo, lowercase repo
git clone https://github.com/khaffner/Minus.git
mv Minus/ minus/

# Configure Rclone, details in google doc

# Configure secrets
cd minus
cp secrets.env.template secrets.env
# and edit the content, instructions inside

######################################################### Examples for management

# Only start HA
docker-compose up -d homeassistant

# Change permissions on files in a docker volume
sudo chown -R minus:minus homeassistant_config/

# Edit HA config
nano homeassistant_config/configuration.yaml

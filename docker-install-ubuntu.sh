#!/bin/bash 

HL='\033[32;49;1m'
CL_HL='\033[0m'

set -o errexit
echo -e "${HL}Run as sudo or root${CL_HL}"

echo -e "${HL}Add Docker's official GPG key:${CL_HL}"

sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

read -p "Do you want to do post-installation steps? [Y,n]" post_install

case $post_install in 
    y|Y)   

    if [ $(getent group docker) ]; then
        echo "Docker group exists."
    else
        sudo groupadd docker
        
    fi

    sudo usermod -aG docker $USER
    newgrp docker <<EONG
exit
EONG
    
    echo -e "${HL}Post-installation step finished${CL_HL}";;

  
esac

echo -e "${HL}Finished docker installation${CL_HL}"


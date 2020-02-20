#!/bin/bash
#secure-ssh.sh
#author lkaine24
#creates a new ssh user using $1 parameter
#adds a public key from the local repo or curled from the remote repo
#removes roots ability to ssh in
user=$1
sudo useradd -m -d /home/$user -s /bin/bash $user
sudo mkdir /home/$user/.ssh
sudo cp /home/lucas/Tech-Journal/SYS265/linux/public-keys/id_rsa.pub /home/$user/.ssh/authorized_keys
sudo chmod 700 /home/$user/.ssh
sudo chmod 600 /home/$user/.ssh/authorized_keys
sudo chown -R $user:$user /home/$user/.ssh
sed -z 's/PermitRootLogin yes\|$/PermitRootLogin no/' /etc/ssh/sshd_config

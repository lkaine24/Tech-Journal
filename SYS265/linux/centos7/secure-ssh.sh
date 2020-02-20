#!/bin/bash
#secure-ssh.sh
#author lkaine24
#creates a new ssh user using $1 parameter
#adds a public key from the llocal repo or curled from the remote repo
#removes roots ability to ssh in
user=$1
useradd -m -d /home/$user -s /bin/bash $user
mkdir /home/$user/.ssh
mkdir /home/$user/.ssh/authorized_keys
cp /home/lucas/Tech-Journal/SYS265/linux/public-keys/id_rsa.pub /home/$user/.ssh/authorized_keys
sed -z 's/PermitRottLogin yes\|$/PermitRootLogin no/' /etc/ssh/sshd_config


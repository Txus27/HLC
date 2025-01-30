#!/bin/bash
# /etc/init.d/ssh start &

set -e

source /root/admin/usuarios/usuarios.sh
source /root/admin/ssh/ssh.sh

chmod +x /root/admin/usuarios/usuarios.sh
chmod +x /root/admin/ssh/ssh.sh

main(){
   newUser  
   newSSH
   # make_bienvenida

   # exec /usr/sbin/sshd -D &
    
}

main
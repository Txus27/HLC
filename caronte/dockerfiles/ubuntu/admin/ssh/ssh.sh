config_ssh(){
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
    if [ ! -d /home/${USUARIO}/.ssh ]
    then
        mkdir /home/${USUARIO}/.ssh
        cat /root/datos/id_ed25519.pub >> /home/${USUARIO}/.ssh/authorized_keys
    fi
    /etc/init.d/ssh start
}
#juanlu ALL=(ALL:ALL) ALL
config_sudoers(){
    if [ -f /etc/sudoers ]
    then
        #Comprobar que el ${USUARIO} NO existe.
        echo "${USUARIO} ALL=(ALL:ALL) ALL" >> /etc/sudoers
    fi
}

newSSH(){
    # Gestion de eroores y salida de logs
    config_ssh
    config_sudoers
}
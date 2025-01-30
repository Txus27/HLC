#!/bin/bash

#El orden de esta configuración es esencial, no se puede alterar:

set -e

config_git(){
    mkdir -p /home/${USUARIO}/app/
    cd /home/${USUARIO}/app
    git clone ${GITHUB}
}

config_react(){
    cd /home/${USUARIO}/app/${PROYECTO}
    npm install
    npm start &
    npm run build
    cp -rf ./build/* /var/www/html
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html
}

main(){
    /root/admin/nginx/start.sh
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
    config_git
    config_react
    #exec nginx -g 'daemon off;'
    tail -f /dev/null
}

main
#Este archivo funciona.
# #Para entrar al contenedor se usará mi IP del SO anfitrión de docker (En mi caso: 192.168.159.131:8081)
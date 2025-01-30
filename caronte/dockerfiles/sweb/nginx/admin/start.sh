#!/bin/bash

set -e

config_nginx(){
    # Para dejar el contenedor en ejecución en segundo plano
    nginx &

   # Mantener el contenedor activo ejecutando Nginx en primer plano
   # exec nginx -g "daemon off;"
   # Mantén el contenedor vivo
   # tail -f /dev/null
}

load_entrypoint_base(){
    # Ejecuta el Entrypoint de ubuntubase
    /root/admin/start.sh
}

#El orden de esta configuración en main es esencial, no se puede alterar:

main(){
    load_entrypoint_base
    config_nginx
    
    # tail -f /dev/null
}

main
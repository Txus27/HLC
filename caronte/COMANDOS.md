# Para ver lo que se va a generar al levantar el contenedor: 
  docker-compose --env-file .env -f docker-compose.yml config

# Levantar un contenedor:
  (Hay que estar en la terminal en el directorio DEPLOY del proyecto que vayamos a levantar): 

  docker-compose -f docker-compose.yml up -d --build

# Crear contenedores individuales basándose en la imagen ya creada del paso anterior usando docker-compose:
  docker run --name miservidor1 -e USUARIO=juanlu -e PASSWORD=usuario -p 8083:80  juanluissanchez/jls-nginx

# Ver contenedores levantados: 
  docker ps -a

# Entrar al contenedor: 
  docker exec -it <container_id> /bin/bash             

# Salir del contenedor:
  exit

# COMPROBAR SI HAY ERROR EN EL CONTENEDOR CON EL logs:
  docker logs "NombreContenedor"

# Hacer un usuario y hacerlo sudo: 
  1. **Crear el usuario**:

  sudo adduser juanlu

    Durante el proceso, se te pedirá que establezcas una contraseña.

  2. **Añadir el usuario al grupo sudo**:
    
  sudo usermod -aG sudo juanlu

  3. **Verificar que el usuario está en el grupo sudo**:
    
  groups juanlu

# Crear clave pública SSH:
  ssh-keygen
  **Y NO le ponemos contraseña a la clave ir_rsa.pub generada**

# SSH al contenedor (una vez está en ejecución el contenedor):
  ssh juanluis@172.120.10.3 -p 22   (ssh usuario@IP -p 22)

# Entrar a la WEB del contenedor y ver el contenido  de index.html:
  Hay que poner la IP de la MV anfitriona y el puerto al que lo hemos redirigido el contenedor en el fichero de configuración .env: 

# Detener el contenedor y borrar la imagen:
  docker compose --env-file .env -f docker-compose.yml down        

# Añadir más servicios al contenedor ejecutado desde el docker-compose:
  Tiene que estar dentro de services:

  servidor:
      build:
        context: ${CONTEXTO}
        dockerfile: ./dockerfiles/sweb/nginx/Dockerfile
        args: # Argumentos que uso en mi ubuntubase + los que usemos en el dockerfile nginx
          - CONTEXT=${CONTEXTO}
          - TZ=${TZ}
          - PROYECTO=${PROYECTO}
          - AUTOR=${AUTOR}
      image: ${AUTOR}/nginx2
      container_name: minginx2
      hostname: ${HOSTNAME}
      env_file:
        - ./.env
      environment:
        - USUARIO=${USUARIO}
        - PASSWORD=${PASSWD}
      ports:
        - "8082:80"
      volumes:
      - ./logs:/root/logs
      - ./html:/var/www/html
      networks:
        netcaronte:
          ipv4_address: 172.120.10.4

# ETIQUETAR UNA IMAGEN (TAG)
  - docker tag juanluissanchez/webcvalera:1.0 txus027/webcvalera:latest
  (docker tag NombreDeLaImagen:tag NombreDelRepositorio:tag)

# SUBIR IMAGEN A DOCKER HUB:
 - docker push txus027/webcvalera:latest
 (docker push NombreDelRepositorio:tag)


# NO COMPROBADOS:

(Original con volumen: docker run -v ./datos:/root/datos --name miservidor1 -e USUARIO=juanlu -e PASSWORD=usuario juanluissanchez/ubuntubase)


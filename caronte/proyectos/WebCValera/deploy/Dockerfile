#Descargo la imagen de ubuntu
FROM ubuntu:latest
#Actualizo los repositorios de ubuntu
RUN apt-get update
# Establezco la variable timezone
ENV TZ=Europe/Madrid
# Creo el fichero para configurar el TimeZone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#Instalo Nginx
RUN apt-get install -y nginx
# Le meto contenido a la web de Nginx
RUN echo 'Ejemplo de POD con Kubernetes y YAML' > /var/www/html/index.html
# Arranco Nginx con este entrypoint
ENTRYPOINT ["usr/sbin/nginx", "-g", "daemon off;"]
# Expongo el puerto 80 - tiene que coincidir con el del deploy.yml
EXPOSE 80
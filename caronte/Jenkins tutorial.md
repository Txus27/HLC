# Creamos el docker-compose.yml
    #Docker-compose.yml
    version: '3.8'
    services:
    jenkins:
        image: jenkins/jenkins:lts
        privileged: true
        user: root
        ports:
        - 8080:8080
        - 50000:50000
        container_name: jenkins
        volumes:
        - ./jenkins_home/var/jenkins_home
        - /var/run/docker.sock:/var/run/docker.sock
# Levantamos el contenedor estando en la ruta de servicio/  jenkins, con el comando:
    docker-compose -f docker-compose.yml up -d --build
# Entramos a jenkins desde:
    http://173.249.19.114:8080/
# Ponemos la clave que esta en la ruta del contenedor

# Instalamos los Pluggins sugeridos
# Creamos el usuario administrador

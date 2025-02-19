# La primera vez que lo instalas, hay que descargar minikube y por separado kubectl

# Iniciamos el programa con: 
    minikube start

# Siempre detener la imagen antes de salir:
    minikube stop

# Eliminar minikube:
    minikube delete

minikube ip <IpDelAnfitrión> (192.168.159.131)
minikube ssh

# Para ver los datos de minikube:
    minikube profile list

# Para entrar a un contenedor es:
    <IpDelAnfitrión>:<PuertoRedireccionado> (http://192.168.159.137:8085)

# Para ver los archivos ocultos: 
    ls -la /home/juanlu/

# Para ver el DEPLOY que tengo en ejecución:
    kubectl get deploy

# Para ver los pods en ejecución: 
    kubectl get pods

# Para aver información del cluster: 
    cat home/juanlu/.kube/config 

# Para ver detalles del pod: 

    kubectl describe pods <NombreDelPod>

# Para entar a un pod: 

    kubectl exec -it <NombreDelPod> -- /bin/bash

# Para borrar un pod: 

    kubectl delete pods <NombreDelPod> -> EJ: kubectl delete pod nginx3

# Borrar un servicio:
    kubectl get services
    kubectl delete service <NombreServivio> 
    - EJ: kubectl delete service webcv-d

# Aplicar el manifiesto
kubectl apply -f <NombreFicheroYaml> 
    Ejemplos: 
        kubectl apply -f nginx.yml
        kubectl apply -f deploy.yaml
        kubectl apply -f servicio.yml
        kubectl apply -f servicioLB.yml (Con balanceador de carga)

# Volcar el fichero .env dentro de kubernetes a traves del comando ConfigMap (Hacer cada vez que borre todos los datos)

    kubectl create configmap app-env --from-env-file=.env

# Verifica si el comando anterior se ha hecho bien:

    kubectl get configmap app-env -o yaml
(app-env es el nombre que le hemos puesto a lo que ha creado configMap, que nos ha pasado el contenido del archivo .env)

# Para ver una interfaz grafica de MINIKUBE:
  minikube dashboard (Y me da una URL para abrir en el navegador)

# Para aumentar o disminuir el número de réplicas de un deploy (número de pods en ejecución)
    kubectl scale deploy <Metadata-name> --replicas=<NumeroDeseado>
    EJ= kubectl scale deploy webcv-d --replicas=3

# Para ver los servicios en ejecución
    kubectl get services

# Redirigir puertos desde tu máquina local a un servicio dentro de un clúster de Kubernetes, aplicamos un Port-Forward:
    kubectl port-forward svc/webcv-s 30080:80

# Conexion limpia con un tunel -> (Cuando usamos LoadBalancer)
    minikube tunnel --bind-address=0.0.0.0 --cleanup
# Y accedemos con la IP de la maquina anfitriona(Ubuntu Server) y el puerto especificado en el servicio -> (Cuando usamos LoadBalancer):
    http://192.168.159.137:8088/

# Para hacer una redireccion de puertos y entrar desde el exterior a traves del navegador (Los pods deben estar en ejecución) -> (Cuando usamos NodePort)
    kubectl port-forward --address 0.0.0.0 services/webcv-s 8083:80

# Ya puedo entrar al servicio a través de la IP de la maquina que ejecuta el servicio de Kubernetes y el puerto que he redirigido -> (Cuando usamos NodePort):
        http://192.168.159.137:8083/
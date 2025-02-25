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

# Crear una NAMESPACE:
     kubectl create namespace <NombreNameSpace> 
     --> kubectl create namespace jenkins-sp

# Crear un VOLUMEN PERSISTENTE:
    kubectl apply -f <NombreArchivo> --> kubectl apply -f pvc.yaml 

CREAR DOCUMENTO pvc.yaml:
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: jenkins
  namespace: jenkins-sp
spec:
  resources:
    requests:
      storage: 8Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce

# Para ver los datos del VOLUMEN PERSISTENTE:
    kubectl get pvc -n <NameSpace> --> kubectl get pvc -n jenkins-sp

# Para ver los datos del LoadBalancer del NameSpace
# Para ver volumenes
    kubectl get svc -n jenkins-sp
# Peara ver servicios
    kubectl get services -n jenkins-sp

# Para borrar un servicio
    kubectl delete svc jenkins -n jenkins-sp

# Borrar el NAMESPACE
    kubectl delete namespace ingress-nginx

# Para borrar todo el contenido del NAMESPACE
    kubectl delete all --all -n <nombre_del_namespace>
        -> kubectl delete all --all -n jenkins-sp


## DE FREDI para entrar en Jenkins ##
# Proceso de despliegue de jenkins en kubernetes #
##################################################

# 1. Crear un namespace
kubectl create namespace jenkins-sp
kubectl get namespace                   # Verificar el namespace

# 2. Levantar un persistent volume claim (pvc)
kubectl apply -f pvc.yaml
kubectl get pvc -n jenkins-sp           # Verificar el pvc

# 3. Levantar un deployment
kubectl apply -f deploy.yaml
kubectl get deploy -n jenkins-sp        # Verificar el deployment

# 4. Crear un Tunnel - para acceder al servicio desde el exterior del clúster
minikube tunnel --bind-address=0.0.0.0 --cleanup     # Abrir ( En otra terminal )

# 5. Leavantar un servicio
kubectl apply -f service.yaml
kubectl get svc -n jenkins-sp           # Verificar el servicio

#### INGRESAR JENKIS
    ------ INGRESANDO A JENKINS DESDE AFUERA------
    http://161.97.91.36:8070/login?from=%2F

    ingresar la clave 
    1ero saber el nombre del pods creado
        kubectl get pods -n jenkins-sp
    --- buscamos la clave de esta ID--------
        kubectl logs jenkins-6c955dd78f-fnd5j -n 
    jenkins-sp
    mi clave:   666

    jenkis url http://161.97.91.36:8070/

# ** Instalación de Jenkins desde NodePort **
# Aplicamos el servicio de NodePort
    kubectl apply -f serviceND.yaml

# Para ver el servicio que he desplegado
    kubectl get services -n jenkins-sp

# Para acceder desde internet
    minikube service jenkins-svc -n jenkins-sp --url
# Para hacer un tunel por
    kubectl port-forward --address 0.0.0.0 services/jenkins-svc 8084:8081 -n jenkins-sp
    ** Se entra desde aqui IpVPS:Puerto: http://173.249.19.114:8084/ **

# ** Nginx Ingress Controller **

# Primero instalamos Helm (Gestor de paquetes de kubernetees)
    sudo snap install helm --classic

# Para ver la version de Helm 
    helm version

# Para BORRAR Helm
    sudo snap remove helm

# Para ACTUALIZAR Helm
    sudo snap refresh helm

# Instalar NGINX Ingress

    minikube addons enable ingress

    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

    helm repo update

    helm install nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace

# Ver la lista de ese namespace
    helm list -n ingress-nginx

# Borrar el Ingress
    kubectl delete ingressclass nginx

# Borrar ClusterRole
    kubectl delete clusterrole nginx-ingress-ingress-nginx

# Eliminar el ValidatingWebhookConfiguration conflictivo
    kubectl delete validatingwebhookconfiguration nginx-ingress-ingress-nginx-admission

# Para ver los PODS de un NAMESPACE
    kubectl get pods -n ingress-nginx

# Para Ver el SERVICIO en un NAMESPACE (Ver la IP para acceder)
    kubectl get svc -n ingress-nginx

# Para ver los SERVICIOS (Ver la IP para acceder)
    kubectl get services

# Para cambiar el tipo de ClusterIP a NodePort
    kubectl patch svc nginx-ingress-controller -n ingress-nginx -p '{"spec": {"type": "NodePort"}}'

# Para ver la IP interna de MINIKUBE
    kubectl get nodes -o wide

# Para ver si tengo conexion con la INTERNAL IP del MINIKUBE y el Puerto del NodePort
    nc -zv 192.168.58.2 31252
# Ver el contenido que me devuelve 
    curl http://192.168.58.2:31252
#
    
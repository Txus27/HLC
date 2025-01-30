# Iniciamos el programa con: minikube start
minikube ip <IpDelAnfitrión> (192.168.159.131)
minikube ssh

# Para entrar a un contenedor es:
    <IpDelAnfitrión>:<PuertoRedireccionado> (http://192.168.159.131:8085)

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

# Aplicar el manifiesto
kubectl apply -f <NombreFicheroYaml> -> EJ: kubectl apply -f nginx.yaml

# Volcar el fichero .env dentro de kubernetes a traves del comando ConfigMap

    kubectl create configmap app-env --from-env-file=.env

# Verifica si el comando anterior se ha hecho bien:

    kubectl get configmap app-env -o yaml
(app-env es el nombre que le hemos puesto a lo que ha creado configMap, que nos ha pasado el contenido del archivo .env)

# Para ver una interfaz grafica de MINIKUBE:
  minikube dashboard (Y me da una URL para abrir en el navegador)

# Para aumentar o disminuir el número de réplicas de un deploy (número de pods en ejecución)
    kubectl scale deploy <Metadata-name> --replicas=<NumeroDeseado>
    EJ= kubectl scale deploy webcv-d --replicas=3

# 

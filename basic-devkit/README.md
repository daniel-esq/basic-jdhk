This project will allow you to setup a dev environment locally. 

The following projects structure must be respected:

* **basic-jdhk**
    * basic-devkit
    * basic-helm-charts
    * basic-java


### Requirements
1. **Docker** Installation instructions can be found [here](https://docs.docker.com/docker-for-windows/install/)
    * *Docker Compose version 3.7* [here](https://docs.docker.com/compose/compose-file/compose-versioning/#version-37)
2. **Minikube** Installation instructions can be found [here](https://kubernetes.io/docs/tasks/tools/install-minikube/)
    
    

### Docker
Install the application in your local docker:
~~~
docker-compose up -d --build basic-java 
~~~
 
Inspect images:
~~~
docker images
~~~
_Expected output example:_
~~~
REPOSITORY                TAG                 IMAGE ID            CREATED             SIZE
basic-java                latest              110eb6e49908        43 minutes ago      140MB
~~~

Display containers:
~~~
docker ps
~~~
_Expected output example:_
~~~
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
172b98ff0353        basic-java          "/bin/sh -c /docker-…"   44 minutes ago      Up 43 minutes       0.0.0.0:8182->8181/tcp   basic-devkit_basic-java_1
~~~

Stop all containers:
~~~
docker-compose down
~~~ 

Remove image:
~~~
 docker image rm <IMAGE ID>
~~~ 
 
 
 
### Minikube
Minikube is a single kubernetes cluster and single-node tool that runs on a local virtual machine.

**Note:** _Because it runs on a virtual machine you don't need to have docker running._


#### Initialise cluster
If minikube has never run on your computer or the cluster has been deleted, the following **minikube-install.sh** script will
help with the creation of the cluster and the build of all required images.

**Note:** Always run with the **source** command (or **.** before the script) to load  
the result from _eval $(minikube -p minikube docker-env)_ into the current shell.

~~~
Option 1:
 source ./minikube-install.sh -mb
 
Option 2:
 . ./minikube-install.sh -mb
~~~  


##### Script optional arguments
Install only the minikube cluster: 
~~~
 . ./minikube-install.sh -m
~~~  

Install only the docker image of the application:
~~~
 . ./minikube-install.sh -b
~~~  

**Note:** The execution of this script will configure your local environment to point the Docker daemon inside the Minikube instance.

This way you can build and run docker images inside the minikube environment which will make your installations easier 
than the use of a docker registry or the minikube registry addon. 


##### Minikube status
To check the status of your minikube you can run the following command:
~~~
 minikube status
~~~

_Expected output example:_
~~~
m01
host: Stopped
kubelet: Stopped
apiserver: Stopped
kubeconfig: Stopped
~~~


##### Start minikube
~~~
 minikube start
~~~

_Expected output example:_ (from the **minikube status** command)
~~~
m01
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
~~~
   
        
##### Start dashboard
Minikube has a dashboard addon enabled by default that helps developers monitor the status of the cluster.

_Run the below command in a different terminal tab:_
~~~
 minikube dashboard
~~~

Inspect minikube addons with the command:
~~~
minikube addons list
~~~


##### Stop minikube
~~~
 minikube stop
~~~



### Resolve minikube ingress-host
The **minikube-network.sh** will add the entry _minikube-ip:ingress-host_ in your local **/etc/hosts** file
so kubernetes services become reachable through ingress.
~~~
 ./minikube-network.sh
~~~

After you run the script you should be able to use the ingress host to access the service.

To check the result of the script run:
~~~
cat /etc/hosts
~~~
_Expected output example:_
~~~
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1	localhost
255.255.255.255	broadcasthost
::1             localhost
# Added by Docker Desktop
# To allow the same kube context to work on the host and the container:
127.0.0.1 kubernetes.docker.internal
# End of section
192.168.64.21 basic-java-default-minikube.service.np.info  <-------- This is the new entry added by the script
~~~

To retrieve the ingress HOST from kubernetes run the following command:
~~~
kubectl get ing
~~~

_Expected output example:_
~~~
NAME                      CLASS    HOSTS                                                             ADDRESS         PORTS   AGE
basic-java                <none>   basic-java-default-minikube.service.np.info                       192.168.64.21   80      42s
~~~


**Note:** The scripts needs to be executed every time the minikube cluster is deleted 
or every time minikube virtual machine ip changes.

Also, the  execution will require your admin password in order to be able to edit the hosts file.
    
   

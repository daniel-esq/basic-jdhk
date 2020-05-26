#!/bin/bash

INIT_MINIKUBE=false
INSTALL_BASIC_JAVA=false


while getopts 'mb' option
    do
        case "${option}" in
            m)
                INIT_MINIKUBE=true
                echo "Argument passed: INIT_MINIKUBE: $INIT_MINIKUBE";;
            b)
                INSTALL_BASIC_JAVA=true
                echo "Argument passed: INSTALL_BASIC_JAVA: $INSTALL_BASIC_JAVA";;
    esac
done



if $INIT_MINIKUBE; then

    echo "Destroy existing minikube cluster"
    minikube delete

    minikube start --cpus 4 --memory 4096 --disk-size 5g
    minikube addons enable ingress
    minikube addons enable helm-tiller
    minikube addons enable metrics-server

    # Registry addon exposes its port 5000 on the minikube’s virtual machine
    minikube addons enable registry

fi



if minikube status | grep -q "host:\ Running"; then
    echo "Point minikube-docker environment"

    # This will only make the changes for the current session
    # and will get reset when you restart are your bash terminal
    eval $(minikube -p minikube docker-env)
else
    echo "Minikube is not running!"
fi



if $INSTALL_BASIC_JAVA; then

    echo "Build and install components"

    # Build component package
    mvn -f ../basic-java/pom.xml clean package

    # Build component docker image
    docker-compose -f docker-compose.yml build basic-java
    docker tag basic-java minikube/basic-java
    docker image rm basic-java

fi

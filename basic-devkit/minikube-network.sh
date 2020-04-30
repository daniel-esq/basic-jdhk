#!/bin/bash

export MINIKUBE_IP=$(minikube ip)

SUFFIX=-default-minikube.service.np.info
export BASIC_JAVA=basic-java${SUFFIX}

sudo bash -i <<EOF
    sed -ie "/$BASIC_JAVA/d" /etc/hosts
    echo "$MINIKUBE_IP $BASIC_JAVA" | tee -a /etc/hosts
EOF
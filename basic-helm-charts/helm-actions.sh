#!/bin/bash

export UMBRELLA_CHART=charts/basic-umbrella-chart
export VALUES_FILE_LOCAL=$UMBRELLA_CHART/local-minikube-values.yaml


TEMPLATE=false
INSTALL=false
UPGRADE=false
DELETE=false


while getopts 'tiud' option
    do
        case "${option}" in
            t)
                TEMPLATE=true
                echo "Template";;
            i)
                INSTALL=true
                echo "Install";;
            u)
                UPGRADE=true
                echo "Upgrade";;
            d)
                DELETE=true
                echo "Delete";;
    esac
done


if $TEMPLATE; then
    helm dependency update $UMBRELLA_CHART
    helm template $UMBRELLA_CHART -f $VALUES_FILE_LOCAL -n default
fi

if $INSTALL; then
    helm dependency update $UMBRELLA_CHART
    helm install basic $UMBRELLA_CHART -f $VALUES_FILE_LOCAL -n default
fi

if $UPGRADE; then
    helm dependency update $UMBRELLA_CHART
    helm upgrade basic $UMBRELLA_CHART -f $VALUES_FILE_LOCAL -n default
fi

if $DELETE; then
    helm delete basic
fi

#!/bin/sh

set -e

export RUNNING_ENVIRONMENT=${RUNNING_ENVIRONMENT}

exec java ${JAVA_OPTS} -jar basic-java.jar

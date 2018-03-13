#!/bin/sh

# Variables
BASEDIR=$(dirname "$0")
. "${HOME}/.bash_profile"

# Initial configuration
if [ ! -f "${BASEDIR}/env" ]; then
	printf "Insert your docker projects folder: "
	read DOCKER_HOME
	printf "Insert your docker volume folder: "
	read DOCKER_VOLUMES
	echo "DOCKER_HOME=${DOCKER_HOME}" >> env
	echo "DOCKER_VOLUMES=${DOCKER_VOLUMES}" >>  env
fi

# Params
CONTAINER_NAME=$1

# Testing container name
if [ -d "${DOCKER_HOME}/${CONTAINER_NAME}" ]; then
    echo "!! Container name already exsists !!"
    exit 1
fi    

# Creating the scaffold
mkdir -p "${DOCKER_HOME}/${CONTAINER_NAME}"
mkdir -p "${DOCKER_VOLUMES}/${CONTAINER_NAME}"

# Copping ENV
cat "${BASEDIR=}/env" > "${DOCKER_HOME}/${CONTAINER_NAME}/.env"

# Filling the files with the skeleton
cat "${BASEDIR}/Dockerfile" | sed -e "s/##CONTAINER##/$CONTAINER_NAME/g" > "${DOCKER_HOME}/${CONTAINER_NAME}/Dockerfile"
cat "${BASEDIR}/docker-compose.yml" | sed -e "s/##CONTAINER##/$CONTAINER_NAME/g"  > "${DOCKER_HOME}/${CONTAINER_NAME}/docker-compose.yml" 



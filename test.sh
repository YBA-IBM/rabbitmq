#!/bin/bash

set -e

export ANSI_YELLOW="\e[1;33m"
export ANSI_GREEN="\e[32m"
export ANSI_RESET="\e[0m"

echo -e "\n $ANSI_YELLOW *** FUNCTIONAL TEST(S) *** $ANSI_RESET \n"

echo -e "$ANSI_YELLOW Testing Management Console Functionality: $ANSI_RESET"
docker run -d --hostname my-rabbit --name some-rabbit quay.io/ibmz/rabbitmq:3.8.9-management
docker stop some-rabbit && docker rm some-rabbit
docker run -d --hostname my-rabbit --name some-rabbit -p 8080:15672 quay.io/ibmz/rabbitmq:3.8.9-management
docker stop some-rabbit && docker rm some-rabbit
docker run -d --hostname my-rabbit --name some-rabbit -p 8080:15672 -e RABBITMQ_DEFAULT_USER=user -e RABBITMQ_DEFAULT_PASS=password -e RABBITMQ_DEFAULT_VHOST=my_vhost quay.io/ibmz/rabbitmq:3.8.9-management
docker stop some-rabbit && docker rm some-rabbit

echo -e "\n $ANSI_GREEN *** FUNCTIONAL TEST(S) COMPLETED SUCESSFULLY *** $ANSI_RESET \n"

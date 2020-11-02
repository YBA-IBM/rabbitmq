#!/bin/bash

set -e

export ANSI_YELLOW="\e[1;33m"
export ANSI_GREEN="\e[32m"
export ANSI_RESET="\e[0m"

echo -e "\n $ANSI_YELLOW *** FUNCTIONAL TEST(S) *** $ANSI_RESET \n"

echo -e "$ANSI_YELLOW Testing rabbitmq functionality: $ANSI_RESET"
docker run -d --hostname my-rabbit --name some-rabbit quay.io/ibmz/rabbitmq:3.8.9
docker logs some-rabbit
docker stop some-rabbit && docker rm some-rabbit
docker network create some-network
docker run -d --hostname some-rabbit --name some-rabbit --network some-network -e RABBITMQ_ERLANG_COOKIE='secret cookie here' quay.io/ibmz/rabbitmq:3.8.9
docker run -i --rm --network some-network -e RABBITMQ_ERLANG_COOKIE='secret cookie here' quay.io/ibmz/rabbitmq:3.8.9 rabbitmqctl -n rabbit@some-rabbit list_users
docker run -i --rm --network some-network -e RABBITMQ_ERLANG_COOKIE='secret cookie here' -e RABBITMQ_NODENAME=rabbit@some-rabbit quay.io/ibmz/rabbitmq:3.8.9 rabbitmqctl list_users

echo -e "\n $ANSI_GREEN *** FUNCTIONAL TEST(S) COMPLETED SUCESSFULLY *** $ANSI_RESET \n"

#!/bin/bash -eu
docker ps -a | grep slowloop_goods_api | awk '{print $1}' | xargs docker rm
docker volume ls | grep slowloop_goods_api | awk '{print $2}' | xargs docker volume rm
docker image ls | grep slowloop_goods_api | awk '{print $1}' | xargs docker image rm

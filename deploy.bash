#!/usr/bin/env bash

kubectl create deployment generator --image=surmava/minesweeper-generator:0.0.1 --port 8000 -r 1
kubectl expose deployment generator --name=generator-service --port 8000 --target-port 8000 --type ClusterIP

# get previous cluster ip
GENERATORIP=$(kubectl describe services generator-service | sed -n '/^IP:/ s/[^0-9]*//p')
if [[ -z $GENERATORIP ]]; then
	echo Could not get cluster IP of the generator. Waiting and repeating the command could solve the issue.
	exit 1
fi

kubectl create deployment backend --image=surmava/minesweeper-backend:0.0.1 --port 8080 -r 1 -- node index.js "${GENERATORIP}:8000"
kubectl expose deployment backend --name=backend-service --port 8080 --target-port 8080 --type LoadBalancer

# get previous external ip
BACKENDIP=$(kubectl describe services frontend | sed -nE '/LoadBalancer Ingress/ s/^[^0-9]*([^(]*).*$/\1/p')
if [[ -z $BACKENDIP ]]; then
	echo Could not get public IP of the backend. Waiting and repeating the command could solve the issue.
	exit 1
fi

kubectl create deployment frontend --image=surmava/minesweeper-frontend:0.0.1 --port 80 -r 1 -- /usr/local/bin/run.sh "${BACKENDIP}:8080"
kubectl expose deployment frontend --name=frontend-service --port 80 --target-port 80 --type LoadBalancer

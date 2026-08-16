# Minesweeper

This is a project for CloudIT course.

The __deploy.bash__ script contains a set of __kubectl__ commands to deploy this project in a Kubernetes cluster.
A script is a better option than yaml files in this case, because the frontend containers need the public IP of the backend in order to start. The latter can't be known before the start of deployment.
The script also contains kubectl commands together with sed commands to get the required IP addresses.

Since kubectl needs some time to set up the deployments and services, I recommend to copy and execute the script line by line, instead of running it directly.


## Sub-Projects
- [Map Generator](https://github.com/surmavagit/minesweeper-generator)
- [Backend](https://github.com/surmavagit/minesweeper-backend)
- [Frontend](https://github.com/surmavagit/minesweeper-frontend)

Each project is dockerised and pushed to DockerHub.

Images are __publicly available__ as:
- surmava/minesweeper-generator
- surmava/minesweeper-backend
- surmava/minesweeper-frontend

Minesweeper is implemented with __Microservices Architecture__.
Specifically, generation of maps for every game is separated into an independent microservice.

The frontend is a collection of static files. The end user communicates directly both with the frontend server and the backend server. This means that the address of the backend server needs to be (a) public and (b) included in the static files, served by the frontend server.

Unlike the frontend and backend servers, the map generator is not exposed to the internet. Communication between the backend and the generator happens within the kubernetes network and uses Cluster IP.

## Azure

The whole project is deployed on Azure Kubernetes Services.
[Minesweeper on AKS](http://134.112.146.202/)

# Minesweeper

This is a project for CloudIT course.

The __deploy.bash__ script contains a set of __kubectl__ commands to deploy this project in a Kubernetes cluster.
A script is a better option than yaml files in this case, because the frontend containers need the public IP of the backend in order to start. The latter can't be known before the start of deployment.
The script also contains kubectl commands together with sed commands to get the required IP addresses.

Since kubectl needs some time to set up the deployments and services, I recommend to copy and execute the script line by line, instead of running it directly.


## Sub-Projects
- [Map Generator](github.com/surmavagit/minesweeper-generator)
- [Backend](github.com/surmavagit/minesweeper-backend)
- [Frontend](github.com/surmavagit/minesweeper-frontend)

  Each project is dockerised and pushed to DockerHub.

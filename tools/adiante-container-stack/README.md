
# Working with the compose files
## Publishing new Images on Docker Hub
### Build new Image
```
docker build -t [ImageName] .
```
### Tag an existing image
```
docker tag [ImageLocalName] [dockerHubUserName]/[ImageName]
```
**REMARK**: Previous to push it's needed to login using a valid access token generated on DockerHub. IE: login -u _[dokerHubUserNAme]_
### Push tag
```
docker push [dockerHubUserName]/[ImageName]
```

## Running dependencies with docker
Open a terminal in the repo root folder, and run `docker compose -f .\build\docker-compose.yaml up -d`.

## Running apps with docker
Open a terminal in the repo root folder, and run `docker compose -f .\build\docker-compose.yaml -f .\build\docker-compose-apps.yaml up --build -d`.

You can run selectively an application like following:
`docker compose -f .\build\docker-compose.yaml -f .\build\docker-compose-apps.yaml up --build -d luckiatemplateservice`

## Stop containers
Run `docker compose -f .\build\docker-compose.yaml -f .\build\docker-compose-apps.yaml down` to stop all containers.

## Tools
* Grafana with AdiantePatientBackedEnd reports with metrics and application logs. Access on http://localhost:3000/ using admin/password1 credentials.



# README

## Links

- Workshop Labs: https://training.apim.eu/
- Workshop Solution: https://training.apim.eu/solutions
- Kong Plugins: https://docs.konghq.com/hub/

## Lab Environment

- <https://training.apim.eu/env/docker/>
- Enterprise 1.3.0
- PostgreSQL (?) - Missing the actual PostgreSQL version, in the lab previously only said latest, choose the local docker image file, or try 9.6.20. In the `docker-compose.yml` also need to modify the image tag from latest to the actual version number.

```bash
cd "book/API Gateway - Kong/Kong.Kong Workshop.2019/Software/"

docker load -i kong-ee-1.3.0.tar.gz
docker load -i postgres.tar.gz # Here is not good that mark it as "latest", be careful conflicting with the installed one.

docker images
docker images | grep kong
kong-docker-kong-enterprise-edition-docker.bintray.io/kong-enterprise-edition   1.3-alpine          1eb567947527        13 months ago       189MB

# Update the License/kong-ee-1.3.0/kong-se-license.json value to docker-compose.yml (total 2 places to change)
docker-compose up -d # I do not move the actual one to here because there is password inside the lab docker-compose file.
# Be careful there is running postgresql existing in your laptop.

docker container ls
KONG_CONTAINER_ID=$(docker container ls | grep kong-ent | cut -d ' ' -f1) && docker logs ${KONG_CONTAINER_ID}
# If below link failed, check this, mostly because the license is expired
open http://localhost:8002/overview

docker-compose stop

# You can enable the volumes by uncomment below in docker-compose.yml
volumes:
  - ./postgres-data:/var/lib/postgresql/data
```

docker run --name keycloak --hostname keycloak \
  --network=bridge -d -p 8080:8080 \
  -e KEYCLOAK_HOSTNAME=keycloak \
  -e KEYCLOAK_USER=admin \
  -e KEYCLOAK_PASSWORD=keycloak \
  -e DB_VENDOR=h2 \
  jboss/keycloak
docker network connect kong-net keycloak

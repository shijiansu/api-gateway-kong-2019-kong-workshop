docker run -d --name kong-ee --link kong-ee-database:kong-ee-database \
  -e "KONG_DATABASE=postgres" \
  -e "KONG_PG_HOST=kong-ee-database" \
  -e "KONG_CASSANDRA_CONTACT_POINTS=kong-ee-database" \
  -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
  -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
  -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
  -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
  -e "KONG_ADMIN_LISTEN=0.0.0.0:8001 , 0.0.0.0:8444 ssl" \
  -e "KONG_PORTAL=on" \
  -e "KONG_ENFORCE_RBAC=off" \
  -e "KONG_ADMIN_GUI_URL=http://kong-ee:8002" \
  -e "KONG_AUDIT_LOG=on" \
  -e "KONG_PORTAL_GUI_PROTOCOL=https" \
  -e "KONG_PORTAL_GUI_HOST=kong-ee:8446" \
  -e "KONG_LICENSE_DATA=$KONG_LICENSE_DATA" \
  -p 8000-8004:8000-8004 \
  -p 8443-8447:8443-8447 \
  kong-ee

http :8001/services name=httpbinservice url='http://httpbin.org'
http :8001/services/httpbinservice/routes name='httpbinroute' paths:='["/httpbin"]'
http post :8001/workspaces name=SalesAPIs
http :8001/SalesAPIs/services name=quoteservice url='http://httpbin.org'
http :8001/SalesAPIs/services/quoteservice/routes name='quoteroute' paths:='["/quote"]'
http :8001/SalesAPIs/routes/quoteroute/plugins name=tcp-log config:='{"host": "logstash", "port": 5044}'
http post :8001/workspaces name=ServicesAPIs
http :8001/ServicesAPIs/services name=visitservice url='http://httpbin.org'
http :8001/ServicesAPIs/services/visitservice/routes name='visitroute' paths:='["/visit"]'
http :8001/ServicesAPIs/routes/visitroute/plugins name=openid-connect config:='{"auth_methods": ["introspection"], "cache_introspection": false, "client_id": ["kong"], "client_secret": ["34a14df7-ecdf-4fac-97ce-63562f778ec5"], "introspect_jwt_tokens": true, "introspection_endpoint": "http://keycloak:8080/auth/realms/kong/protocol/openid-connect/token/introspect", "issuer": "http://keycloak:8080/auth/realms/kong"}'

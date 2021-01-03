```bash
# studying this example in progress
http post localhost:8001/services/httpbin/routes name=oidc-route paths:='["/oidc"]'

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 411
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:46:27 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: 5EmSnY8RUrKZJEVMVjW3vkVx5BPiZLcL

{
    "created_at": 1607618787,
    "destinations": null,
    "headers": null,
    "hosts": null,
    "https_redirect_status_code": 426,
    "id": "173fff1b-a871-4118-825e-d04809113484",
    "methods": null,
    "name": "oidc-route",
    "paths": [
        "/oidc"
    ],
    "preserve_host": false,
    "protocols": [
        "http",
        "https"
    ],
    "regex_priority": 0,
    "service": {
        "id": "40b281b2-e930-4af0-9ac0-041203216c12"
    },
    "snis": null,
    "sources": null,
    "strip_path": true,
    "tags": null,
    "updated_at": 1607618787
}

http -f post localhost:8001/routes/oidc-route/plugins name=openid-connect \
  config.issuer=https://keycloak.apim.eu/auth/realms/kong/.well-known/openid-configuration \
  config.client_id=client1 \
  config.client_secret=aeb992d5-4be4-4125-857b-6210776321d2 \
  config.ssl_verify=false \
  config.verify_signature=false \
  config.redirect_uri=http://localhost:8000/oidc
HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 5080
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:46:52 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: u9TVjinhxejws4FMXRHaZFsG8dWJk2Ap

{
    "config": {
        "anonymous": null,
        "audience": null,
        "audience_claim": [
            "aud"
        ],
        "audience_required": null,
        "auth_methods": [
            "password",
            "client_credentials",
            "authorization_code",
            "bearer",
            "introspection",
            "kong_oauth2",
            "refresh_token",
            "session"
        ],
        "authenticated_groups_claim": null,
        "authorization_cookie_domain": null,
        "authorization_cookie_httponly": true,
        "authorization_cookie_lifetime": 600,
        "authorization_cookie_name": "authorization",
        "authorization_cookie_path": "/",
        "authorization_cookie_samesite": "off",
        "authorization_cookie_secure": null,
        "authorization_endpoint": null,
        "authorization_query_args_client": null,
        "authorization_query_args_names": null,
        "authorization_query_args_values": null,
        "bearer_token_param_type": [
            "header",
            "query",
            "body"
        ],
        "cache_introspection": true,
        "cache_token_exchange": true,
        "cache_tokens": true,
        "cache_ttl": 3600,
        "cache_ttl_max": null,
        "cache_ttl_min": null,
        "cache_ttl_neg": null,
        "cache_ttl_resurrect": null,
        "cache_user_info": true,
        "client_arg": "client_id",
        "client_credentials_param_type": [
            "header",
            "query",
            "body"
        ],
        "client_id": [
            "client1"
        ],
        "client_secret": [
            "aeb992d5-4be4-4125-857b-6210776321d2"
        ],
        "consumer_by": [
            "username",
            "custom_id"
        ],
        "consumer_claim": null,
        "consumer_optional": false,
        "credential_claim": [
            "sub"
        ],
        "discovery_headers_names": null,
        "discovery_headers_values": null,
        "domains": null,
        "downstream_access_token_header": null,
        "downstream_access_token_jwk_header": null,
        "downstream_headers_claims": null,
        "downstream_headers_names": null,
        "downstream_id_token_header": null,
        "downstream_id_token_jwk_header": null,
        "downstream_introspection_header": null,
        "downstream_refresh_token_header": null,
        "downstream_session_id_header": null,
        "downstream_user_info_header": null,
        "end_session_endpoint": null,
        "extra_jwks_uris": null,
        "forbidden_destroy_session": true,
        "forbidden_error_message": "Forbidden",
        "forbidden_redirect_uri": null,
        "hide_credentials": false,
        "http_proxy": null,
        "http_proxy_authorization": null,
        "http_version": 1.1,
        "https_proxy": null,
        "https_proxy_authorization": null,
        "id_token_param_name": null,
        "id_token_param_type": [
            "header",
            "query",
            "body"
        ],
        "ignore_signature": [],
        "introspect_jwt_tokens": false,
        "introspection_endpoint": null,
        "introspection_headers_names": null,
        "introspection_headers_values": null,
        "introspection_hint": "access_token",
        "introspection_post_args_names": null,
        "introspection_post_args_values": null,
        "issuer": "https://keycloak.apim.eu/auth/realms/kong/.well-known/openid-configuration",
        "jwt_session_claim": "sid",
        "jwt_session_cookie": null,
        "keepalive": true,
        "leeway": 0,
        "login_action": "upstream",
        "login_methods": [
            "authorization_code"
        ],
        "login_redirect_mode": "fragment",
        "login_redirect_uri": null,
        "login_tokens": [
            "id_token"
        ],
        "logout_methods": [
            "POST",
            "DELETE"
        ],
        "logout_post_arg": null,
        "logout_query_arg": null,
        "logout_redirect_uri": null,
        "logout_revoke": false,
        "logout_revoke_access_token": true,
        "logout_revoke_refresh_token": true,
        "logout_uri_suffix": null,
        "max_age": null,
        "no_proxy": null,
        "password_param_type": [
            "header",
            "query",
            "body"
        ],
        "redirect_uri": [
            "http://localhost:8000/oidc"
        ],
        "rediscovery_lifetime": 300,
        "refresh_token_param_name": null,
        "refresh_token_param_type": [
            "header",
            "query",
            "body"
        ],
        "refresh_tokens": true,
        "response_mode": "query",
        "response_type": [
            "code"
        ],
        "reverify": false,
        "revocation_endpoint": null,
        "run_on_preflight": true,
        "scopes": [
            "openid"
        ],
        "scopes_claim": [
            "scope"
        ],
        "scopes_required": null,
        "search_user_info": false,
        "session_cookie_domain": null,
        "session_cookie_httponly": true,
        "session_cookie_lifetime": 3600,
        "session_cookie_name": "session",
        "session_cookie_path": "/",
        "session_cookie_renew": 600,
        "session_cookie_samesite": "Lax",
        "session_cookie_secure": null,
        "session_memcache_host": "127.0.0.1",
        "session_memcache_port": 11211,
        "session_memcache_prefix": "sessions",
        "session_memcache_socket": null,
        "session_redis_auth": null,
        "session_redis_host": "127.0.0.1",
        "session_redis_port": 6379,
        "session_redis_prefix": "sessions",
        "session_redis_socket": null,
        "session_secret": null,
        "session_storage": "cookie",
        "ssl_verify": false,
        "timeout": 10000,
        "token_endpoint": null,
        "token_endpoint_auth_method": null,
        "token_exchange_endpoint": null,
        "token_headers_client": null,
        "token_headers_grants": null,
        "token_headers_names": null,
        "token_headers_prefix": null,
        "token_headers_replay": null,
        "token_headers_values": null,
        "token_post_args_client": null,
        "token_post_args_names": null,
        "token_post_args_values": null,
        "unauthorized_error_message": "Unauthorized",
        "unauthorized_redirect_uri": null,
        "unexpected_redirect_uri": null,
        "upstream_access_token_header": "authorization:bearer",
        "upstream_access_token_jwk_header": null,
        "upstream_headers_claims": null,
        "upstream_headers_names": null,
        "upstream_id_token_header": null,
        "upstream_id_token_jwk_header": null,
        "upstream_introspection_header": null,
        "upstream_refresh_token_header": null,
        "upstream_session_id_header": null,
        "upstream_user_info_header": null,
        "verify_claims": true,
        "verify_nonce": true,
        "verify_parameters": true,
        "verify_signature": false
    },
    "consumer": null,
    "created_at": 1607618809,
    "enabled": true,
    "id": "c61b12cf-2eb5-4699-928a-6659baf9fb2f",
    "name": "openid-connect",
    "protocols": [
        "grpc",
        "grpcs",
        "http",
        "https"
    ],
    "route": {
        "id": "173fff1b-a871-4118-825e-d04809113484"
    },
    "run_on": "first",
    "service": null,
    "tags": null
}


http post localhost:8001/consumers username=training@apim.eu

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 137
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:47:15 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: qHtcOt4Fo4AIKr1SdUvySIObAhjBRIxp

{
    "created_at": 1607618835,
    "custom_id": null,
    "id": "686d9de5-74eb-4ddd-9b9c-d66297cfd1c9",
    "tags": null,
    "type": 0,
    "username": "training@apim.eu"
}

open http://localhost:8000/oidc
```

```bash
# studying this example in progress
http POST localhost:8001/services/httpbin/routes name=mixAuth-route paths:='["/mixAuth"]'

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 417
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:08:36 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: V1qFxK1TQU4FEGZ5qHIlOa6uVhu7d2hp

{
    "created_at": 1607616516,
    "destinations": null,
    "headers": null,
    "hosts": null,
    "https_redirect_status_code": 426,
    "id": "92231b15-8c01-4e36-a572-8f0ec822a22a",
    "methods": null,
    "name": "mixAuth-route",
    "paths": [
        "/mixAuth"
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
    "updated_at": 1607616516
}

# install plugins
http post localhost:8001/routes/mixAuth-route/plugins name=key-auth
http post localhost:8001/routes/mixAuth-route/plugins name=basic-auth

# view plugins
http get localhost:8001/routes/mixAuth-route/plugins

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 719
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:09:34 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: Osy0HFp2Xw6VdqgrP5gnkZwWNIdSciiF

{
    "data": [
        {
            "config": {
                "anonymous": null,
                "hide_credentials": false
            },
            "consumer": null,
            "created_at": 1607616534,
            "enabled": true,
            "id": "015f3cf3-3226-45ea-bacd-547fbdc3987d",
            "name": "basic-auth",
            "protocols": [
                "grpc",
                "grpcs",
                "http",
                "https"
            ],
            "route": {
                "id": "92231b15-8c01-4e36-a572-8f0ec822a22a"
            },
            "run_on": "first",
            "service": null,
            "tags": null
        },
        {
            "config": {
                "anonymous": null,
                "hide_credentials": false,
                "key_in_body": false,
                "key_names": [
                    "apikey"
                ],
                "run_on_preflight": true
            },
            "consumer": null,
            "created_at": 1607616534,
            "enabled": true,
            "id": "373eb595-d565-40a8-b834-519a0ad626ab",
            "name": "key-auth",
            "protocols": [
                "grpc",
                "grpcs",
                "http",
                "https"
            ],
            "route": {
                "id": "92231b15-8c01-4e36-a572-8f0ec822a22a"
            },
            "run_on": "first",
            "service": null,
            "tags": null
        }
    ],
    "next": null
}

CONSUMER_ID=$(http get localhost:8001/consumers/anonymous -b | jq -r .id)
PLUGIN_ID_KEY_AUTH=$(http get localhost:8001/routes/mixAuth-route/plugins -b | jq -r '.data[] | select(.name == "key-auth") | .id')
PLUGIN_ID_BASIC_AUTH=$(http get localhost:8001/routes/mixAuth-route/plugins -b | jq -r '.data[] | select(.name == "basic-auth") | .id')

# patch the plugin configuration with anonymous user id
http PATCH localhost:8001/plugins/${PLUGIN_ID_KEY_AUTH} config.anonymous=${CONSUMER_ID}

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 414
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:45:22 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: v6RMKWBY3J4pDqndAtuu5t9NNkYSrX8v

{
    "config": {
        "anonymous": "33c71bac-f45c-4caf-bca4-07219e446e8f",
        "hide_credentials": false,
        "key_in_body": false,
        "key_names": [
            "apikey"
        ],
        "run_on_preflight": true
    },
    "consumer": null,
    "created_at": 1607616534,
    "enabled": true,
    "id": "373eb595-d565-40a8-b834-519a0ad626ab",
    "name": "key-auth",
    "protocols": [
        "grpc",
        "grpcs",
        "http",
        "https"
    ],
    "route": {
        "id": "92231b15-8c01-4e36-a572-8f0ec822a22a"
    },
    "run_on": "first",
    "service": null,
    "tags": null
}

http PATCH localhost:8001/plugins/${PLUGIN_ID_BASIC_AUTH} config.anonymous=${CONSUMER_ID}

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 349
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:45:31 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: cRZQZHyInTP1fdSeV25To7BjUPloX3SW

{
    "config": {
        "anonymous": "33c71bac-f45c-4caf-bca4-07219e446e8f",
        "hide_credentials": false
    },
    "consumer": null,
    "created_at": 1607616534,
    "enabled": true,
    "id": "015f3cf3-3226-45ea-bacd-547fbdc3987d",
    "name": "basic-auth",
    "protocols": [
        "grpc",
        "grpcs",
        "http",
        "https"
    ],
    "route": {
        "id": "92231b15-8c01-4e36-a572-8f0ec822a22a"
    },
    "run_on": "first",
    "service": null,
    "tags": null
}

http post localhost:8001/consumers/anonymous/plugins name=request-termination

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 347
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:45:39 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: wZjey6UMDgEtqKnxNOS0Utmjbc3x5V9P

{
    "config": {
        "body": null,
        "content_type": null,
        "message": null,
        "status_code": 503
    },
    "consumer": {
        "id": "33c71bac-f45c-4caf-bca4-07219e446e8f"
    },
    "created_at": 1607618739,
    "enabled": true,
    "id": "a59867ea-7953-4526-bd46-0fac2356fed8",
    "name": "request-termination",
    "protocols": [
        "grpc",
        "grpcs",
        "http",
        "https"
    ],
    "route": null,
    "run_on": "first",
    "service": null,
    "tags": null
}
```

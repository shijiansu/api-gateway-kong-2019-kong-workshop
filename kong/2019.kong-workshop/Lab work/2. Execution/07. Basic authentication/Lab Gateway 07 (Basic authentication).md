```bash
http post localhost:8001/services/httpbin/routes name=basicAuth-route paths:='["/basicAuth"]'

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 421
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:05:33 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: dcLRi8aJBh1QsspSKXTjSvsKmjjRKNLY

{
    "created_at": 1607616333,
    "destinations": null,
    "headers": null,
    "hosts": null,
    "https_redirect_status_code": 426,
    "id": "ef6d9184-595c-4a44-a4c7-893bf7c0d7a5",
    "methods": null,
    "name": "basicAuth-route",
    "paths": [
        "/basicAuth"
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
    "updated_at": 1607616333
}

# install plugin
http post localhost:8001/routes/basicAuth-route/plugins name=basic-auth

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 315
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:05:51 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: Fsz2eih6haxBSB9J9H7A3JoV5UUMiMNP

{
    "config": {
        "anonymous": null,
        "hide_credentials": false
    },
    "consumer": null,
    "created_at": 1607616351,
    "enabled": true,
    "id": "91059cb0-a6b9-4dad-b556-e37afafceb9b",
    "name": "basic-auth",
    "protocols": [
        "grpc",
        "grpcs",
        "http",
        "https"
    ],
    "route": {
        "id": "ef6d9184-595c-4a44-a4c7-893bf7c0d7a5"
    },
    "run_on": "first",
    "service": null,
    "tags": null
}

# create account
http post localhost:8001/consumers username=lab07.consumer1

HTTP/1.1 409 Conflict
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 161
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:06:12 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: XMd2inQIqTNwTV1Gv18erJY8RVPLwgu1

{
    "code": 5,
    "fields": {
        "username": "lab07.consumer1"
    },
    "message": "UNIQUE violation detected on '{username=\"lab07.consumer1\"}'",
    "name": "unique constraint violation"
}

# set up password
http post localhost:8001/consumers/lab07.consumer1/basic-auth username=lab07.consumer1 password=password

HTTP/1.1 409 Conflict
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 161
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:08:07 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: Cd1jw9spTzFOKkZijOotmC1jqgn1Z4io

{
    "code": 5,
    "fields": {
        "username": "lab07.consumer1"
    },
    "message": "UNIQUE violation detected on '{username=\"lab07.consumer1\"}'",
    "name": "unique constraint violation"
}
```

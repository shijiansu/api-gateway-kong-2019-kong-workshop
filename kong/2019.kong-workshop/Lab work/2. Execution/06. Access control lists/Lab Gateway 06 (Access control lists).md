```bash
http post localhost:8001/services/httpbin/routes name=acl-route paths:='["/acl"]'

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 409
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 15:46:45 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: XfqH9tPSfAyB2oEtzalPvfp8IY6uw23G

{
    "created_at": 1607615205,
    "destinations": null,
    "headers": null,
    "hosts": null,
    "https_redirect_status_code": 426,
    "id": "8fb3d3b3-9ab8-4092-98a5-b7b4ab880f74",
    "methods": null,
    "name": "acl-route",
    "paths": [
        "/acl"
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
    "updated_at": 1607615205
}

http post localhost:8001/routes/acl-route/plugins name=key-auth

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 380
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 15:47:05 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: J7BOCCtABBBBjxIe27vbUyVAo3Kvjvbo

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
    "created_at": 1607615225,
    "enabled": true,
    "id": "a9ffe01c-057e-4e28-9fe2-ae4a58a5aca1",
    "name": "key-auth",
    "protocols": [
        "grpc",
        "grpcs",
        "http",
        "https"
    ],
    "route": {
        "id": "8fb3d3b3-9ab8-4092-98a5-b7b4ab880f74"
    },
    "run_on": "first",
    "service": null,
    "tags": null
}

# set up ACL
http post localhost:8001/consumers username=lab06.consumer1
http post localhost:8001/consumers username=lab06.consumer2
http post localhost:8001/consumers username=lab06.consumer3
http post localhost:8001/consumers username=lab06.consumer4

http post localhost:8001/consumers/lab06.consumer1/acls "group=lab06.group1"
http post localhost:8001/consumers/lab06.consumer3/acls "group=lab06.group1"
http post localhost:8001/consumers/lab06.consumer2/acls "group=lab06.group2"
http post localhost:8001/consumers/lab06.consumer4/acls "group=lab06.group2"

http post localhost:8001/consumers/lab06.consumer1/key-auth key=lab06.consumer1.key
http post localhost:8001/consumers/lab06.consumer2/key-auth key=lab06.consumer2.key
http post localhost:8001/consumers/lab06.consumer3/key-auth key=lab06.consumer3.key
http post localhost:8001/consumers/lab06.consumer4/key-auth key=lab06.consumer4.key

http POST localhost:8001/routes/acl-route/plugins name=acl config.whitelist=lab06.group1 config.hide_groups_header=true -f
HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 338
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 15:50:51 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: Sl8pAly9onYpSOailCgY2Kgit9HcUag8

{
    "config": {
        "blacklist": null,
        "hide_groups_header": true,
        "whitelist": [
            "lab06.group1"
        ]
    },
    "consumer": null,
    "created_at": 1607615450,
    "enabled": true,
    "id": "3d152f06-739d-4c93-8650-d737527f7de4",
    "name": "acl",
    "protocols": [
        "grpc",
        "grpcs",
        "http",
        "https"
    ],
    "route": {
        "id": "8fb3d3b3-9ab8-4092-98a5-b7b4ab880f74"
    },
    "run_on": "first",
    "service": null,
    "tags": null
}

http localhost:8000/acl apikey:lab06.consumer2.key

HTTP/1.1 403 Forbidden
Connection: keep-alive
Content-Length: 45
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 15:56:10 GMT
Server: kong/1.3-enterprise-edition

{
    "message": "You cannot consume this service"
}

http localhost:8000/acl apikey:lab06.consumer3.key

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 579
Content-Type: application/json
Date: Thu, 10 Dec 2020 15:56:27 GMT
Server: gunicorn/19.9.0
Via: kong/1.3-enterprise-edition
X-Kong-Proxy-Latency: 48
X-Kong-Upstream-Latency: 503

{
    "args": {},
    "data": "",
    "files": {},
    "form": {},
    "headers": {
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate",
        "Apikey": "lab06.consumer3.key",
        "Host": "httpbin.org",
        "User-Agent": "HTTPie/2.3.0",
        "X-Amzn-Trace-Id": "Root=1-5fd2452b-55eab3e372c11f5e504b91f6",
        "X-Consumer-Id": "c5153206-56ed-4828-8b5e-223038ed09a0",
        "X-Consumer-Username": "lab06.consumer3",
        "X-Forwarded-Host": "localhost"
    },
    "json": null,
    "method": "GET",
    "origin": "172.21.0.1, 49.245.27.189",
    "url": "http://localhost/anything"
}
```

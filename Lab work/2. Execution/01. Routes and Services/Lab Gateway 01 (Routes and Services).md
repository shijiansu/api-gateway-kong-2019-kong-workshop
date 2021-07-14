```bash
# brew info httpie

# demo endpoint
http GET http://httpbin.org/anything

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 385
Content-Type: application/json
Date: Sun, 03 Jan 2021 10:32:29 GMT
Server: gunicorn/19.9.0

{
    "args": {},
    "data": "",
    "files": {},
    "form": {},
    "headers": {
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate",
        "Host": "httpbin.org",
        "User-Agent": "HTTPie/2.3.0",
        "X-Amzn-Trace-Id": "Root=1-5ff19d3d-563135366064d1714611cfa9"
    },
    "json": null,
    "method": "GET",
    "origin": "49.245.106.218",
    "url": "http://httpbin.org/anything"
}

# create service
http POST localhost:8001/services name=httpbin url=http://httpbin.org/anything

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 296
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 14:24:13 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: hXEco9o7mEXqiPQctTYicBJ0cUo4EQdv

{
    "client_certificate": null,
    "connect_timeout": 60000,
    "created_at": 1607610253,
    "host": "httpbin.org",
    "id": "40b281b2-e930-4af0-9ac0-041203216c12",
    "name": "httpbin",
    "path": "/anything",
    "port": 80,
    "protocol": "http",
    "read_timeout": 60000,
    "retries": 5,
    "tags": null,
    "updated_at": 1607610253,
    "write_timeout": 60000
}

# view service
http GET localhost:8001/services

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 319
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 14:24:26 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: 5wmcNv1PTa1KI1osYSQMIvq9bKQOPaXs

{
    "data": [
        {
            "client_certificate": null,
            "connect_timeout": 60000,
            "created_at": 1607610253,
            "host": "httpbin.org",
            "id": "40b281b2-e930-4af0-9ac0-041203216c12",
            "name": "httpbin",
            "path": "/anything",
            "port": 80,
            "protocol": "http",
            "read_timeout": 60000,
            "retries": 5,
            "tags": null,
            "updated_at": 1607610253,
            "write_timeout": 60000
        }
    ],
    "next": null
}

# create route
http POST localhost:8001/services/httpbin/routes name=anything_route paths:='["/anything"]'

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 419
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 14:24:37 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: 4rX5bq7Ov6Gk6E9Ui2aG05HboXfaUGjD

{
    "created_at": 1607610277,
    "destinations": null,
    "headers": null,
    "hosts": null,
    "https_redirect_status_code": 426,
    "id": "7442e948-097e-447d-9abf-a635851b664b",
    "methods": null,
    "name": "anything_route",
    "paths": [
        "/anything"
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
    "updated_at": 1607610277
}

# view route
http GET localhost:8001/routes

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 442
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 14:24:51 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: yGujLOcQuWgJAnoZJOmXgIB4jPMpLVsN

{
    "data": [
        {
            "created_at": 1607610277,
            "destinations": null,
            "headers": null,
            "hosts": null,
            "https_redirect_status_code": 426,
            "id": "7442e948-097e-447d-9abf-a635851b664b",
            "methods": null,
            "name": "anything_route",
            "paths": [
                "/anything"
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
            "updated_at": 1607610277
        }
    ],
    "next": null
}

# test
http GET localhost:8000/anything

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 432
Content-Type: application/json
Date: Thu, 10 Dec 2020 14:25:04 GMT
Server: gunicorn/19.9.0
Via: kong/1.3-enterprise-edition
X-Kong-Proxy-Latency: 25
X-Kong-Upstream-Latency: 683

{
    "args": {},
    "data": "",
    "files": {},
    "form": {},
    "headers": {
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate",
        "Host": "httpbin.org",
        "User-Agent": "HTTPie/2.3.0",
        "X-Amzn-Trace-Id": "Root=1-5fd22fc0-569200272e1012744a0f4763",
        "X-Forwarded-Host": "localhost"
    },
    "json": null,
    "method": "GET",
    "origin": "172.21.0.1, 49.245.27.189",
    "url": "http://localhost/anything"
}
```

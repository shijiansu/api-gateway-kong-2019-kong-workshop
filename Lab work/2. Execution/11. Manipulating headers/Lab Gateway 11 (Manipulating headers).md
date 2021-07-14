```bash
http POST localhost:8001/services/httpbin/routes name=transform-route paths:='["/transform"]'

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 421
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:57:27 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: 587rB8j9ajVEkQrTkZ5kOTYOxgekwWOd

{
    "created_at": 1607619447,
    "destinations": null,
    "headers": null,
    "hosts": null,
    "https_redirect_status_code": 426,
    "id": "ce28b01b-d372-45df-ab8f-37dbb48af546",
    "methods": null,
    "name": "transform-route",
    "paths": [
        "/transform"
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
    "updated_at": 1607619447
}

# install plugin
http -f POST localhost:8001/routes/transform-route/plugins name=response-transformer config.append.headers=my-own-header:cool

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 437
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:57:40 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: YDFkUPakk7QOINBW0si66Ro6nr8Ss6th

{
    "config": {
        "add": {
            "headers": [],
            "json": []
        },
        "append": {
            "headers": [
                "my-own-header:cool"
            ],
            "json": []
        },
        "remove": {
            "headers": [],
            "json": []
        },
        "replace": {
            "headers": [],
            "json": []
        }
    },
    "consumer": null,
    "created_at": 1607619460,
    "enabled": true,
    "id": "3bb40783-3142-48fa-9686-5caedad5f7a7",
    "name": "response-transformer",
    "protocols": [
        "grpc",
        "grpcs",
        "http",
        "https"
    ],
    "route": {
        "id": "ce28b01b-d372-45df-ab8f-37dbb48af546"
    },
    "run_on": "first",
    "service": null,
    "tags": null
}

http localhost:8000/transform

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 432
Content-Type: application/json
Date: Thu, 10 Dec 2020 16:57:56 GMT
Server: gunicorn/19.9.0
Via: kong/1.3-enterprise-edition
X-Kong-Proxy-Latency: 20
X-Kong-Upstream-Latency: 649
my-own-header: cool

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
        "X-Amzn-Trace-Id": "Root=1-5fd25394-7aee03df0fe817383cf065c6",
        "X-Forwarded-Host": "localhost"
    },
    "json": null,
    "method": "GET",
    "origin": "172.21.0.1, 49.245.27.189",
    "url": "http://localhost/anything"
}
```

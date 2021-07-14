```bash
http post localhost:8001/services/httpbin/routes name=keyAuth-route paths:='["/keyAuth"]'

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 417
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 14:38:10 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: 8Lya8Ay1k22Hm1azLPm5veg5CXpL6gtA

{
    "created_at": 1607611090,
    "destinations": null,
    "headers": null,
    "hosts": null,
    "https_redirect_status_code": 426,
    "id": "30c5ab8b-53a5-4fd3-987f-a3b8b0f7bca7",
    "methods": null,
    "name": "keyAuth-route",
    "paths": [
        "/keyAuth"
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
    "updated_at": 1607611090
}

# install plugin
http post localhost:8001/routes/keyAuth-route/plugins name=key-auth

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 380
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 14:38:24 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: Z6NYY50F6ZI10lwvf7Y3wKahOZfg0Y0T

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
    "created_at": 1607611104,
    "enabled": true,
    "id": "1cec5fe7-41ac-49a2-a7a0-31ba38a065eb",
    "name": "key-auth",
    "protocols": [
        "grpc",
        "grpcs",
        "http",
        "https"
    ],
    "route": {
        "id": "30c5ab8b-53a5-4fd3-987f-a3b8b0f7bca7"
    },
    "run_on": "first",
    "service": null,
    "tags": null
}

# test
http get localhost:8000/keyAuth

HTTP/1.1 401 Unauthorized
Connection: keep-alive
Content-Length: 41
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 14:38:39 GMT
Server: kong/1.3-enterprise-edition
WWW-Authenticate: Key realm="kong"

{
    "message": "No API key found in request"
}

# create test account
http post localhost:8001/consumers username=joe.bloggs

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 131
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 14:38:54 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: D40yXGu8U7yxxPc1MktYRuTqonxVCw6A

{
    "created_at": 1607611134,
    "custom_id": null,
    "id": "b66ab642-6645-4e1a-8897-c9480ee73561",
    "tags": null,
    "type": 0,
    "username": "joe.bloggs"
}

# create key under the test account
http post localhost:8001/consumers/joe.bloggs/key-auth key=joe-key
HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 153
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 14:39:06 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: WnfuEYWPkbVaTzXDsSQIgsND8WmvbBm1

{
    "consumer": {
        "id": "b66ab642-6645-4e1a-8897-c9480ee73561"
    },
    "created_at": 1607611146,
    "id": "999e15d8-ffc8-4698-8f16-1eb81be0ec11",
    "key": "joe-key",
    "ttl": null
}

# the concept of key here is as api key (could be uuid or more random format then it is more secure), but not as the password
http get localhost:8000/keyAuth apikey:joe-key

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 562
Content-Type: application/json
Date: Thu, 10 Dec 2020 14:39:24 GMT
Server: gunicorn/19.9.0
Via: kong/1.3-enterprise-edition
X-Kong-Proxy-Latency: 22
X-Kong-Upstream-Latency: 720

{
    "args": {},
    "data": "",
    "files": {},
    "form": {},
    "headers": {
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate",
        "Apikey": "joe-key",
        "Host": "httpbin.org",
        "User-Agent": "HTTPie/2.3.0",
        "X-Amzn-Trace-Id": "Root=1-5fd2331c-4102f48579303d9a21a6f1c5",
        "X-Consumer-Id": "b66ab642-6645-4e1a-8897-c9480ee73561",
        "X-Consumer-Username": "joe.bloggs",
        "X-Forwarded-Host": "localhost"
    },
    "json": null,
    "method": "GET",
    "origin": "172.21.0.1, 49.245.27.189",
    "url": "http://localhost/anything"
}
```

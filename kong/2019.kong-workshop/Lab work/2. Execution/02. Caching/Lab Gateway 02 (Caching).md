```bash
http post localhost:8001/services/httpbin/routes name=caching-route paths:='["/caching"]'

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 417
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 14:35:57 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: j7GaDOw7yztymSe7BS3nQkAcS13kiLEN

{
    "created_at": 1607610956,
    "destinations": null,
    "headers": null,
    "hosts": null,
    "https_redirect_status_code": 426,
    "id": "5e90567e-1ac3-4ec1-9ceb-0a6ef7766ae5",
    "methods": null,
    "name": "caching-route",
    "paths": [
        "/caching"
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
    "updated_at": 1607610956
}

http get localhost:8001/routes/caching-route

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 417
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 14:36:20 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: WjM8NHnvcHscqWXphYEKV6C2YwcQjOrt

{
    "created_at": 1607610956,
    "destinations": null,
    "headers": null,
    "hosts": null,
    "https_redirect_status_code": 426,
    "id": "5e90567e-1ac3-4ec1-9ceb-0a6ef7766ae5",
    "methods": null,
    "name": "caching-route",
    "paths": [
        "/caching"
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
    "updated_at": 1607610956
}

# install plugin
http post localhost:8001/routes/caching-route/plugins name=proxy-cache config:='{"strategy": "memory"}'

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 554
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 14:36:40 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: K9c3vN17v6z4epeWCHGfYNwH8ZSOyR4C

{
    "config": {
        "cache_control": false,
        "cache_ttl": 300,
        "content_type": [
            "text/plain",
            "application/json"
        ],
        "memory": {
            "dictionary_name": "kong_db_cache"
        },
        "request_method": [
            "GET",
            "HEAD"
        ],
        "response_code": [
            200,
            301,
            404
        ],
        "storage_ttl": null,
        "strategy": "memory",
        "vary_headers": null,
        "vary_query_params": null
    },
    "consumer": null,
    "created_at": 1607611000,
    "enabled": true,
    "id": "691d1e13-97e9-4c18-8154-544bb6f74151",
    "name": "proxy-cache",
    "protocols": [
        "grpc",
        "grpcs",
        "http",
        "https"
    ],
    "route": {
        "id": "5e90567e-1ac3-4ec1-9ceb-0a6ef7766ae5"
    },
    "run_on": "first",
    "service": null,
    "tags": null
}

# test
http get localhost:8000/caching

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 432
Content-Type: application/json
Date: Thu, 10 Dec 2020 14:37:00 GMT
Server: gunicorn/19.9.0
Via: kong/1.3-enterprise-edition
X-Cache-Key: c249ea70ad20b1eefe20fe1f344ea08b
X-Cache-Status: Miss
X-Kong-Proxy-Latency: 34
X-Kong-Upstream-Latency: 856

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
        "X-Amzn-Trace-Id": "Root=1-5fd2328c-5d905c3f111a2b326568fe1a",
        "X-Forwarded-Host": "localhost"
    },
    "json": null,
    "method": "GET",
    "origin": "172.21.0.1, 49.245.27.189",
    "url": "http://localhost/anything"
}
```

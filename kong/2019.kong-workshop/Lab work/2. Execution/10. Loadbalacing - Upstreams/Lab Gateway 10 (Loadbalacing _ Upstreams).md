```bash
# create the upstream
http -f post localhost:8001/upstreams name=my-upstream

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 846
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:49:47 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: amBLvSOO9HAdRAOa0mRTepSw5RSBXw9Y

{
    "algorithm": "round-robin",
    "created_at": 1607618987,
    "hash_fallback": "none",
    "hash_fallback_header": null,
    "hash_on": "none",
    "hash_on_cookie": null,
    "hash_on_cookie_path": "/",
    "hash_on_header": null,
    "healthchecks": {
        "active": {
            "concurrency": 10,
            "healthy": {
                "http_statuses": [
                    200,
                    302
                ],
                "interval": 0,
                "successes": 0
            },
            "http_path": "/",
            "https_sni": null,
            "https_verify_certificate": true,
            "timeout": 1,
            "type": "http",
            "unhealthy": {
                "http_failures": 0,
                "http_statuses": [
                    429,
                    404,
                    500,
                    501,
                    502,
                    503,
                    504,
                    505
                ],
                "interval": 0,
                "tcp_failures": 0,
                "timeouts": 0
            }
        },
        "passive": {
            "healthy": {
                "http_statuses": [
                    200,
                    201,
                    202,
                    203,
                    204,
                    205,
                    206,
                    207,
                    208,
                    226,
                    300,
                    301,
                    302,
                    303,
                    304,
                    305,
                    306,
                    307,
                    308
                ],
                "successes": 0
            },
            "type": "http",
            "unhealthy": {
                "http_failures": 0,
                "http_statuses": [
                    429,
                    500,
                    503
                ],
                "tcp_failures": 0,
                "timeouts": 0
            }
        }
    },
    "id": "a0e9fce9-7d6c-449c-b88d-11d95a9dec79",
    "name": "my-upstream",
    "slots": 10000,
    "tags": null
}

# create upstream target
http -f post localhost:8001/upstreams/my-upstream/targets target="httpbin.org:80"

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 169
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:50:12 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: 09kGWbp3NoS1Dc8WSE7LUUoJNkfT7ETs

{
    "created_at": 1607619012.819,
    "id": "7718c89d-46c4-4a14-a9d9-28fa59fd2793",
    "target": "httpbin.org:80",
    "upstream": {
        "id": "a0e9fce9-7d6c-449c-b88d-11d95a9dec79"
    },
    "weight": 100
}

# forgot to create this target
http -f post  localhost:8001/upstreams/my-upstream/targets target="httpbin.apim.eu:80"

# create service on the upstream
# by right it looks like,
# request -> route -> service -> upstream -> httpbin.org:80/httpbin.apim.eu:80
http post localhost:8001/services name=loadbalancedUpstream url=http://my-upstream/anything

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 309
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:56:01 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: E5EsRj0wUQ98lvDzDmWmYl3fE4ldoF7I

{
    "client_certificate": null,
    "connect_timeout": 60000,
    "created_at": 1607619361,
    "host": "my-upstream",
    "id": "19124705-2eec-4d5d-ace1-d28fea39fd8a",
    "name": "loadbalancedUpstream",
    "path": "/anything",
    "port": 80,
    "protocol": "http",
    "read_timeout": 60000,
    "retries": 5,
    "tags": null,
    "updated_at": 1607619361,
    "write_timeout": 60000
}

# create route
http post localhost:8001/services/loadbalancedUpstream/routes name=upstream-route paths:='["/upstream"]'

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 419
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 16:56:13 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: D63tnI78D2h1RazyjzQ1vyNTTWbfmfja

{
    "created_at": 1607619373,
    "destinations": null,
    "headers": null,
    "hosts": null,
    "https_redirect_status_code": 426,
    "id": "85f43c78-a8c6-48aa-b7db-d8c59aa54593",
    "methods": null,
    "name": "upstream-route",
    "paths": [
        "/upstream"
    ],
    "preserve_host": false,
    "protocols": [
        "http",
        "https"
    ],
    "regex_priority": 0,
    "service": {
        "id": "19124705-2eec-4d5d-ace1-d28fea39fd8a"
    },
    "snis": null,
    "sources": null,
    "strip_path": true,
    "tags": null,
    "updated_at": 1607619373
}

# test - because the wrong set up, so this cannot demonstrate as expected
http localhost:8000/upstream

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 432
Content-Type: application/json
Date: Thu, 10 Dec 2020 16:56:38 GMT
Server: gunicorn/19.9.0
Via: kong/1.3-enterprise-edition
X-Kong-Proxy-Latency: 17
X-Kong-Upstream-Latency: 616

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
        "X-Amzn-Trace-Id": "Root=1-5fd25346-7b5e8392239659a93076892e",
        "X-Forwarded-Host": "localhost"
    },
    "json": null,
    "method": "GET",
    "origin": "172.21.0.1, 49.245.27.189",
    "url": "http://localhost/anything"
}

http localhost:8000/upstream

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 432
Content-Type: application/json
Date: Thu, 10 Dec 2020 16:56:51 GMT
Server: gunicorn/19.9.0
Via: kong/1.3-enterprise-edition
X-Kong-Proxy-Latency: 1
X-Kong-Upstream-Latency: 244

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
        "X-Amzn-Trace-Id": "Root=1-5fd25353-5a541adf2ed5a449721ff8cf",
        "X-Forwarded-Host": "localhost"
    },
    "json": null,
    "method": "GET",
    "origin": "172.21.0.1, 49.245.27.189",
    "url": "http://localhost/anything"
}
```

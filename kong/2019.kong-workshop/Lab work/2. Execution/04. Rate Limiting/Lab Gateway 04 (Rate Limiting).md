```bash
http post localhost:8001/services/httpbin/routes name=ratelimit-route paths:='["/rateLimiting"]'

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 424
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 14:43:50 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: jD3tTZsx8lnZvx6MSibZFFNzAyI6MQMW

{
    "created_at": 1607611430,
    "destinations": null,
    "headers": null,
    "hosts": null,
    "https_redirect_status_code": 426,
    "id": "4115ec2f-2636-488e-86e6-84876755ff76",
    "methods": null,
    "name": "ratelimit-route",
    "paths": [
        "/rateLimiting"
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
    "updated_at": 1607611430
}

# install plugin
http post localhost:8001/routes/ratelimit-route/plugins name=rate-limiting-advanced config:='{"sync_rate": 5, "window_size": [3600,60], "limit": [60,3]}'

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 722
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 15:06:19 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: uCYgq6AEhd9W8B00ZU7NNqC3swtmZalV

{
    "config": {
        "dictionary_name": "kong_rate_limiting_counters",
        "header_name": null,
        "hide_client_headers": false,
        "identifier": "consumer",
        "limit": [
            3,
            60
        ],
        "namespace": "2GVNXY3wS8FhsK9rwzrlkKp0dlzuTzBh",
        "redis": {
            "cluster_addresses": null,
            "database": 0,
            "host": null,
            "password": null,
            "port": null,
            "sentinel_addresses": null,
            "sentinel_master": null,
            "sentinel_role": null,
            "timeout": 2000
        },
        "strategy": "cluster",
        "sync_rate": 5,
        "window_size": [
            60,
            3600
        ],
        "window_type": "sliding"
    },
    "consumer": null,
    "created_at": 1607612779,
    "enabled": true,
    "id": "298840f5-b4e3-4dd4-bcf4-755452bc8682",
    "name": "rate-limiting-advanced",
    "protocols": [
        "grpc",
        "grpcs",
        "http",
        "https"
    ],
    "route": {
        "id": "4115ec2f-2636-488e-86e6-84876755ff76"
    },
    "run_on": "first",
    "service": null,
    "tags": null
}

# install plugin
http post localhost:8001/routes/ratelimit-route/plugins name=key-auth

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 380
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 15:06:32 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: a3p3keQ0Dj6hQ7r02BDvEvElLfIRSVBY

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
    "created_at": 1607612792,
    "enabled": true,
    "id": "9ed3634a-3c92-4056-98b4-51d47d7f8428",
    "name": "key-auth",
    "protocols": [
        "grpc",
        "grpcs",
        "http",
        "https"
    ],
    "route": {
        "id": "4115ec2f-2636-488e-86e6-84876755ff76"
    },
    "run_on": "first",
    "service": null,
    "tags": null
}

# create account
http post localhost:8001/consumers username=lab04.consumer1

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 136
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 15:06:42 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: uB7TX18iMm5x4JF2Czl8rF9JeMcE7L6O

{
    "created_at": 1607612802,
    "custom_id": null,
    "id": "65d55e32-b124-493f-b71e-a0978070f87f",
    "tags": null,
    "type": 0,
    "username": "lab04.consumer1"
}

http post localhost:8001/consumers/lab04.consumer1/key-auth key=abcd1234

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 154
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 15:06:51 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: BJnlD8EKWfGXUm66xnYdu1Kt2TFbFaX7

{
    "consumer": {
        "id": "65d55e32-b124-493f-b71e-a0978070f87f"
    },
    "created_at": 1607612811,
    "id": "79d5f492-8fc0-477d-bac2-167be3f7f21a",
    "key": "abcd1234",
    "ttl": null
}

# create account
http post localhost:8001/consumers username=lab04.consumer2

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 136
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 15:10:04 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: utQcnikEG0pFkWErWE2YzhXtGHf3qSVY

{
    "created_at": 1607613004,
    "custom_id": null,
    "id": "af0ed4d4-b566-456c-a58e-3b52272ef65d",
    "tags": null,
    "type": 0,
    "username": "lab04.consumer2"
}

http post localhost:8001/consumers/lab04.consumer2/key-auth key=abcd4321

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 154
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 15:10:15 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: 6QsVOkIPp7Mk9U6KAWgGrHY4QmeZZy7k

{
    "consumer": {
        "id": "af0ed4d4-b566-456c-a58e-3b52272ef65d"
    },
    "created_at": 1607613015,
    "id": "d20c754b-fccd-4c9f-940d-bd163055bca1",
    "key": "abcd4321",
    "ttl": null
}

http get localhost:8000/rateLimiting apikey:abcd1234

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 568
Content-Type: application/json
Date: Thu, 10 Dec 2020 15:10:29 GMT
Server: gunicorn/19.9.0
Via: kong/1.3-enterprise-edition
X-Kong-Proxy-Latency: 28
X-Kong-Upstream-Latency: 474
X-RateLimit-Limit-hour: 60
X-RateLimit-Limit-minute: 3
X-RateLimit-Remaining-hour: 59
X-RateLimit-Remaining-minute: 2

{
    "args": {},
    "data": "",
    "files": {},
    "form": {},
    "headers": {
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate",
        "Apikey": "abcd1234",
        "Host": "httpbin.org",
        "User-Agent": "HTTPie/2.3.0",
        "X-Amzn-Trace-Id": "Root=1-5fd23a65-5950679e1fc2f43058031a28",
        "X-Consumer-Id": "65d55e32-b124-493f-b71e-a0978070f87f",
        "X-Consumer-Username": "lab04.consumer1",
        "X-Forwarded-Host": "localhost"
    },
    "json": null,
    "method": "GET",
    "origin": "172.21.0.1, 49.245.27.189",
    "url": "http://localhost/anything"
}

http get localhost:8000/rateLimiting apikey:abcd4321

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 568
Content-Type: application/json
Date: Thu, 10 Dec 2020 15:10:42 GMT
Server: gunicorn/19.9.0
Via: kong/1.3-enterprise-edition
X-Kong-Proxy-Latency: 5
X-Kong-Upstream-Latency: 716
X-RateLimit-Limit-hour: 60
X-RateLimit-Limit-minute: 3
X-RateLimit-Remaining-hour: 59
X-RateLimit-Remaining-minute: 2

{
    "args": {},
    "data": "",
    "files": {},
    "form": {},
    "headers": {
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate",
        "Apikey": "abcd4321",
        "Host": "httpbin.org",
        "User-Agent": "HTTPie/2.3.0",
        "X-Amzn-Trace-Id": "Root=1-5fd23a72-22578faf636f25171c27b6ed",
        "X-Consumer-Id": "af0ed4d4-b566-456c-a58e-3b52272ef65d",
        "X-Consumer-Username": "lab04.consumer2",
        "X-Forwarded-Host": "localhost"
    },
    "json": null,
    "method": "GET",
    "origin": "172.21.0.1, 49.245.27.189",
    "url": "http://localhost/anything"
}

http get localhost:8000/rateLimiting apikey:abcd1234

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 568
Content-Type: application/json
Date: Thu, 10 Dec 2020 15:10:55 GMT
Server: gunicorn/19.9.0
Via: kong/1.3-enterprise-edition
X-Kong-Proxy-Latency: 1
X-Kong-Upstream-Latency: 795
X-RateLimit-Limit-hour: 60
X-RateLimit-Limit-minute: 3
X-RateLimit-Remaining-hour: 58
X-RateLimit-Remaining-minute: 1

{
    "args": {},
    "data": "",
    "files": {},
    "form": {},
    "headers": {
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate",
        "Apikey": "abcd1234",
        "Host": "httpbin.org",
        "User-Agent": "HTTPie/2.3.0",
        "X-Amzn-Trace-Id": "Root=1-5fd23a7f-112887d8701214486addefbe",
        "X-Consumer-Id": "65d55e32-b124-493f-b71e-a0978070f87f",
        "X-Consumer-Username": "lab04.consumer1",
        "X-Forwarded-Host": "localhost"
    },
    "json": null,
    "method": "GET",
    "origin": "172.21.0.1, 49.245.27.189",
    "url": "http://localhost/anything"
}


http get localhost:8001/consumers/lab04.consumer1

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 136
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 15:11:10 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: O1wFGyOcm5EQeuWn7039BQDAGTA2DpBD

{
    "created_at": 1607612802,
    "custom_id": null,
    "id": "65d55e32-b124-493f-b71e-a0978070f87f",
    "tags": null,
    "type": 0,
    "username": "lab04.consumer1"
}

# install plugin for the account
CONSUMER_ID=$(http get localhost:8001/consumers/lab04.consumer1 -b | jq -r .id)
http post localhost:8001/consumers/${CONSUMER_ID}/plugins name=rate-limiting-advanced config:='{"sync_rate": 5, "window_size": [3600], "limit": [600]}'

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 718
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 15:27:07 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: aA7m0GwO4f7S11DkVltC83ua1nuA35aR

{
    "config": {
        "dictionary_name": "kong_rate_limiting_counters",
        "header_name": null,
        "hide_client_headers": false,
        "identifier": "consumer",
        "limit": [
            600
        ],
        "namespace": "vXbiA8s8T8R2Zr1UNKOBX5pCIstrsANW",
        "redis": {
            "cluster_addresses": null,
            "database": 0,
            "host": null,
            "password": null,
            "port": null,
            "sentinel_addresses": null,
            "sentinel_master": null,
            "sentinel_role": null,
            "timeout": 2000
        },
        "strategy": "cluster",
        "sync_rate": 5,
        "window_size": [
            3600
        ],
        "window_type": "sliding"
    },
    "consumer": {
        "id": "65d55e32-b124-493f-b71e-a0978070f87f"
    },
    "created_at": 1607614027,
    "enabled": true,
    "id": "a1e10b96-d7d2-4a0c-ac99-7cb988d2f798",
    "name": "rate-limiting-advanced",
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


http get localhost:8000/rateLimiting apikey:abcd1234

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 568
Content-Type: application/json
Date: Thu, 10 Dec 2020 15:27:25 GMT
Server: gunicorn/19.9.0
Via: kong/1.3-enterprise-edition
X-Kong-Proxy-Latency: 16
X-Kong-Upstream-Latency: 750
X-RateLimit-Limit-hour: 600
X-RateLimit-Remaining-hour: 599

{
    "args": {},
    "data": "",
    "files": {},
    "form": {},
    "headers": {
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate",
        "Apikey": "abcd1234",
        "Host": "httpbin.org",
        "User-Agent": "HTTPie/2.3.0",
        "X-Amzn-Trace-Id": "Root=1-5fd23e5d-36153bc66a3a1c2a55fe4f03",
        "X-Consumer-Id": "65d55e32-b124-493f-b71e-a0978070f87f",
        "X-Consumer-Username": "lab04.consumer1",
        "X-Forwarded-Host": "localhost"
    },
    "json": null,
    "method": "GET",
    "origin": "172.21.0.1, 49.245.27.189",
    "url": "http://localhost/anything"
}

http get localhost:8000/rateLimiting apikey:abcd4321

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 568
Content-Type: application/json
Date: Thu, 10 Dec 2020 15:27:38 GMT
Server: gunicorn/19.9.0
Via: kong/1.3-enterprise-edition
X-Kong-Proxy-Latency: 5
X-Kong-Upstream-Latency: 510
X-RateLimit-Limit-hour: 60
X-RateLimit-Limit-minute: 3
X-RateLimit-Remaining-hour: 58
X-RateLimit-Remaining-minute: 2

{
    "args": {},
    "data": "",
    "files": {},
    "form": {},
    "headers": {
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate",
        "Apikey": "abcd4321",
        "Host": "httpbin.org",
        "User-Agent": "HTTPie/2.3.0",
        "X-Amzn-Trace-Id": "Root=1-5fd23e6a-753b380438a86d980f1d11a0",
        "X-Consumer-Id": "af0ed4d4-b566-456c-a58e-3b52272ef65d",
        "X-Consumer-Username": "lab04.consumer2",
        "X-Forwarded-Host": "localhost"
    },
    "json": null,
    "method": "GET",
    "origin": "172.21.0.1, 49.245.27.189",
    "url": "http://localhost/anything"
}
```

```bash
http post localhost:8001/consumers username=anonymous_users

HTTP/1.1 201 Created
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 136
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 15:29:17 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: Pdmz38vQu9BiMaTSZNVGfnWUWtN9OOV5

{
    "created_at": 1607614157,
    "custom_id": null,
    "id": "301e4edb-84df-4214-a5f2-d087d5f6e7a7",
    "tags": null,
    "type": 0,
    "username": "anonymous_users"
}

http get localhost:8001/routes/ratelimit-route/plugins

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 1126
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 15:29:57 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: Q5E63rZM9fV7wZIjW4bwX5clyBoxpPRD

{
    "data": [
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
    ],
    "next": null
}

CONSUMER_ID=$(http get localhost:8001/consumers/anonymous_users -b | jq -r .id)
PLUGIN_ID=$(http get localhost:8001/routes/ratelimit-route/plugins -b | jq -r '.data[] | select(.name == "key-auth") | .id')
http patch localhost:8001/plugins/${PLUGIN_ID} config.anonymous=${CONSUMER_ID}

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: http://localhost:8002
Connection: keep-alive
Content-Length: 414
Content-Type: application/json; charset=utf-8
Date: Thu, 10 Dec 2020 15:45:08 GMT
Server: kong/1.3-enterprise-edition
Vary: Origin
X-Kong-Admin-Request-ID: 05yy7pL57KAAJnYMVoQAbUm9kvsJkDMy

{
    "config": {
        "anonymous": "65d55e32-b124-493f-b71e-a0978070f87f",
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

http get localhost:8000/rateLimiting apikey:abcd1234
HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 568
Content-Type: application/json
Date: Thu, 10 Dec 2020 15:45:33 GMT
Server: gunicorn/19.9.0
Via: kong/1.3-enterprise-edition
X-Kong-Proxy-Latency: 16
X-Kong-Upstream-Latency: 815
X-RateLimit-Limit-hour: 600
X-RateLimit-Remaining-hour: 598

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
        "X-Amzn-Trace-Id": "Root=1-5fd2429c-0a8e4381111058d135531ced",
        "X-Consumer-Id": "65d55e32-b124-493f-b71e-a0978070f87f",
        "X-Consumer-Username": "lab04.consumer1",
        "X-Forwarded-Host": "localhost"
    },
    "json": null,
    "method": "GET",
    "origin": "172.21.0.1, 49.245.27.189",
    "url": "http://localhost/anything"
}

http get localhost:8000/rateLimiting

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 578
Content-Type: application/json
Date: Thu, 10 Dec 2020 15:45:47 GMT
Server: gunicorn/19.9.0
Via: kong/1.3-enterprise-edition
WWW-Authenticate: Key realm="kong"
X-Kong-Proxy-Latency: 1
X-Kong-Upstream-Latency: 784
X-RateLimit-Limit-hour: 600
X-RateLimit-Remaining-hour: 597

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
        "X-Amzn-Trace-Id": "Root=1-5fd242ab-6f00fc8c47f6621b713ee0f5",
        "X-Anonymous-Consumer": "true",
        "X-Consumer-Id": "65d55e32-b124-493f-b71e-a0978070f87f",
        "X-Consumer-Username": "lab04.consumer1",
        "X-Forwarded-Host": "localhost"
    },
    "json": null,
    "method": "GET",
    "origin": "172.21.0.1, 49.245.27.189",
    "url": "http://localhost/anything"
}
```

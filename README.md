# Serverless Java17 Quarkus Web Adapter Container Example

| -                       | -                           |
|:------------------------|-----------------------------|
| Java version            | Java17                      |
| Application Framework   | Quarkus 3.0.2.Final         |
| Deployment Framework    | AWS SAM CLI 1.78.0          |
| Development environment | MacBook Air M1 2020 Montery |
| » JDK for local build   | Corretto-17.0.7.7.1         |
| » Container build       | Docker Desktop 4.19.0       |

## Result of K6

```

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

  execution: local
     script: slsjava_quarkus_wa_ecr.js
     output: -

  scenarios: (100.00%) 1 scenario, 200 max VUs, 31s max duration (incl. graceful stop):
           * default: 200 looping VUs for 1s (gracefulStop: 30s)


     data_received..................: 1.2 MB 271 kB/s
     data_sent......................: 137 kB 32 kB/s
     http_req_blocked...............: avg=530.12ms min=206.76ms med=495.61ms max=1.18s    p(90)=782.95ms p(95)=933.96ms
     http_req_connecting............: avg=82.6ms   min=57.31ms  med=76.19ms  max=146.18ms p(90)=117.48ms p(95)=129.05ms
     http_req_duration..............: avg=2.16s    min=1.93s    med=2.15s    max=2.68s    p(90)=2.3s     p(95)=2.36s   
       { expected_response:true }...: avg=2.16s    min=1.93s    med=2.15s    max=2.68s    p(90)=2.3s     p(95)=2.36s   
     http_req_failed................: 0.00%  ✓ 0         ✗ 200  
     http_req_receiving.............: avg=62.25µs  min=20µs     med=52.5µs   max=699µs    p(90)=97.1µs   p(95)=118.24µs
     http_req_sending...............: avg=64.66µs  min=26µs     med=46.5µs   max=1.66ms   p(90)=96.1µs   p(95)=118.14µs
     http_req_tls_handshaking.......: avg=427.45ms min=129ms    med=402.69ms max=1.01s    p(90)=688ms    p(95)=824.89ms
     http_req_waiting...............: avg=2.16s    min=1.93s    med=2.15s    max=2.68s    p(90)=2.3s     p(95)=2.36s   
     http_reqs......................: 200    46.376328/s
     iteration_duration.............: avg=3.69s    min=3.31s    med=3.66s    max=4.3s     p(90)=3.91s    p(95)=4.07s   
     iterations.....................: 200    46.376328/s
     vus............................: 16     min=16      max=200
     vus_max........................: 200    min=200     max=200


running (04.3s), 000/200 VUs, 200 complete and 0 interrupted iterations
default ✓ [======================================] 200 VUs  1s
```

**CloudWatch Logs Insights**
query-string:
```
filter @type="REPORT" and ispresent(@initDuration)
| stats count() as coldStarts, avg(@maxMemoryUsed), avg(@duration), avg(@initDuration), min(@initDuration), max(@initDuration) by bin(10m)
```
---
| coldStarts | avg(@maxMemoryUsed) | avg(@duration) | avg(@initDuration) | min(@initDuration) | max(@initDuration) |
|------------|---------------------|----------------|--------------------|--------------------|--------------------|
| 101        | 127019801.9802      | 5.3632         | 1921.5171          | 1771.49            | 2225.49            |
---

## Getting Started

### Build
```make
make build-native-image
make sam-build
```

### Deploy (Initial)
```make
make sam-deploy-guided
```

### Deploy
```
make sam-deploy
```


다음 [grafana article](https://grafana.com/blog/2016/01/05/logs-and-metrics-and-graphs-oh-my/)에서는 log와 metrics의 특징에 대해 설명한다.
## log

log는 다양한 형태로 들어온다. 유닉스 시스템에서는 `/var/log/syslog` 파일 안의 텍스트 로그나, wtmp 안의 이진로그, `/var/log` 안에 있는 어플리케이션 로그들을 볼 수 있다.

모니터링을 위해 전달될 때, 우리가 얘기해볼 것은 어플리케이션 로그, 그 중에서도 `request log`다.  각 request들은 어느 엔드포인트에 적중했는지, 얼마나 걸렸는지, 무슨 결과를 반환했는지 등을 알려준다.

```
127.0.0.1 - frank [10/Oct/2000:13:55:36 -0700] "GET /apache_pb.gif HTTP/1.0" 200 2326
```

## metrics

측정항목은 통계를 나타내는 변수 지표다. 예를들면 이벤트가 발생할 때마다 증가하는 카운터가 있다.


```
# HELP api_http_request_total HTTP requests to the API
api_http_request_total{method="post",code="200"} 5027
api_http_request_total{method="post",code="400"} 1023
```

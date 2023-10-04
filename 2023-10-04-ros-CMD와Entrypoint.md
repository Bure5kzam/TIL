---
layout: post
title: Dockerfile CMD와 Entrypoint
date: 2023-10-04 11:18
category:
author:
tags: []
summary:
---

CMD와 ENTRYPOINT는 Docker 컨테이너를 시작할 때 실행될 쉘 명령을 지정하는 지시어다.

지시어는 두 가지 형식이 있다.

<지시어> <커맨드>
<지시어> ["커맨드1", "커맨드2"]

CMD는 컨테이너 인스턴스 실행 중 CLI로 재정의 할 수 있는 매개변수이다. 실행 시 CLI, 도커 스크립트에서 매개변수로 CMD를 지정하면 기존의 CMD 지시어는 무시된다.

반면 ENTRYPOINT는 재정의 할 수 없는 매개변수다. 무시되지 않지만 명령의 인수로 처리되어 추가된다.

## CMD 테스트

```bach
# Dockerfile.cmd_test
FROM ubuntu:22.04

CMD ["echo", "hello_world"]
```

```bash
FROM ubuntu:22.04

CMD ["echo", "hello cmd"]
~
```

docker run 은 cmd 매개변수 수정을 지원한다.

`Usage:  docker run [OPTIONS] IMAGE [COMMAND] [ARG...]`

쉘에서 cmd 값을 새로 지정하면 이전 내용이 수정된다.

```bash
ros@burePool:~/test$ docker run test
hello_world
ros@burePool:~/test$ docker run test echo "hello new cmd"
hello new cmd
```

## CMD와 ENTRYPOINT 혼용시 주의사항

cmd와 entrypoint를 같이 사용하면 cmd가 entrypoint의 매개변수로 취급된다.

```bash
#Dockerfile.cmd_and_entrypoint
FROM ubuntu:22.04

CMD ["echo","-e", "hello cmd\n"]
ENTRYPOINT ["echo", "-e",  "hello entrypoint\n"]
```

```bash
ros@burePool:~/test$ docker run test
hello entrypoint
 echo -e hello cmd

ros@burePool:~/test$ docker run test hello new cmd
hello entrypoint
 hello new cmd
 ```



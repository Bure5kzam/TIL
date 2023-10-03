---
layout: post
title: Dockerfile 작성할 때 ENV와 ARG의 차이
date: 2023-10-01 20:28
category: docker
author: Bure5kzam
tags: []
summary: 수정했을 때 이미지 재빌드가 필요하면 ARGS, 아니라면 ENV
---

dockerfile에는 환경변수로 사용할 수 있는 ENV와 ARG가 있다.

둘을 어떻게 구분해서 사용해야 할까

## Dockerfile의 처리 과정

Dockerfile은 Docker engine이 이미지를 생성하기 위해 읽는 파일이며, 이를 이미지 빌드라고 한다.

빌드된 이미지는 레지스트리에 저장되었다가 `docker run` 이나 `docker-compose up` 등으로 컨테이너 인스턴스를 생성할 때 사용된다.

## ENV와 ARG의 용례 구분

컨테이너 생성 명령어에서 `ENV`와 `ARG` 모두 지정할 수 있다.

`ARG` 지시문은 빌드 중에 유저가 전달할 수 있는 변수를 정의한다. `ARG` 값을 수정하면 다른 이미지를 생성되며, 기존에 생성된 이미지에서 수정할 수 없는 지시문이다.

`ENV` 지시문은 OS 환경 변수를 설정한다. 컨테이너 인스턴스를 생성할 때 지정한 값은 이미 빌드된 이미지에서 해당 같은 Key값을 갖는 환경변수를 덮어쓴다. 따라서 빌드된 이미지에서 값만 수정하여 재사용할 수 있다.

따라서 만약 빌드 시간에 이미지를 재구성하려면 ARG로 지정하는 것이 좋다. 하지만 이미 빌드된 이미지를 수정하지 않고 같은 런타임에 재구성하려면 (같은 이미지에서 세팅만 다르게 하려면) ENV를 사용하는 것이 좋다.

## ARGS 수정에 의한 빌드 캐쉬 영향

ENV와 다르게 ARG 변수가 수정되면 빌드된 이미지는 유지되지 않는다. 그래서 ARG 변수는 빌드 캐싱에 영향을 미친다. 만약 도커 파일에서 ARG 변수가 다르게


## Reference

[Stackoverflow / ARG or ENV, which one to use in this case?](https://stackoverflow.com/questions/41916386/arg-or-env-which-one-to-use-in-this-case)

[Dockerfile Reference / Impact on build caching](https://docs.docker.com/engine/reference/builder/#impact-on-build-caching)

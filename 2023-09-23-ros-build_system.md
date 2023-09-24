---
layout: post
title:
date: 2023-09-23 17:48
category:
author:
tags: []
summary:
---

**ament는 메타 빌드 시스템입니다.**

- 패키지를 빌드, 설치하기 위한 빌드 시스템(CMake, Python setup tools)
- 커맨드 호출 시 패키지를 토폴로지 순서로 호출하는 기능

**ament commandline tool**

`ament_tools`는 패키지 빌드, 테스트, 설치, 제거 기능을 제공하는 명령줄 도구를 제공하는 Python 패키지입니다.

ament_tool을 교체하지 않아도 다른 빌드 유형 (파이썬, C++)를 빌드할 수 있습니다.

**build type**

각 패키지는 export section의 build_type 태그로 패키지 매니페스트에서 정의됩니다.



install 공간 구성에는 환경 변수 지정이 필요할 수 있습니다.

**Environment**

```md
PATH=설치된 실행파일 위치
PYTHONPATH=파이썬 코드의 위치
```

각 패키지는 필요 환경을 설정하는 쉘 스크립트를 제공할 수 있으며, 이는 <prefix>/share/<pkg-name>에 있습니다.

`local_setup.*` 은 패키지에 이정된 환경변수를 업데이트 할 때 사용합니다.

install 공간의 루트의 여러 쉘 스크립트는 ament tool에 의해 생성됩니다. `local_setup.*` 파일들은 패키지들은 인스톨 공간의 모든 패키지들을 반복해서 읽고(ament index에 있는 package들을 읽어서) 페키지에 지정된 파일들을 소싱합니다. `setup.*` 파일들은 `install` 공간의 바깥 워크스페이스들을 고려하고 (ament index의 parent_prefixp_path 리스트를 읽어서) `local_setup.*` 파일 전에 소싱합니다.

**Optional symlinked install**

코드를 변경하고, 빌드하고, 설치하고, 실행하여 변경 사항을 확인하는 개발 주기의 효율성을 극대화하는 것이 매우 중요합니다. 일반적으로 설치 단계는 일부 리소스들을 소스 공간에서 `install` 위치의 최종 목적지로 복사하는것을 포함합니다. 대신 `ament`는 심볼릭 링크 사용하도록 할 수도 있습니다. (플렛폼이 지원한다면) 이는 개발자가 소스 공간에 있는 리소스들을 바꾸고 여러 상황에서 설치 단계를 건너뛸수있게 해줍니다.

이는 CMake 패키지들을 대상으로 선택적으로 `CMake`의 install() 함수를 오버라이딩하여 이루어집니다.

파이썬 패키지에 대해서는 설치를 위해 development mode가 사용됩니다. symlinked install 은 선택적인 기능이며 커맨드라인에서 `--symlink-install` 을 지정하여 사용됩니다.

**ament linters**

`ament`는 소스 코드 컴파일이 ROS 2 style 가이드라인을 따르는지 확인하기 위해 몇개의 linters 들을 제공합니다. linter를 사용하는것은 선택적이지만 패키지의 자동화된 테스트 부분으로 통합하는 것은 매우 쉽습니다.

`linter`는 기준에 관련되지 않은 스타일도 체크할 수 있습니다. cppcheck는 정적으로 코드를 분석하고 `semantic bugs`를 검사합니다.

**ament_auto**

이것은 ament 패키지의 CMake code 쓰기를 단순화하는것을 목표로 합니다. 이것은 manifest에서 그것들을 분리해서 의존성을 반복적으로 지정하는 것을 피합니다. 추가적으로 대화에 의존하는 몇가지 단계를 자동화합니다.

- 의존성에서 나오는 모든 정보들은 컴파일과 모든 타겟 링킹에 사용됩니다.
- 패키지가 include 폴더를 가지고 있다면 해당 폴더를 include directories에 추가가하고, 폴더에 있는 모든 헤더들을 설치하고, include 폴더를 downstream 패키지로 내보냅니다.
- 만약 패키지가 msg나 srv 하위 폴더 안에 있는 인터페이스 정의를 포함한단다면 자동으로 처리될 것입니다.
- 모든 라이브러리들과 `executables`들은 기본 위치에 설치될 것입니다.




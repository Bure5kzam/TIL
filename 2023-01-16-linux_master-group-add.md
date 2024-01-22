
## $groupadd

그룹을 생성하는 명령어입니다.

### GID 관련 옵션

| 주요 옵션        | 내용                                                                                                   |
| ---------------- | ------------------------------------------------------------------------------------------------------ |
| -g, --gid _GID_  | 해당 그룹 GID로 생성 <br/>                                                                             |
| -f, --force      | 문제가 발생하면 강제로 수행. 예를들어 gid가 이미 존재하면 다른 유니크한 gid를 선택함.                  |
| -o, --non-unique | 중복 GID 선택                                                                                          |
| -s, --system     | 시스템 그룹으로 생성합니다. GID가 login.defs의 `SYS_GID_MIN`에서 `SYS_GID_MAX` 사이 범위로 결정됩니다. |



### login.defs 관련 옵션

| 주요 옵션             | 내용                              |
| --------------------- | --------------------------------- |
| -K, --key _KEY=VALUE_ | login.defs를 수정하는 옵션입니다. |
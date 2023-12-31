# vscode

## sync

vscode는 github 계정 기반 sync를 지원해서 기기에 한번 구축해두면 인터넷 엑세스가 된다는 가정하에 제약없이 가져올 수 있다.

**github sync로 지원하는 동기화 항목** (23.12.31)

- Configuration
- Shortcut key binding
- User code Snippet, [[vscode-snippet]]
- User task
- UI state
- Extension
- Profile

## plugin

sync를 활용한 동기화는 인터넷이 있고 로그인이 가능한 환경에서는 문제가 없다. 하지만 오프라인 환경이 잦고 타인의 기기에서 사용해야 하는 경우가 많은 임베디드 특성상, 플러그인으로 만들어 사용하는게 더 적합하지 싶다.

마침 최근 사용하기 시작한 python으로 확장 프로그램을 개발할 수 있어서 크게 어렵지 않을 것 같다는 생각도 한다.

--- 

sync 대상이 아니지만 자주 적용해야 하는 설정들도 있다. 

## workspace

워크스페이스에 적용하는 vscode 설정은 sync가 제공되지 않는다.

- launch
- debug

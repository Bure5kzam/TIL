
# 개요

## 추상 팩토리란

추상 팩포리 패턴은 `factory method`에서 확장된 패턴이다.

팩토리 메서드 패턴에서 `factory` 클래스가 반환할 `production` 목록을 정의하는 `Abstract Factory interface`를 추가로 구현해야 하며,  적절한 `Abstract Factory Interface` 타입 변수에 적절한 팩토리를 할당해서 사용한다.


# 추상 팩토리 패턴의 구성요소

추상 팩토리 패턴의 구성요소는 `client`, `abstart factory`, `factory`, `production`이 있다.

`client` : 팩토리들에 적용할 공통 로직 구현
`factory interface` : 팩토리들이 준수해야 할 `production` 생성 메서드 목록을 정의
`factory impl` : 팩토리별 실제 `production` 생성 메서드를 구현
`production interface` : 제품이 구현해야할 멤버 정의
`production impl` : 제품 별 멤버 구현


# 클래스 관계 종류

## 상속,  일반화 (Generalization)

일반화는 일반적인 일반적인 클래스와 더 상세한 클래스 간의 관계다.

상세한 클래스의 인스턴스들은 간접적으로 일반적인 클래스의 인스턴스가 될 수도 있다. 그러므로, 상세한 클래스는 일반적인 클래스의 기능을 상속한다.

- is-a 관계라고도 한다.
- 추상 클래스의 이름은 이텔릭체로 표기한다

   
## 집합 (Aggregation)

- `part of` 관계라고도 한다.
- A에서 B는 독립된 라이프사이클을 가진다.
- 흰 다이아몬드로 표시한다.

## 합성 (Composition)

- A는 B와 동일한 라이프사이클을 가진다.
- 검은 다이아몬드로 표시한다.

## 실체화 (Realization)

인터페이스와 클래스 간의 관계를 의미한다.

- 점선과 삼각 헤드로 표현한다

## 의존 (Dependency)

메소드 내에서 객체가 다른 클래스 객체를 사용하는 경우가 있다.
만약 오브젝트가 필드로 저장되지 않는다면 의존관계라고 한다.

- 점선과 `<-`화살표로 표시한다.
5. 다중성 (Multiplicity)

Reference
https://www.visual-paradigm.com/guide/uml-unified-modeling-language/uml-class-diagram-tutorial/

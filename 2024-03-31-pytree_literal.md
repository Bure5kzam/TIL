## literal_and_class.py

blackboard 변수 할당을 테스트한 소스코드.

### 개요
blackboard 변수 할당 시 변수 이름에 구분자를 포함하여 지정할 수 있음

그럼 blackboard 객체를 통해 공유 저장소 값에 접근할 수 있음.

```python
# * 1. blackboard with literal
print("\n 1. blackboard with literal")
blackboard_literal = py_trees.blackboard.Client(
    name="literal"
)

blackboard_literal.register_key("/namespace1/namespace2", Access.WRITE)
blackboard_literal.namespace1.namespace2 = "this is literal value"

print(blackboard_literal.namespace1.namespace2)
#  1. blackboard with literal
# this is literal value
```


문제는 blackboard에 클래스를 할당할 수도 있는데, 객체의 속성에 접근할 때 똑같이 '.' 로 접근한다는 점.

```python
# * 2. blackboard with class
print("\n 2. blackboard with class")
class Dataclass() :
    def __init__(self):
        self.namespace2 = "this is class value"

blackboard_class = py_trees.blackboard.Client(
    name="class"
)

blackboard_class.register_key("/namespace1", Access.WRITE)
blackboard_class.namespace1 = Dataclass()

# 값이 서로 다른 네임으로 공존하는 모습
print(f"{blackboard_class.namespace1.namespace2}")
#  2. blackboard with class
# this is class value
```

`.`이 나타날 경우 파이썬은 뒤의 객체가 클래스의 속성인지 blackboard의 변수인지를 판단해야 한다.

실험 결과 클래스로 먼저 판단하는 것 같다.

```python
def blackboard_with_both():
    blackboard_another = py_trees.blackboard.Client(
        name="another"
    )

    blackboard_another.register_key("/namespace1/namespace2", Access.READ)
    blackboard_another.register_key("/namespace1", Access.READ)

    print(f"{blackboard_another.namespace1.namespace2}")
    # output
    # this is class value

```

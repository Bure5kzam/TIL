
디스크립터는 객체의 속성을 조회, 저장,  삭제 로직을 구현할 수 있게 해준다.

클래스 속성을 디스크립터로 작성하면 파이썬 인터프리터는 동명의 인스턴스 속성에 접근할 때 해당 디스크립터의 `__get__` 또는 `__set__`을 이용한다.

```python
class Ten:
    def __get__(self, obj, objtype=None):
        return 10

class A:
    x = 5                       # 일반 클래스 속성
    y = Ten()                   # 디스크립터 인스턴스
```

```bash
a = A()                     # Make an instance of class A
>>> a.x                         # Normal attribute lookup
5
>>> a.y                         # Descriptor lookup
10

a.x에 접근할 때는 dot 연산자가 클래스 딕셔너리에서 에서 'x' : 5 를 찾아온다.

a.y에 접근할 때는 dot 연산자가 __get__ 메소드에 의해 인식되는 디스크립터 인스턴스를 찾는다. 메소드는 10을 반환한다.
```


- 디스크립터로 구현한 속성은 클래스/인스턴스 딕셔너리에 저장되지 않는다.


# Reference

https://docs.python.org/ko/3/howto/descriptor.html

https://stackoverflow.com/questions/3798835/understanding-get-and-set-and-python-descriptors

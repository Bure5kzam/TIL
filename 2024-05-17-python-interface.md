# 인터페이스

파이썬 인터페이스는 abc 모듈과 함께 구현할 수 있다.

```python
from abc import ABC
from abc import ABC, abstractmethod

class TestClass(ABC):
	@abstractmethod
	def helllo(self):
	pass

  

	@classmethod
	def __subclasshook__(cls, C) :
		# 이 조건에 맞으면 TestClass의 서브클레스로 간주
		if cls is TestClass:
			if any("__iter__" in B.__dict__ for B in C.__mro__):
				return True
		return NotImplemented
	
class TestImplClass(TestClass)
	def __iter__(self):
		while True:
		yield
assert issubclass(TestImplClass, TestClass)
```

# 메타 클래스
---

`type`는 클래스를 생성하는 클래스다. 모든 클래스들은 `type` 클래스를 통해 생성된다.


```python

class Meta_Singleton(type):
	ist = {}
	def __new__(cls, name, base ,dict):
		ist = super().__new__(cls, name, base, dict)
		print("singleton meta")
		return ist
	
	def __init__(self, base , dict, attr):
		super().__init__(self)
	
		print("singleton meta init")
	
	def __call__(cls, *args: Any, **kwargs) -> Any:
	
		print("singleton meta call")
		if cls not in cls.ist:
			cls.ist[cls] = super(Meta_Singleton, cls).__call__(*args, **kwargs)	
		return cls.ist[cls]

  

class NormalClass( metaclass = Meta_Singleton):

	def __init__(self):
	
		"""
		선언시
		1. metaclass __new__로 메타 클래스 인스턴스가 생성된다.
		2. metaclass __init__로 초기화된다.
		
		인스턴스 생성시
		
		1. metaclass의 __call__을 호출해서 type의 __call__을 생성한다.
		"""
		super().__init__()
		print("hello")
```


파이썬에서 `self`는 현재 클래스의 인스턴스에 접근할 수 있고, `cls`는 현재 클래스에 접근할 수 있는 변수

`Meta.__new__` : 다른 클래스의 메타 클래스로 지정되어 생성될 때 호출
`Meta.__init__` : 메타 클래스로 지정되어 생성됐을 때 함께 호출
`Meta.__call__` :  다른 클래스의 인스턴스를 생성할 때 호출


```bash
__new__ : 다른 클래스의 메타 클래스로 지정되어 생성될 때 호출
__init__ : 메타 클래스로 지정되어 생성됐을 때 함께 호출
__call__ :  다른 클래스의 인스턴스를 생성할 때 호출
singleton meta
singleton meta init
1. Singleton class

A init
A init
True

2. Singleton meta

singleton meta call <class '__main__.NormalClass'>
hello
singleton meta call <class '__main__.NormalClass'>
True
```

파이썬에서 메소드 호출시 argument를 전달할 때는 두 가지 전달 방법이 있다.

- positional argument : 제공순서에 영향을 받음, 리스트 객체에 담겨서 전달됨
- keyward argument : 제공순서 영향 없음, 딕셔너리 객체에 담겨서 전달됨

## Positional argument

메소드 호출 시에 순서대로 제공된 인자들을 뜻함

```python
def add(a, b): 
	return a + b 
	
result = add(3, 5) 
print(result) # 출력 결과: 8
```

## Keyward argument

메소드 호출 시에 키워드로 제공된 인자들을 뜻함

```python
def divide(dividend, divisor): 
	return dividend / divisor
	
result = divide(divisor=2, dividend=10) 
print(result) # 출력 결과: 5.0
```

만약 메서드에서 named 파라미터로 정의되어 있지 않으면 kwargs라는 특별한 파라미터에 들어감

```python
def example_function(*args, **kwargs):
	print("Positional arguments:")
	for arg in args: 
		print(arg)
		
	print("Keyword arguments:")
	for key, value in kwargs.items():
		print(f"{key}: {value}")

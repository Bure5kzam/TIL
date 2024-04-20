# Blocking call이란

동시성(concurrent) 프로그래밍 에서 `blocking call`은 특별한 의미를 갖는 `함수 호출 행위`다. `blocking call`은 특정 조건을 기다리는 함수를 호출하고, OS에게 쓰레드가 기다리는 동안 아무 일도 일어나지 않고 있다는 신호t를 보낸다.

신호를 받은 OS는 쓰레드가 `blocking function call` 수행 중임을 알아치리고 다른 쓰레드로 `context switching`을 한다.

## 코드 예시

```python
import threading
import time

lock = threading.Lock()
def func(with_blocking_call : bool = False):
	th1 = threading.current_thread()
	for num in range(10):
		if with_blocking_call:
		time.sleep(1)
		lock.acquire()
		print(f" [{th1.native_id}] : {num}")
		lock.release()

def execute_thread_with_blocking_call():
	print("1. call with blocking (context switching)")
	th1 = threading.Thread(target=func, args=(True,))
	th2 = threading.Thread(target=func, args=(True,))
	  
	th1.start()
	th2.start()
	
	threading.Thread.join(th1)
	threading.Thread.join(th2)

def execute_thread_without_blocking_call():
	print("2. just call (no context switching)")
	th1 = threading.Thread(target=func, args=(False,))
	th2 = threading.Thread(target=func, args=(False,))
	
	th1.start()
	th2.start()

execute_thread_with_blocking_call()
execute_thread_without_blocking_call()
```
### blocking call

```bash
1. call with blocking (context switching)
 [365809] : 0
 [365810] : 0
 [365810] : 1
 [365809] : 1
 [365810] : 2
 [365809] : 2
 [365810] : 3
 [365809] : 3
 [365810] : 4
 [365809] : 4
 [365810] : 5
 [365809] : 5
 [365810] : 6
 [365809] : 6
 [365810] : 7
 [365809] : 7
 [365810] : 8
 [365809] : 8
 [365810] : 9
 [365809] : 9
```
### No blocking call
```bash
2. just call (no context switching)
 [365850] : 0
 [365850] : 1
 [365850] : 2
 [365850] : 3
 [365850] : 4
 [365850] : 5
 [365850] : 6
 [365850] : 7
 [365850] : 8
 [365850] : 9
 [365851] : 0
 [365851] : 1
 [365851] : 2
 [365851] : 3
 [365851] : 4
 [365851] : 5
 [365851] : 6
 [365851] : 7
 [365851] : 8
 [365851] : 9
```



https://superfastpython.com/thread-blocking-call-in-python/

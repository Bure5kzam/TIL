# 코드

```python
# lock를 지정하면 thread-safety한 함수가 되는지 확인하는 테스트
# 동시에 두 쓰레드에서 print 함수를 실행함.
# print는 출력할 문자열을 buffer에 넣은 뒤 flush로 버퍼를 비우고 줄바꿈과 함께 출력함.
# thread-safety하지 않기 때문에 여러 쓰레드에서 호출하면 buffer에 여러 문자열이 동시에 들어가는 문제가 발생할 수 있음.

  

import threading
import time
from threading import Lock
lock = Lock()

  

def thread_func_no_lock():
	"""
	쓰레드 락을 사용하지 않은 쓰레드 함수. 여러 문자열이 한 줄에 출력될 위험이 있다.
	"""
	th = threading.current_thread()
	
	for num in range(6):
		print(f"{th.native_id}, {num}", flush=True)
		time.sleep(0.5)

  

def thread_func_lock():
	"""
	쓰레드 락을 사용. 동시에 두 쓰레드에서 print를 실행하는 일이 없어서 출력 결과가 섞이지 않는다.
	"""
	th = threading.current_thread()
	
	for num in range(6):
		lock.acquire()
		print(f"{th.native_id}, {num}", flush=True)
		lock.release()
		time.sleep(0.5)

  

print("#1 call thread unsafety function")
th1 = threading.Thread(target=thread_func_no_lock, args=())
th2 = threading.Thread(target=thread_func_no_lock, args=())
th1.start()
th2.start()
th1.join()
th2.join()
print()

  

print("#2 call thread safety function")
th1 = threading.Thread(target=thread_func_lock, args=())
th2 = threading.Thread(target=thread_func_lock, args=())
th1.start()
th2.start()
```

# 실행 결과

```bash
bure@burepool:~/practice/python$  cd /home/bure/practice/python ; /usr/bin/env /bin/python3 /home/bure/.vscode/extensions/ms-python.debugpy-2024.0.0-linux-x64/bundled/libs/debugpy/adapter/../../debugpy/launcher 38017 -- /home/bure/practice/python/threading/rlock/lock.py 
#1 call thread unsafety function
205431, 0
205432, 0
205431, 1
205432, 1
205431, 2
205432, 2
205431, 3
205432, 3
205431, 4
205432, 4
205431, 5205432, 5


#2 call thread safety function
205466, 0
205467, 0
205466, 1
205467, 1
205466, 2
205467, 2
205466, 3
205467, 3
205466, 4
205467, 4
205467, 5
205466, 5
```

# 결론

thread-saftey 한 함수를 만들려면 함수 내부에서 lock을 구현해주던가, 여러 쓰레드에서 동시에 실행하면 안된다.

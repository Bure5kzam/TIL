# 소스코드
```python
import time
import threading

# 함수의 지연 여부에 따라 thread의 ident 속성이 어떻게 할당되는지 파악해보기 위한 실험

def thread_func_no_delay():
	"""지연 없이 종료되는 함수
	"""
	print("done")

  

def thread_func_delay():
	print("give me 1 second")
	time.sleep(1)

  

def func_print_ident(th : threading.Thread):
	print (f"name : {th.name}, ident : {th.ident}, native_id : {th.native_id}")

  
  

print("1. no delay function")

list_th = [threading.Thread(name=f"thread_{th}", target=thread_func_no_delay) for th in range(5)]

list(map(lambda th : th.start(), list_th))
list(map(func_print_ident, list_th))
print("")

  

print("2. delay function")
list_th = [threading.Thread(name=f"thread_{th}", target=thread_func_delay) for th in range(5)]
list(map(lambda th : th.start(), list_th))
list(map(func_print_ident, list_th))
```

# 출력 결과

```bash
bure@burepool:~/practice/python$  cd /home/bure/practice/python ; /usr/bin/env /bin/python3 /home/bure/.vscode/extensions/ms-python.debugpy-2024.0.0-linux-x64/bundled/libs/debugpy/adapter/../../debugpy/launcher 44061 -- /home/bure/practice/python/threading/attribute/identifire_ident.py 
1. no delay function
done
done
done
done
done
name : thread_0, ident : 132488831694400, native_id : 205097
name : thread_1, ident : 132488823301696, native_id : 205098
name : thread_2, ident : 132488823301696, native_id : 205099
name : thread_3, ident : 132488823301696, native_id : 205100
name : thread_4, ident : 132488831694400, native_id : 205101

2. delay function
give me 1 secondgive me 1 secondgive me 1 second


give me 1 second
give me 1 secondname : thread_0, ident : 132488831694400, native_id : 205102
name : thread_1, ident : 132488823301696, native_id : 205103
name : thread_2, ident : 132488814908992, native_id : 205104
name : thread_3, ident : 132488601007680, native_id : 205105
name : thread_4, ident : 132488592614976, native_id : 205106
```

# 결론

thread의 ident는 파이썬의 GIL에 의해 할당되는 쓰레드 식별자다.
지정된 쓰레드 함수가 종료되면 같은 값이 재할당될 수 있다.

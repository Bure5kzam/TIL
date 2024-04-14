# 서비스에서 rclpy 종료시에 바로 빠져나오기


## example

```python

class ProcessThread(threading.Thread):
	def __init__(self, **kwargs):
	super().__init__(target=self.process)
	self.action1 : Action1 = kwargs["action1"]
	self.action2 : Action1 = kwargs["action2"]
	self.lock = threading.Lock()
	self._work_flag = False

	@property
	def work_flag(self):
		return self._work_flag

	@work_flag.setter
	def work_flag(self, data : bool):
		self.lock.acquire()
		self._work_flag = data
		self.lock.release()

	def setup(self, **kwargs):
		self.node : Node = kwargs["node"]
		self.action1.setup(**kwargs)
		self.action2.setup(**kwargs)
		self._task_group : asyncio.Future = None
		
	def process(self):
		try:
			while True:
				while not self.work_flag:
###############################################################
					if (not self.node.context.ok()):
						return
###############################################################
					print("hi")
					time.sleep(1)
					asyncio.run(self.step1())
					self.work_flag = False
		except Exception as ex:
			print(f"{ex.with_traceback()}")
	def cancel(self):
		return
		
	async def step1(self):
		print("start")
	try:
		req = SetBool.Request()
		task_call_op1 = asyncio.create_task(self.action1.call_operation())
		task_call_op2 = asyncio.create_task(self.action2.call_operation())
		
		self._task_group = asyncio.gather(task_call_op1, task_call_op2)
		await self._task_group
		print(self._task_group)
	except asyncio.CancelledError as ex:
		print(f"asyncio task was requested cancelling {ex}")
		print(f"{task_call_op1.cancelled}, {task_call_op2.cancelled}")
	finally :
		print("end")
```

## 결과
## 조건문 없을 경우

```bash
bure@burepool:~/practice/ros$ colcon build --packages-select service_example &&  ros2 run service_example executables 
Starting >>> service_example
--- stderr: service_example                   
/usr/lib/python3/dist-packages/setuptools/command/install.py:34: SetuptoolsDeprecationWarning: setup.py install is deprecated. Use build and pip and other standards-based tools.
  warnings.warn(
---
Finished <<< service_example [0.96s]

Summary: 1 package finished [1.81s]
  1 package had stderr output: service_example
hi
hi
hi
^CKeyboard interrupted
main : final exception start
ClientNode destroy start
ClientNode destroy end
main : final exception end
hi
hi
hi
hi
hi
hi
hi
hi
hi
^CException ignored in: <module 'threading' from '/usr/lib/python3.10/threading.py'>
Traceback (most recent call last):
  File "/usr/lib/python3.10/threading.py", line 1567, in _shutdown
    lock.acquire()
KeyboardInterrupt: 
```

## 조건문 추가 할 경우

```bash
bure@burepool:~/practice/ros$ colcon build --packages-select service_example &&  ros2 run service_example executables 
Starting >>> service_example
--- stderr: service_example                   
/usr/lib/python3/dist-packages/setuptools/command/install.py:34: SetuptoolsDeprecationWarning: setup.py install is deprecated. Use build and pip and other standards-based tools.
  warnings.warn(
---
Finished <<< service_example [0.99s]

Summary: 1 package finished [1.79s]
  1 package had stderr output: service_example
hi
hi
hi
^CKeyboard interrupted
main : final exception start
ClientNode destroy start
ClientNode destroy end
main : final exception end
bure@burepool:~/practice/ros$ 
```

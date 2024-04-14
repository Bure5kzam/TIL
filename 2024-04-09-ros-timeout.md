# future에 타이머 걸기

```python
async def async_sleep(node: Node, seconds: float):

# future를 생성하고, 타이머에 의해 future의 결과값이 설정되도록 지정
future = rclpy.task.Future()
def handler():
	future.set_result(None)
	timer = node.create_timer(seconds, handler)
	# future 값이 설정될 때까지 코루틴 블락킹
	
	await future
	timer.cancel()
	timer.destroy()
	return None

  
async def future_with_timeout(node: Node, future: rclpy.task.Future, timeout_sec: float):

	# 타이머나 인자의 future 콜백에 의해 완료되는 타이머용 future를 생성해서 코루틴을 블로킹한 후, 결과에 따라 예외를 발생하는 함수
	
	first_done_future = rclpy.task.Future()

  
def handler(arg=None):
	first_done_future.set_result(None)
	timer = node.create_timer(timeout_sec, handler)
	future.add_done_callback(handler)

	await first_done_future
	if not future.done():
	raise TimeoutError(f"Future timed out after {timeout_sec} seconds")
	
	timer.cancel()
	timer.destroy()

	return future.result()
```

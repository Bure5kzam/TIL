# 코루틴과 await

코루틴은 어느 지점에서든 종료되고 재개될 수 있는 서브루틴이다.

실행 중이던걸 중지하고 다른 코루틴을 실행할 수 있기 때문에 실행 순서가 탑-다운이 아니라 중구난방이 된다.

코루틴을 사용하면 멀티 쓰레드 없이도 병렬처리를 구현할 수 있다. 단 외부[^1]에서 코루틴의 실행 권한을 제어해서 병렬처리 되는 것이 아니고 실행 중인 코루틴이 스스로 실행을 중지해서 다른 코루틴에게 양도해주도록 구성되어야 한다. ^[[협력적 멀티테스킹](https://en.wikipedia.org/wiki/Cooperative_multitasking) ]

[^1]: 반대 개념인 선점형 멀티테스킹은  OS나 외부 프로세스가 쓰레드 같은 병렬처리 주체를 제어한다.

# 코루틴 정의하기

코루틴을 정의하려면 일반 서브루틴을 정의하고 예약어 def에 async를 붙여준다.
```python
# define coroutine
async def func():
	print("hi")
	
```

서브루틴과 다르게 코루틴은 호출하면 내용이 실행되지 않는다.
이는 코루틴 빌드 결과물인 코루틴 객체를 반환하며, 실행하려면 코루틴을 스케쥴링할 `loop`에 코루틴 객체를 제공해야 한다.

# 코루틴 객체 사용하기

코루틴은 스스로 실행 권한을 양도하는 구조이기 때문에 실행될 코루틴을 선정할 주체가 필요하다. asyncio에서는 이를 loop라고 한다. 모든 코루틴은 loop에 등록되어야 실행될 수 있다.


코루틴을 실행할 때는 `asyncio.run` 이나`asyncio.create_task`를 사용한다.

`asyncio.run`은 asyncio 프로그램의 첫 진입점으로 사용하며 일반적으로 한번만 호출한다.

`asyncio.create_task`는 이벤트 루프에 코루틴을 추가할 때 사용한다.

```python
# 코루틴으로 테스크를 생성한다. 루프에 등록되어 테스크의 라이프 사이클이 생성된다.
task = asyncio.create_task(task_coroutine())

# 현재 코루틴 실행 권한을 반환한다. task에게 넘어간다.
await task
```





# 코루틴의 중지 await

await 문을 만나면 awaitable object [^awaitable] 의 코루틴 실행을 일시 정지 시킨다.

[^awaitable]: awaitable obejct는 `await` 표현식에 사용될 수 있는 객체다. 코루틴이나 `_await_()` 메소드가 구현된 객체를 의미한다.

await는 코루틴 호출자가 해당 awiat를 만난 시점에서 `suspend`되고 `awaitable`이 완료될 때까지 기다리도록 유발한다.

```python
# await a coroutine
async def func():
	future = custom_coroutine()
	await future
```

만약 코루틴 객체가 완료될 때까지 기다리고 싶은데 await 사용은 피하고 싶다면 다음처럼 작성할 수 있다.

```python
async def func():
	future = custom_corountin
	while future.done():
		time.sleep(0.3)
```

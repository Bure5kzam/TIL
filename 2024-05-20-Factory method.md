# 개요

## 팩토리 메서드란

클래스의 생성자를 직접 호출하는 대신 `factory`로 생성하는 패턴이다.

팩토리 메서드에서는 오브젝트화 하는 기존의 클래스를 `production`라 부른다.

`production`을 사용하려면 인스턴스를 반환하는 `create_production` 메소드를 멤버로 갖는 `factory` 클래스를 정의해야 하며, 서브클래스에서 오버라이딩해서 개별 `production`을 반환하게 구현한다.

호출하는 입장에서는 production의 실제 타입을 신경쓰지 않고 필요한 `factory`를 호출해서 사용하거나 interface에 의거해서만 로직을 작성하면 된다.

# 팩토리 메서드의 구성요소

팩토리 메서드에는 `production`과 `factory`가 있다. (`caller` 는 설명의 편의를 위해 추가)

`caller`는 소스코드에서 `production`을 생성해서 사용하는 부분이다.
`production` 는 `caller`에서 호출해서 사용하는 클래스다. 인터페이스만 같으면 여러 버전으로 재정의해서 구현할 수 있다. 
`factory` 는 `production` 인스턴스를 반환하는 메서드를 가진 클래스다. `caller`와  `production` 사이의 추상화를 제공하며, 둘을 수정하지 않고도 생성할 제품을 변경할 수 있도록 해준다.

# 팩토리 메서드의 예시


### produciton

```python
from abc import ABC, abstractmethod

# 구현하려는 클래스들(production )

class Mobility(ABC):
	@abstractmethod
	def move(self):
		pass
	
class Truck(Mobility):
	def move(self):
		print("move on the road")

class Ship(Mobility):
	def move(self):
		print("move on the ocean")
```

### factory

``` python
# production의 추상화를 제공하는 클래스 (factory)
class MobilityFactory():
	def __init__(self, mean : str):
		self.mean : str = mean
	
    def transport(self):
	    factory : MobilityFactory = None
	    monility : Mobility= None
	    
	    if self.mean == "truck"
		    factory = self.TruckFactory()
		elif self.mean == "ship"
			factory = self.ShipFactory()
		else:
			raise ValueError()
		    
        print("start")
        mobility = self.create_mobility()
        mobility.move()
        print("arrive")
		
        
    def create_mobility(self):
        return Mobility()

class TruckFactory(MobilityFactory):
	def create_mobility(self) -> Truck:
		return Truck()

class ShipFactory(MobilityFactory):
	def create_mobility(self) -> Truck:
		return Ship()
```

### caller

```python
ENV = "truck"
if __name__ == "__main__":
	
    transportor : MobilityFactory
    mobility = MobilityFactory("truck")
    transportor.transport()
```


- `Mobility` 는 모든 `production` 들이 준수해야할 공통 인터페이스를 정의한다 => `Caller`는 production의 실제 타입을 몰라도 사용할 수 있다.
- `MobilityFactory`는 
	- production 들로 공통으로 수행할 로직을 정의한다.(transport 메서드) => 로직을 수정해야 할 때 caller의 소스코드를 직접 수정하지 않아도 된다.
	- 사용할 제품 팩토리를 반환하는 메서드를 정의한다. (create_mobility) => `production`을 추가/ 제거할 때 `caller`의 소스코드를 수정하지 않아도 된다.



## 팩토리 메서드의 장점


### 디커플링

팩토리 메서드 패턴을 사용하면 `caller`와 `production` 간에 코드가 분리된다. `production`의 생성자를 직접 호출하는 대신 `factory` 에서 반환해준 객체를 사용하기 때문이다.

### 개방 폐쇄 원칙

`production`을 실체화하는 클래스가 추가되어도 `caller`의 로직을 수정할 필요가 없다.

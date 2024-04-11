
`Anchor`를 사용하면 yaml 에서 데이터 구조에 별칭을 생성하고 참조할 수 있다.

# Contents
## Anchor

`anchor`는 value 데이터에 이름을 정의하는 기능이다.

key 뒤에 `&` 접두사와 함께 이름을 정의하면 해당 이름으로 엥커를 정의할 수 있다.

### 예시

```YAML

definitions:
	steps:
	 - step: &build-test 
		 name: Build and test 
		 script:
			 - mvn package
		 artifacts:
			 - target/**
```

위 코드는 다음 내용에 `build-test`라는 이름을 붙인다

```
 &build-test 
	 name: Build and test 
	 script:
		 - mvn package
	 artifacts:
		 - target/**
```


## Alias

Alias는 Anchor를 언급해서 실제 데이터를 참조하도록 하는 기능이다.

`*` 접두사로 Anchor 이름을 언급하면 실제 데이터로 치환된다.

### 예시

```yaml
pipelines:
	branches:
		develop:
			 - step: *build-test
		main:
			 - step: *build-test
```

위 내용은 아래로 치환된다.

```yaml

pipelines:
	branches:
		develop:
			step: 
				name: Build and test
				script:
					- mvn package 
				artifacts:
					- target/** 
		main:
			step:
				name: Build and test
				script:
					- mvn package 
				artifacts:
					- target/**
```

## Override value

`Alias`로 값을 참조할 때 일부 값은 재정의가 필요한 경우가 있다.

`Override value`는 Alias로 불러온 데이터를 부분 재정의하는 기능이다.

Alias 앞에 `<<:*` 를 달고 하단에 재정의할 속성을 나열한다.

### 예시

다음 코드의 main 부분은 build-test alias를 불러와서 재정의 한다.
```yaml
pipelines: 
	branches:
		develop:
			- step: *build-test
		main:
			- step:
				<<: *build-test
				name: Testing on Main
```


# Reference

https://support.atlassian.com/bitbucket-cloud/docs/yaml-anchors/

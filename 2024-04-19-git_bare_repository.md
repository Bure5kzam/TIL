
bare repository가 뭐고 어떨때 쓰면 좋을지 정리해봤다.

# bare repository란?

bare repository는 `working directory`가 없는 구조의 로컬 저장소다.

bare repository를 이해하려면 **현재 커밋의 실제 소스코드를 보관하는 디렉토리**인 `working directory`를 알아야 한다.

기억이 가물가물하면 다음 설명을 보고 넘어가자


## working directory란

`working directory` 는 `git` 현재 가리키는 커밋의 실제 소스코드를 반영하는 파일 디렉토리다.

예시와 함께 체감하기 위해 다음 예시를 보자

위 예시 이후 `b.py`와 `c.py`를 추가하는 커밋을 하나씩 추가했다.

```bash
bure@burepool:~/test/git_bare_test/normal_repo$ git log --oneline --name-status
ff8705c (HEAD -> master) develop : c.py 추가
A       c.py
ac282d3 develop : b.py 추가
A       b.py
5cd7968 develop : a.py 추가
A       a.py
```

현재 git은 `ff8705c`를 가리키고 있다. `working directory`인 normal_repo에는  `a.py`, `b.py`, `c.py`파일이 모두 존재한다.

```bash
bure@burepool:~/test/git_bare_test/normal_repo$ ls -l
합계 12
-rw-rw-r-- 1 bure bure 38 Mar 18 13:44 a.py
-rw-rw-r-- 1 bure bure 47 Mar 18 14:08 b.py
-rw-rw-r-- 1 bure bure 49 Mar 18 14:09 c.py
```

이제 `b.py` 와 `c.py`를 만들기 전 커밋을 가리키면 `working directory`에는 `a.py`밖에 없다.

```
bure@burepool:~/test/git_bare_test/normal_repo$ git log --oneline --name-status
5cd7968 (HEAD) develop : a.py 추가
A       a.py
bure@burepool:~/test/git_bare_test/normal_repo$ ls -l
합계 4
-rw-rw-r-- 1 bure bure 38 Mar 18 13:44 a.py
```

## 일반 git repo와 bare repo의 구조적 차이


`.git` 은 git의 branch나 index 같이 버전 관리에 필요한 정보들을 저장하는 디렉토리다. (이하 `git directory`)

일반적으로 `git repository`는 관리하기 편하도록  `working directory` 안에 `.git`이 들어있는 꼴로 되어있다.


```bash
# normal repository
bure@burepool:~/test/git_bare_test$ tree -aL 2 normal_repo/
normal_repo/
├── a.py
├── b.py
├── c.py
└── .git
    ├── branches
    ├── COMMIT_EDITMSG
    ├── config
    ├── description
    ├── HEAD
    ├── hooks
    ├── index
    ├── info
    ├── logs
    ├── objects
    └── refs
```


`bare repository`는 `working directory`가 없는 `깃 저장소`다.

때문에 원래는 `.git`  폴더 내부에 있던 메타데이터 파일들이 최상단으로 나와있다.

```bash

# bare repository
bure@burepool:~/test/git_bare_test$ tree -aL 1 bare_repo
bare_repo
├── branches
├── config
├── description
├── HEAD
├── hooks
├── info
├── objects
└── refs
```


# bare repository 필요성


이는 모든 상황에서 work directory가 필요한 것은 아니기 때문에 사용하며, 가까운 예시로 원격 git 서버가 있다.

개발자는 개발할 때 `working directory`의 소스코드를 수정하며 작업하지만 수정 내역을 관리하는 git 서버에서는 굳이 용량이 큰 소스코드로 관리할 필요가 없다. 대신 소스코드의 경량화된 snapshot 버전만을 보관하며 이 때 `bare repository`를 활용한다.

# bare repository 활용

`git directory`와 `work directory`를 분리할 수 있는 점을 이용해 여러 `working directory` 내용물을 한 경로에 합쳐서 사용할 수도 있다.

예시로 협업 레포인 `collaborate_repo`을 로컬로 받아다가 작업할 때, 개인 작업물인 `personal_repo` 의 소스코드를 가져와 사용하고 싶다고 하자.

각각 레포의 내용은 다음과 같습니다.

(personal과 )

물론 `personal` 저장소에서 `.git` 없이 파일만 가져와서 사용할 수도 있지만 버전 관리를 할 수 없다.

submodule로 추가하는 방법도 있지만 개인적인 작업물이기 때문에 협업 공간에 등록하고 싶지는 않을 때 사용할 수 있다.

bare repositpry를 활용하면 `personal_repo`와 `collaborate_repo`의 `work directory`를 한 디렉토리에 공유해놓고 독립적으로 관리할 수 있다.



```bash
bure@burepool:~/test/git_bare_test/example_compare$ tree -aL 2
.
├── collaborate_repo
│   ├── .git
│   └── team.py
│
└── personal_repo
    ├── branches
    ├── config
    ├── description
    ├── HEAD
    ├── hooks
    ├── info
    ├── objects
    ├── packed-refs
    └── refs
    
bure@burepool:~/collaborate_repo$ git log --oneline --name-status
3a8e286 (HEAD -> master) develop : add team code
A       team.py
```


`git` 명령어는 `--git-dir=PATH` 와  `--work-tree=PATH'` 옵션으로 적용할 `git directory`와 `working directory`를 지정할 수 있다.

`personal_repo`의 깃 정보 기준으로 현재 `working directory`의 상태를 확인해보자.

```bash
bure@burepool:~/test/git_bare_test/example_compare/collaborate_repo$ git --git-dir ../personal_repo/ --work-tree=./ status
현재 브랜치 main
커밋할 변경 사항:
  (스테이지에서 제외하려면 "git restore --staged <file>..."을 사용하시오)
        삭제함:        README.md
        삭제함:        personal.py

추적하지 않는 파일:
  (커밋할 사항에 포함하려면 "git add <파일>..."을 사용하십시오)
        team.py

```


personal 레포에는 원래 `README.md`와 `personal.py`가 있었는데, 현재 `working directory`에는 파일이 존재하지 않아서 삭제됐다고 표시되는걸 볼 수 있다.

그리고 기존에 등록되지 않은 `team.py` 파일은 스테이징 되지 않았다고 알려준다.


이번엔 `collaborate_repo` 의 깃 정보를 기준으로 `working directory`의 상태를 확인해보자.

```bash
bure@burepool:~/test/git_bare_test/example_compare/collaborate_repo$ git --git-dir ./.git --work-tree=./ status
현재 브랜치 master
커밋할 사항 없음, 작업 폴더 깨끗함
```

`collaborate_repo` 기준으로는 달라진게 없기 때문에 별 출력 내용이 없다.

이처럼 한 `working directory`에 2개의 git의 내용을 동시에 사용할 수 있음을 알 수 있다.


## 두 git의 소스코드를 한 working directory에 합치기

```bash
bure@burepool:~/test/git_bare_test/example_compare/collaborate_repo$ git --git-dir ../personal_repo/ --work-tree=./ reset --hard HEAD
HEAD의 현재 위치는 ff28904입니다 Create personal.py
bure@burepool:~/test/git_bare_test/example_compare/collaborate_repo$ ls -al
합계 24
drwxrwxr-x 3 bure bure 4096 Mar 18 17:43 .
drwxrwxr-x 4 bure bure 4096 Mar 18 17:29 ..
drwxrwxr-x 8 bure bure 4096 Mar 18 17:42 .git
-rw-rw-r-- 1 bure bure   31 Mar 18 17:43 personal.py    # from personal_repo
-rw-rw-r-- 1 bure bure  113 Mar 18 17:43 README.md      # from personal_repo
-rw-rw-r-- 1 bure bure   19 Mar 18 16:49 team.py        # from collabrate_repo
```


## 명령어 축약어 등록하기

personal git을 쓸 때마다 옵션을 다려면 매번 번거로울 것이다. 다음처럼 축약어로 사용하자

```bash
# alias 등록
bure@burepool:~/test/git_bare_test/example_compare/collaborate_repo$ git config alias.personal '!git --git-dir=../personal_repo/ --work-tree=./'

# alias 테스트
bure@burepool:~/test/git_bare_test/example_compare/collaborate_repo$ git personal status
현재 브랜치 main
추적하지 않는 파일:
  (커밋할 사항에 포함하려면 "git add <파일>..."을 사용하십시오)
        team.py

커밋할 사항을 추가하지 않았지만 추적하지 않는 파일이 있습니다 (추적하려면 "git
add"를 사용하십시오)
bure@burepool:~/test/git_ba
```



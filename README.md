# Motivoo-iOS

> ### 가족과 함께 만들어 나가는 오늘의 운동 습관

<br>

## 🍎 iOS Developer

| [윤빈](https://github.com/binisnil) | [효리](https://github.com/hyoring030) | [조은](https://github.com/LeeJoEun-01) |
| --- | --- | --- |
| <img width="600" alt="윤빈" src="https://github.com/Team-Motivoo/Motivoo-iOS/assets/109334968/e908fd81-e889-4215-b52e-4289fce8b9ca"> | <img width="600" alt="효리" src="https://github.com/Team-Motivoo/Motivoo-iOS/assets/109334968/163b8358-e883-4078-b193-07620222f504"> | <img width="600" alt="조은" src="https://github.com/Team-Motivoo/Motivoo-iOS/assets/109334968/1acb3d3e-8a76-420f-a2ae-5c818e17c51b"> |
| <p align = "center"> Home | <p align = "center"> MyPage, History | <p align = "center"> Onboarding, Login |

## 📦 Libraries

| Library | Version | Description |
| --- | --- | --- |
| https://github.com/kakao/kakao-ios-sdk | 2.20.0 | 카카오 소셜 로그인 시 사용 |
| https://github.com/Moya/Moya | 15.0.0 | Networking 시 사용 |
| https://github.com/SnapKit/SnapKit | 5.6.0 | UI AutoLayout을 잡을 때 사용 |
| https://github.com/devxoul/Then | 3.0.0 | 클로저를 통한 인스턴스 초기화를 할 수 있도록 도와주는 라이브러리 |
| https://github.com/onevcat/Kingfisher | 7.10.1 | 웹에서 이미지를 다운로드하고 캐싱하기 위해 설계된 순수 Swift 라이브러리 |

<br>

## 📖 Coding Convention

### Summary

```
1. 상속받지 않는 클래스는 final 키워드

2. 단일 정의 내에서만 사용되는 특정 기능 구현은 private 접근 제한자를 적극 사용

3. 임포트는 퍼스트파티, 서드파티 나누어서. 알파벳 순 정렬

4. MARK 주석은 위 아래 공백

5. 클래스, 구조체, 열거형, 프로토콜 등은 Upper Camel Case로 네이밍

6. 변수 상수, 함수 등은 lower Camel Case로 네이밍
```

[🚀모티뿌요의 코딩컨벤션 바로가기](https://www.notion.so/ee104bb97ea84c94af23f3cdab85851c?pvs=21)

<br>

## 🌳Branch 전략

### 1. 배포용 branch 와 구현용 branch를 나눕니다

```
- 배포 branch → main
- 개발 branch → develop
- 기능 구현 branch → feature
- 배포 이후, hotfix 브랜치*(출시 버전에서 발생한 버그를 수정 하는 브랜치)*를 사용할 예정입니다.
```

<br>


### 2. 기능을 기준으로 브랜치를 생성합니다

1. **feature branch는 develop branch로부터 생성**합니다.
2. 한 개의 기능을 기준으로 브랜치를 생성합니다.
    1. 적합한 예시 🙆🏻‍♀️
        - 홈 뷰 UI 구현 (O)
        - 홈 뷰 그래프 기능 구현 (O)
        - 홈 뷰 API 서버통신 구현 (O)
    2. 부적합한 예시 🙅🏻‍♂️
        - 홈 뷰 상단 layout (X)
        - 홈 뷰 collectionView cell 터치 이벤트 추가 (X)
        - 홈 뷰 만보수 통신 함수 구현 (X)

<br>

### 3. 새로운 기능 개발을 위한 feature branch 는 아래와 같은 규칙을 따라서 네이밍합니다.

```swift
ISSUE카테고리/#이슈번호
```

- 브랜치 네이밍 예시
    
```
  [ISSUE] → "[Network] 로그인 서버통신 구현 #23"
  [Branch Naming] → "network/#23"
```

```
  [ISSUE] → "[Feat] 온보딩 뷰 구현 #45"
  [Branch Naming] → "feat/#45"
```


[🚀모티뿌요의 ISSUE 컨벤션 바로가기](https://www.notion.so/ISSUE-f5a5efa2e8084dcf95567413d508f00e?pvs=21)

<br>

### 4. develop 브랜치에서 절대 commit, push 하지 않습니다.

다른 레퍼런스를 참고하다보면, develop 브랜치에서 feature 기능을 따로 파지 않고, 수정사항을 develop 브랜치에 바로 commit push 하는 경우가 있습니다.

<br>

**💫 그러나, 안전한 개발을 위해 모티부에서는 develop 브랜치에 바로 commit push 하지 않도록 합시다!**

<br>


만약 수정사항이 생긴다면, Fix관련 이슈를 파고, 브랜치를 생성한 뒤 작업하는 것을 원칙으로 합니다.

<br>


### 5. 아래 순서를 지켜서 작업을 진행합니다.

```
1. 구현 기능 확인
2. local에서 develop 브랜치 pull 받기
3. 이슈 생성
4. 이슈의 카테고리와 번호를 확인 후, 브랜치 생성(ex: `feat/#22`)
5. 작업하기
6. PR 생성 및 코드리뷰
7. develop 브랜치로 merge
```

## ➰Merge 전략

**1. 코드리뷰 없이는 Merge 하지 않습니다.**

**2. 추가적인 세팅을 할 땐 모든 코드가 develop에 반영 된 후 진행합니다.**

중간중간 추가되는 폰트나 이미지를 프로젝트에 적용을 해야되는 시기가 올 수 있습니다.

이러한 상황에서는 아래와 같이 진행합니다.

```
1. 모든 코드가 develop에 반영해 merge
2. 추가된 이미지나 폰트, 색상들을 코드에 반영
3. 프로젝트 세팅을 한 브랜치를 develop에 머지
4. 각자 브랜치를 파서 작업
```


**3. Confilct는 되도록 두명 이상이 함께 해결합니다.**

## 🚓 Code Review 전략

### Pn룰

```
- p1: 꼭 반영해 주세요
- p2: 웬만하면 반영해주세요
- p3: 그냥 사소한 의견입니다. 그냥 넘어가도 좋아요!
```

### 예시

```
p1
class 앞에 final 키워드 빠져있습니다! 반영해주세용!

p3
이렇게 코드 구성을 짜는 것도 좋네요! 배워갑니당!
-> 칭찬이나 코드를 보고 느낀 점은 p3로 사용해주세요
```

## 📂 Foldering Convention

```bash
├── 📁Application
│   ├── 📜AppDelegate
├───├── 📜SceneDelegate
├── 📁Global
│   ├── 📁Extension
│   ├── 📁Literals
│   │   ├── 📜ImageLiterals
│   │   ├── 📜TextLiterals
│   ├── 📁Protocols
│   ├── 📁Resources
│   │   ├── 📁Font
│   │   ├── 📜Assets
│   │   ├── 📜Info.plist
│   ├── 📁SupportingFiles
│   │   ├── 📜LaunchScreen
│   │   ├── 📁UIComponents
│   │   │   ├── 📜components
│   ├── 📁Base
│   │   ├──📜BaseViewController
├───├───├──📜BaseView
├── 📁Data
│   ├── 📁Home
│   |   ├── 📁APIModel
├───├───├── 📁Model
├── 📁Network
│   ├── 📁Home
│   |   ├── 📜Service (Moya enum 파일)
├───├───├── 📜API (api 연동 함수)
├── 📁Feature
│   ├── 📁Home -> MVC
│   │   │   ├── 📁Views
│   │   │   │   ├── 📁Cells
│   │   │   │   │   ├── 📜Cell1
│   │   │   │   │   ├── 📜Cell2
│   │   │   │   ├── views
├───├───├───├── 📁ViewControllers

```

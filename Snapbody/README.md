# snapbody_mobile

펀디 7번째 시즌 - SNAPBODY 모바일 부분 ( 테스트 프로젝트로 변경 )

Flutter 프로젝트

Frontend: Flutter
Backend: Python


# Merge Rule

snapbody 조직 계정에서는 branch 관리에 upgrade가 필요하네요.

병합시 코드 리뷰를 거치는 rule 설정이 안되기 때문에, 저희끼리 잘 알아서 해야겠습니다!

1. 각 이슈별 branch를 따로 만들어서 코딩한다.
2. 병합을 시도할 때는 필히! Error 및 lint 경고가 있는지 확인하고, 없앤 후에 시도한다.
3. 작업을 시작할 때 꼭 Pull을 한 번 실행하고 시작한다.

기타 좋은 방법 있으면 건의 부탁드립니다!



# 파일이름, 위젯이름, 변수이름 짓는 법

파일 이름은 underbar로 구분된 소문자 이름을 사용합니다.

    param_get_it.dart
    param_screen.dart
    parma_datasource.dart
   
위젯 클래스 이름은 앞이 대문자인 Camel 방식을 사용합니다. 
    
    CaramelWidget
    AlbumScreen
    HomeScreen
    
변수 이름은 앞글자가 소문자인 Camel 방식을 사용합니다.

    nativeColor
    thisIsVariable

# 레이블
이슈에 대해 레이블을 붙임으로써 이슈에 대한 성격 규정.

issues 탭에서 레이블을 확인할 수 있음.

추가로 필요한 레이블은 추가해서 사용 가능.


# 마일스톤
작업을 결정하고 그에 따라 마일스톤을 부여. 

프로젝트 일정 및 업무 파악에 용이

*임시로 마일스톤과 이슈를 만들어 보았습니다.*
*추가/수정이 필요한 부분은 알려주세요.*


#  snapbody_mobile 폴더 구조

### /기기/$DocumentPath
* pictures - 눈바딩 레코드에 입력된 사진
* slideshows - 슬라이드쇼

### /asset - 앱에 사용할 이미지 

### /lib - 소스 코드
* constant - 앱 동작에 필요한 상수 ( 색, 폰트, 스타일, enum, 선언, 등등 )
* data
  - datasource - 데이터 저장소와 연동하는 클래스
  - model - 데이터 모델 클래스, 데이터 맵핑 함수
  - repository - 데이터 소스를 결정하고 구성하는 클래스 
* screen - UI 폴더
  - controller ( 로직 / getx를 사용하면 필요할 것 같은데 )
  - provider/bloc provider/bloc을 사용한다면 필요한 곳 ( 로직 )
* service - 외부에서 제공하는 서비스 구성
* util - 앱 전반적으로 사용될 수 있는 클래스, 함수
* widget - UI에 사용할 독립적 기능을 하는 커스텀 위젯
* test - 테스트 코드

# TIP

### print(''); warning 해결법
디버깅을 위해 print()를 사용하셨을 경우, 지울 필요 없이

    print()  => 

    if (kDebugMode) {
        debugPrint('TabBar에서 선택된 index : $index');    
    }
    
    or
    
    debugPrint('TabBar에서 선택된 index : $index');    

로 변경하셔도 warning이 사라집니다.
추후에는 log를 저장하는 코드로 변경하도록 하겠습니다.

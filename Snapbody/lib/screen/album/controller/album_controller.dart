import 'package:get/get.dart';

//TODO: 모든 상태를 이 곳에서 관리하는 것으로 목표
class AlbumController extends GetxController {
  int count = 0;

  //추후 dynamic에 picture 데이터 모델을 입력하여 사용
  //날짜에 따라 정렬하여 데이터를 가져오자.
  //키:날짜, 값: 앨범
  List<Map<String, dynamic>> listPictures = [];

  //눈바딩, 식단, 운동 형식으로 된 List를 따로 유지하자.
  List<dynamic> listOfNunbodying = [];
  List<dynamic> listOfDigest = [];
  List<dynamic> listOfPractice = [];

  void increase() {
    count++;
    update();
  }

  //TODO: 전체 사진 가져오기
  //등록날짜로 해당일의 주 첫째일과 마지막 일을 계산하여 정보 추가
  void getListOfPictures() {}

  //TODO: 눈바딩 사진 가져오기
  //필터는 중복 선택이 가능. 초기값은 선택X. 선택X인 경우 모든 필터 선택과 같은 작용
  //필터 초기화 버튼은 선택된 필터가 없을 때는 보이지 않고, 필터가 선택되면 보인다.
  //눈바딩 사진은 위아래로 길게 설정. 다른 사진과 다르게 표현
  void getListOfNunbodying({String? filter}) {}

  //TODO: 식단 사진 가져오기
  //필터는 중복 선택이 가능. 초기값은 선택X. 선택X인 경우 모든 필터 선택과 같은 작용
  //필터 초기화 버튼은 선택된 필터가 없을 때는 보이지 않고, 필터가 선택되면 보인다.
  void getListOfDigest({String? filter}) {}

  //TODO: 운동 사진 가져오기 ( 운동은 필터 필요 없음 )
  void getListOfPractice() {}

  //TODO: 슬라이드쇼 가져오기
  void getSlideShow() {}

  //TODO: 슬라이드쇼 삭제
  void deleteSlideShow(Map<String, dynamic> slideShow) {}

  //TODO: 슬라이드쇼 저장 ( 저장 장소 : 기기 갤러리 ) gallery_saver사용?
  void saveSlideShowToPhone(Map<String, dynamic> slideShow) {}

  //TODO: 슬라이드쇼 SNS에 공유
  void shareSlideShowToSNS(Map<String, dynamic> slideShow) {}
}

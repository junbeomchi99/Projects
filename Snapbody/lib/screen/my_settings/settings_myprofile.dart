import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snapbody/screen/my_settings/setting_screen.dart';

import '../../constant/constant.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
          backgroundColor: SCREEN_COLOR,
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: BACKGROUND_COLOR,
              elevation: 0,
              centerTitle: true,
              title: Text("프로필", style: Theme.of(context).textTheme.headline1),
              leading: IconButton(
                icon: SvgPicture.asset('assets/icons/icon_back_button.svg'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SettingsWidget()));
                },
              )),
          bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 20 / 360,
                  vertical: MediaQuery.of(context).size.height * 32 / 733),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 56 / 733,
                width: MediaQuery.of(context).size.width * 320 / 360,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: PRIMARY_COLOR),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {}
                  },
                  child: const Text('완료'),
                ),
              )),
          body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 10 / 360),
              child: ListView(children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 32 / 733),
                Center(
                  child: Stack(
                    children: <Widget>[
                      const CircleAvatar(
                        radius: 80,
                        backgroundColor: ICON_COLOR,
                      ),
                      Positioned(
                          bottom: 5,
                          right: 5,
                          child: CircleAvatar(
                              radius: 20,
                              backgroundColor: SECONDARY_COLOR,
                              child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20.0)),
                                        ),
                                        context: context,
                                        builder: ((builder) => SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  176 /
                                                  733,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              29.1 /
                                                              733),
                                                  InkWell(
                                                    onTap: () {
                                                      showAlertDialog(
                                                          context,
                                                          "카메라 권환 설정이 필요합니다",
                                                          "사진을 촬영하려면 앱 설정에서 카메라 접근권환 을 승인해주세요.",
                                                          "닫기",
                                                          "설정");
                                                    },
                                                    child: Wrap(
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                20 /
                                                                360),
                                                        SvgPicture.asset(
                                                            'assets/icons/camera.svg'),
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                8 /
                                                                360),
                                                        Text("사진촬영",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1)
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              20 /
                                                              733),
                                                  InkWell(
                                                    onTap: () {
                                                      showAlertDialog(
                                                          context,
                                                          "사진 권환 설정이 필요합니다",
                                                          "사진을 등록하려면 앱 설정에서 사진 및 미디어 접근권한을 승인해주세요",
                                                          "닫기",
                                                          "설정");
                                                    },
                                                    child: Wrap(
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                20 /
                                                                360),
                                                        SvgPicture.asset(
                                                            'assets/icons/icon_album_not_selected.svg'),
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                8 /
                                                                360),
                                                        Text("앨범에서 사진 선택",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1)
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              20 /
                                                              733),
                                                  Wrap(
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              20 /
                                                              360),
                                                      SvgPicture.asset(
                                                          'assets/icons/icon_smile.svg'),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              8 /
                                                              360),
                                                      Text("기본 캐릭터로 설정",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1)
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )));
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/camera.svg',
                                    color: BACKGROUND_COLOR,
                                  ))))
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 32 / 733),
                //TODO: 회원 닉네임 값 넣어주기 (유저 닉네임 변경)
                //TODO: 이미 등록된 닉네임 확인 (????)
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '닉네임을 입력해주세요';
                      } else {
                        RegExp regExp1 = RegExp(r"^[ㄱ-ㅎ가-힣0-9a-zA-Z\s+]*$");
                        //TODO: '이미 등록된 닉네임 확인'
                        if (value.length > 30) {
                          return '최대 30자까지 입력할 수 있습니다';
                        } else if (!regExp1.hasMatch(value)) {
                          return '영문자, 한글, 숫자만 사용할 수 있습니다';
                        } else {
                          return null;
                        }
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: BACKGROUND_COLOR,
                      filled: true,
                      labelText: "닉네임",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(
                              width: 1, color: BACKGROUND_COLOR)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(
                              width: 1, color: BACKGROUND_COLOR)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(width: 1, color: DARK_COLOR)),
                    )),

                SizedBox(
                    height: MediaQuery.of(context).size.height * 240 / 733),
                //TODO: 완료 클릭시 DB값 업데이트 해주기
              ]))),
    );
  }
}

void showAlertDialog(BuildContext context, String title, String content,
    String leftButton, String rightButton) async {
  await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 28 / 360,
            vertical: MediaQuery.of(context).size.height * 200 / 733),
        titlePadding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 20 / 733,
            bottom: MediaQuery.of(context).size.height * 20 / 733,
            left: MediaQuery.of(context).size.width * 16 / 360),
        contentPadding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 20 / 733,
            bottom: MediaQuery.of(context).size.height * 20 / 733,
            left: MediaQuery.of(context).size.width * 16 / 360),
        actionsPadding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 20 / 733,
            bottom: MediaQuery.of(context).size.height * 20 / 733),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Text(title, style: Theme.of(context).textTheme.headline2),
        content: Text(content, style: Theme.of(context).textTheme.bodyText2),
        actions: <Widget>[
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ICON_COLOR,
                      minimumSize: Size(
                          MediaQuery.of(context).size.width * 130 / 360,
                          MediaQuery.of(context).size.height * 48 / 733),
                    ),
                    child: Text(leftButton,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                    onPressed: () {
                      Navigator.pop(context, leftButton);
                    },
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 12 / 360),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: PRIMARY_COLOR,
                      minimumSize: Size(
                          MediaQuery.of(context).size.width * 130 / 360,
                          MediaQuery.of(context).size.height * 48 / 733),
                    ),
                    child: Text(rightButton,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                    onPressed: () {
                      Navigator.pop(context, rightButton);
                    },
                  ),
                ],
              ))
        ],
      );
    },
  );
}

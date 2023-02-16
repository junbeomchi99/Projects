// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe, deprecated_member_use

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapbody/constant/constant.dart';
import 'package:snapbody/screen/my_settings/settings_myprofile.dart';
import 'package:snapbody/screen/my_settings/setting_goal.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../data/model/user_info.dart';
import '../../data/repository/user_info.dart';
import '../../widget/snapbody_scaffold_centerTitle.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsWidget> {
  bool _linkON = false;
  bool _notiON = true;
  final bool _setGoal = true;
  final UserInfoRepository userInfoRepository = Get.find();

  void toggleSwitch(bool value) {
    if (_linkON == false) {
      setState(() {
        _linkON = true;
      });
      showAlertDialog(context, "신체 활동 권환을 허용해주세요",
          "앱 설정에서 신체 활동 권환을 허용하면 건강앱의 데이터를 불러올 수 있습니다.", "취소", "설정");
    } else {
      setState(() {
        _linkON = false;
      });
    }
  }

  Future<UserInfo?> _loadUser() async {
    UserInfo? user = await userInfoRepository.get(0);
    return user;
  }

  UserInfo user = UserInfo(
      id: 0,
      name: "이름없음",
      profileImage: Uint8List.fromList([0]),
      pushYn: "",
      healthAppYn: "",
      profile: "",
      createDate: 0,
      modifyDate: 0);

  _SettingsPageState() {
    _loadUser().then((val) => setState(() {
          user = val!;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SnapbodyScaffold_centerTitle(
      title: '마이페이지',
      onPressFloatingActionButton: () {
        debugPrint('플로팅 액션 버튼 테스트입니다.');
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            // COMPLETED: 내 프로필로 이동
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const MyProfileScreen()),
                );
              },
              child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 16 / 733,
                      horizontal: MediaQuery.of(context).size.width * 7 / 360),
                  width: MediaQuery.of(context).size.width * 320 / 360,
                  decoration: BoxDecoration(
                      border: Border.all(color: ICON_COLOR),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Row(children: [
                    //TODO: 프로필 사진 불러오기 기능 추가
                    Column(
                      children: [
                        Center(
                          child: Stack(
                            children: <Widget>[
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.height *
                                    45 /
                                    733,
                                backgroundColor: ICON_COLOR,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 12 / 360),
                    //TODO: 프로필이름, 이메일 불러오기 기능 추가
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name,
                            style: Theme.of(context).textTheme.headline1),
                        Text('example@email.com',
                            style: Theme.of(context).textTheme.caption)
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                        )
                      ],
                    )
                  ])),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 12 / 733),
            //TODO: 목표가 없을 시 "새로운 목표를 세워보세요." 제공 (태윤님한테 y/n 필드 추가 논의)
            // 목표 체중, 몸무게, D-day Container
            if (_setGoal) ...{
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const GoalScreen()),
                  );
                },
                child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 16 / 733,
                        horizontal:
                            MediaQuery.of(context).size.width * 7 / 360),
                    width: MediaQuery.of(context).size.width * 320 / 360,
                    decoration: BoxDecoration(
                        border: Border.all(color: ICON_COLOR),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Row(children: [
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('목표 체중',
                                  style: Theme.of(context).textTheme.caption),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      12 /
                                      733),
                              Text('목표 제목',
                                  style: Theme.of(context).textTheme.caption),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      12 /
                                      733),
                              Text('D-day',
                                  style: Theme.of(context).textTheme.caption)
                            ],
                          )
                        ],
                      ),

                      SizedBox(
                          width: MediaQuery.of(context).size.width * 12 / 360),
                      //TODO: 목표 체중, 목표 제목, D-day 불러오기
                      Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('30kg',
                                  style: Theme.of(context).textTheme.bodyText2),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      12 /
                                      733),
                              Text('글자수가15자이상넘어가면은이나타나야겠지?',
                                  style: Theme.of(context).textTheme.bodyText2,
                                  overflow: TextOverflow.ellipsis),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      12 /
                                      733),
                              Text('22.04.01',
                                  style: Theme.of(context).textTheme.bodyText2)
                            ],
                          )),
                      Spacer(),
                      Column(
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                          )
                        ],
                      )
                    ])),
              ),
            } else if (_setGoal == false) ...{
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const GoalScreen()),
                    );
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical:
                              MediaQuery.of(context).size.height * 16 / 733,
                          horizontal:
                              MediaQuery.of(context).size.width * 7 / 360),
                      width: MediaQuery.of(context).size.width * 320 / 360,
                      decoration: BoxDecoration(
                          color: ICON_BACKGROUND_COLOR,
                          border: Border.all(color: ICON_COLOR),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Row(
                        children: [
                          Text("새로운 목표를 세워보세요.",
                              style: Theme.of(context).textTheme.bodyText2),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                          )
                        ],
                      )))
            },
            SizedBox(
              height: MediaQuery.of(context).size.height * 10 / 733,
            ),
            //TODO: 건강앱 연동 기능 추가 (permission)
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "건강앱 연동",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Transform.scale(
                  scale: 0.8,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return CupertinoSwitch(
                          value: _linkON, onChanged: toggleSwitch);
                    },
                  ))
            ]),
            //TO DO: 알림 설정 y/n 여부 db 업데이트
            Divider(color: ICON_COLOR),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "알림 설정",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: _notiON,
                      onChanged: (bool val) {
                        setState(() {
                          _notiON = val;
                        });
                      },
                    ))
              ],
            ),
            Divider(color: ICON_COLOR),
            //COMPLETED 이용약관 web 페이지로 이동
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 10 / 733),
              child: GestureDetector(
                onTap: () {
                  launchURL(
                      "https://enormous-pisces-ee5.notion.site/73e2ae015b3842c6bb1f64ff49dad7e9");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "이용약관",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: ICON_COLOR),
            //COMPLETED 개인정보 처리방침 web 페이지로 이동
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 10 / 733),
              child: GestureDetector(
                onTap: () {
                  launchURL(
                      "https://enormous-pisces-ee5.notion.site/ca34d6c4b990483683979ff605318b8a");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "개인정보 처리방침",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: ICON_COLOR),
            //TODO: 로그인 화면으로 이동 + 로그아웃 처리? (db에 저장해야되나?)
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 10 / 733),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "로그아웃",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: ICON_COLOR),
            //TODO: 회원탈퇴 기능 추가
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 10 / 733),
              child: GestureDetector(
                onTap: () {
                  showAlertDialog(
                      context,
                      "회원탈퇴",
                      "탈퇴 시 스냅바디에 저장된 사진 및 기록이 모두  사라집니다. 탈퇴하시겠습니까?",
                      "취소",
                      "탈퇴");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "회원탈퇴",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
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
        shape: RoundedRectangleBorder(
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
                        style: TextStyle(
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
                        style: TextStyle(
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

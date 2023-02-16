import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:snapbody/screen/my_settings/setting_screen.dart';

import '../../constant/constant.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({Key? key}) : super(key: key);

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  final formkey = GlobalKey<FormState>();
  bool isVisible = true;
  final _dateController = TextEditingController();

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
              title: Text("목표", style: Theme.of(context).textTheme.headline1),
              leading: IconButton(
                icon: SvgPicture.asset('assets/icons/icon_back_button.svg'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SettingsWidget()));
                },
              ),
              //TODO: 휴지통 아이콘으로 변경하기
              actions: <Widget>[
                IconButton(
                    icon: SvgPicture.asset('assets/icons/icon_trash_bin.svg'),
                    onPressed: () {
                      showAlertDialog(
                          context,
                          "목표를 삭제하시겠어요?",
                          "목표를 삭제하면 이전에 기록된 목표달성률 이 사라져요. 목표를 삭제하시겠어요?",
                          "아니요",
                          "삭제");
                    })
              ]),
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
                //TODO: 회원 체중값 넣어주기
                //COMPLETED: 목표 체중 입력 칸
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '목표하는 몸무게를 입력해주세요';
                      } else {
                        RegExp regExp1 = RegExp(r"^[0-9.]*$");
                        if (!regExp1.hasMatch(value)) {
                          return '숫자만 사용할 수 있습니다';
                        } else if (double.parse(value) >= 226.0 ||
                            double.parse(value) <= 0) {
                          return '최대 226.0kg까지 입력할 수 있습니다.';
                        } else if (value !=
                            double.parse(value).toStringAsFixed(1)) {
                          return '소수점 한자리 수까지 입력 해주세요';
                        } else {
                          return null;
                        }
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: BACKGROUND_COLOR,
                      filled: true,
                      labelText: "목표 체중",
                      suffixText: "kg",
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
                SizedBox(height: MediaQuery.of(context).size.height * 32 / 733),
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
                      labelText: "목표 제목",
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
                SizedBox(height: MediaQuery.of(context).size.height * 32 / 733),
                TextFormField(
                    controller: _dateController,
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2025))
                          .then((date) {
                        setState(() {});
                        _dateController.text =
                            DateFormat('yyyy-MM-dd').format(date!);
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '목표 날짜를 입력해 주세요';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: BACKGROUND_COLOR,
                      filled: true,
                      labelText: '목표 날짜',
                      suffixIcon: Visibility(
                          visible: isVisible,
                          child: const Icon(Icons.calendar_month,
                              color: Colors.grey)),
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

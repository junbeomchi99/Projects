import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import '../../constant/style_constant.dart';
import '../../data/model/user_info.dart';
import '../../data/repository/user_info.dart';

class OnBoardingName extends StatefulWidget {
  const OnBoardingName({Key? key}) : super(key: key);

  @override
  State<OnBoardingName> createState() => _OnBoardingNameState();
}

class _OnBoardingNameState extends State<OnBoardingName> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
          backgroundColor: SCREEN_COLOR,
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
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const OnBoardingName()),
                      );
                    }
                  },
                  child: const Text('계속'),
                ),
              )),
          body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 10 / 360),
              child: ListView(children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 32 / 733),
                SizedBox(height: MediaQuery.of(context).size.height * 32 / 733),
                buildTextField(context, "유저 닉네임", "닉네임"),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 240 / 733),
              ]))),
    );
  }
}

TextFormField buildTextField(
    BuildContext context, String info, String subtitle) {
  final UserInfoRepository userInfoRepository = Get.find();

  return TextFormField(
      onSaved: (value) {
        if (value != null) {
          var name = value;
          var list = [0];
          var user = UserInfo(
              id: 0,
              name: name,
              profileImage: Uint8List.fromList(list),
              pushYn: "",
              healthAppYn: "",
              profile: "",
              createDate: 0,
              modifyDate: 0);
          userInfoRepository.create(user);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '닉네임을 입력해주세요';
        } else {
          RegExp regExp1 = RegExp(r"^[ㄱ-ㅎ가-힣0-9a-zA-Z\s+]*$");
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
        labelText: subtitle,
        hintText: info,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(width: 1, color: BACKGROUND_COLOR)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(width: 1, color: BACKGROUND_COLOR)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            borderSide: BorderSide(width: 1, color: DARK_COLOR)),
      ));
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widget/snapbody_scaffold.dart';
import '../onboarding/onboarding_name.dart';

class KakaoLoginPage extends StatefulWidget {
  const KakaoLoginPage({Key? key}) : super(key: key);

  @override
  _KakaoLoginPageState createState() => _KakaoLoginPageState();
}

class _KakaoLoginPageState extends State<KakaoLoginPage> {
  @override
  Widget build(BuildContext context) {
    return SnapbodyScaffold(
      title: 'Snapbody',
      onPressFloatingActionButton: () {
        debugPrint('플로팅 액션 버튼 테스트입니다.');
      },
      topPadding: 10,
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const OnBoardingName()),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.yellow),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.chat_bubble, color: Colors.black54),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '로그인',
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SvgPicture.asset(
            'assets/icons/camera.svg',
            width: 20,
            height: 20,
          ),
        )
      ],
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:snapbody/data/repository/user_info.dart';
import 'package:snapbody/screen/onboarding/onboarding_name.dart';

import 'package:snapbody/widget/snapbody_scaffold.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'constant/style_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  // 카카오 sdk
  KakaoSdk.init(nativeAppKey: '5120b3f882431ec840922bc8c1d49941');
  // db init
  Get.put(UserInfoRepository());

  initializeDateFormatting().then((_) => runApp(const Snapbody()));
}

class Snapbody extends StatelessWidget {
  const Snapbody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 750),
        builder: (_) {
          return GetMaterialApp(
            title: 'Snapbody',
            debugShowCheckedModeBanner: false,
            theme: SNAPBODY_THEME,
            home: const SnapbodyHomePage(),
          );
        });
  }
}

class SnapbodyHomePage extends StatefulWidget {
  const SnapbodyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<SnapbodyHomePage> createState() => _SnapbodyHomePageState();
}

class _SnapbodyHomePageState extends State<SnapbodyHomePage> {
  final UserInfoRepository userInfoRepository = Get.find<UserInfoRepository>();

  Future<void> _loginWithKakao() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        if (kDebugMode) {
          print('카카오톡으로 로그인 성공');
        }
        await _checkBeforeLogin();
      } catch (error) {
        if (kDebugMode) {
          print('카카오톡으로 로그인 실패 $error');
        }

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          if (kDebugMode) {
            print('카카오계정으로 로그인 성공');
          }
          await _checkBeforeLogin();
        } catch (error) {
          if (kDebugMode) {
            print('카카오계정으로 로그인 실패 $error');
          }
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        if (kDebugMode) {
          print('카카오계정으로 로그인 성공');
        }
        await _checkBeforeLogin();
      } catch (error) {
        if (kDebugMode) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    }
  }

  Future<void> _checkBeforeLogin() async {
    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
        if (kDebugMode) {
          print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
        }
        try {
          AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
          if (kDebugMode) {
            print('토큰 정보 보기 성공'
                '\n회원정보: ${tokenInfo.id}'
                '\n만료시간: ${tokenInfo.expiresIn} 초');
          }

          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const OnBoardingName()));
        } catch (error) {
          if (kDebugMode) {
            print('토큰 정보 보기 실패 $error');
          }
        }
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          if (kDebugMode) {
            print('토큰 만료 $error');
          }
        } else {
          if (kDebugMode) {
            print('토큰 정보 조회 실패 $error');
          }
        }
      }
    } else {
      await _loginWithKakao();
    }
  }

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
          onTap: () => _checkBeforeLogin(),
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

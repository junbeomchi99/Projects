import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapbody/widget/snapbody_calendar.dart';
import '../../widget/snapbody_bodytab.dart';
import '../../widget/snapbody_mealtab.dart';
import '../../widget/snapbody_scaffold.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widget/snapbody_tabbar.dart';
import 'controller/home_controller.dart';

class SnapbodyHomePage extends StatefulWidget {
  const SnapbodyHomePage({Key? key}) : super(key: key);

  @override
  State<SnapbodyHomePage> createState() => _SnapbodyHomePageState();
}

class _SnapbodyHomePageState extends State<SnapbodyHomePage> {
  final getController = Get.put(EventController());

  //TODO: 현재는 하드코딩한 샘플 데이터. 추후에 Firebase와 연결
  List<String> eventSource1 = ['body', '', '오늘 컨디션 좋음!', ''];
  List<String> eventSource2 = ['body', '', '오늘은 컨디션 별로..', ''];
  List<String> eventSource3 = ['body', '', '배고프다!', ''];
  List<String> eventSource4 = ['body', '', '딱히 할말 없음', ''];
  List<String> eventSource5 = ['body', '', '스냅바디 룰루랄라', ''];

  @override
  void initState() {
    super.initState();
    getController.addEvents(DateTime(2022, 4, 1), eventSource1);
    getController.addEvents(DateTime(2022, 4, 4), eventSource2);
    getController.addEvents(DateTime(2022, 4, 10), eventSource3);
    getController.addEvents(DateTime(2022, 4, 15), eventSource4);
  }

  @override
  void dispose() {
    super.dispose();
    //getController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SnapbodyScaffold(
      showAppBar: false,
      title: 'Snapbody',
      onPressFloatingActionButton: () {
        debugPrint('플로팅 액션 버튼 테스트입니다.');
      },
      child: Obx(() => Padding(
            padding: EdgeInsets.only(top: 188.h),
            child: HomeTabBar(
              tabOne: BodyOrWorkoutTab(
                isBody: true,
                info: getController
                    .selectedEvents[getController.selectedDay.value]
                    ?.elementAt(0),
              ),
              tabTwo: const MealTab(),
              tabThree: BodyOrWorkoutTab(
                isBody: false,
                info: getController
                    .selectedEvents[getController.selectedDay.value]
                    ?.elementAt(0),
              ),
            ),
          )),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SvgPicture.asset(
            'assets/icons/camera.svg',
            width: 20,
            height: 20,
          ),
        )
      ],
      calendar: const HomeCalendarTable(),
    );
  }
}

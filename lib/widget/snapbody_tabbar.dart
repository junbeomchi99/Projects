import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapbody/widget/tab_indicator.dart';

import '../constant/tabbar_constant.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({
    Key? key,
    required this.tabOne,
    required this.tabTwo,
    required this.tabThree,
  }) : super(key: key);

  final Widget tabOne;
  final Widget tabTwo;
  final Widget tabThree;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Center(
        child: Column(
          children: [
            Material(
              color: Colors.transparent,
              child: TabBar(
                indicator: SnapBodyIndicator(
                  color: TAB_INDICATOR_COLOR,
                  distanceFromCenter: 20.h,
                  radius: 3.r,
                  paintingStyle: PaintingStyle.fill,
                ),
                labelColor: Colors.black,
                unselectedLabelColor: UNSELECTED_TAB_LABEL_COLOR,
                labelStyle: TextStyle(
                    fontSize: LABEL_FONTSIZE, fontWeight: FontWeight.bold),
                labelPadding: const EdgeInsets.only(bottom: 0),
                unselectedLabelStyle: TextStyle(fontSize: LABEL_FONTSIZE),
                isScrollable: true,
                tabs: [
                  //TODO: 탭별 Indicator 길이 조절
                  SizedBox(
                      child: const Center(child: Text('눈바디')), width: 108.w),
                  SizedBox(
                      child: const Center(child: Text('식단')), width: 106.w),
                  SizedBox(
                      child: const Center(child: Text('운동')), width: 106.w),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(maxWidth: 340.w, maxHeight: 390.h),
                  child: TabBarView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [tabOne, tabTwo, tabThree],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

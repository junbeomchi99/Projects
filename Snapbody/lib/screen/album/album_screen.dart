import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapbody/constant/constant.dart';
import 'package:snapbody/screen/album/controller/album_controller.dart';
import 'package:snapbody/screen/album/digest_album_screen.dart';
import 'package:snapbody/screen/album/all_album_screen.dart';
import 'package:snapbody/screen/album/nunbodying_album_screen.dart';
import 'package:snapbody/screen/album/practice_album_screen.dart';
import '../../widget/snapbody_widgets.dart';

class AlbumWidget extends StatelessWidget {
  const AlbumWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AlbumController());
    return const AlbumScreen();
  }
}

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({Key? key}) : super(key: key);

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SnapbodyScaffold(
      title: '앨범',
      onPressFloatingActionButton: () {
        debugPrint('플로팅 액션 버튼 테스트입니다.');
      },
      child: Container(
        color: BACKGROUND_COLOR,
        child: Column(children: [
          TabBar(
            isScrollable: false,
            indicatorColor: BUTTON_END_COLOR,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.black,
            labelColor: BUTTON_END_COLOR,
            labelStyle: Theme.of(context).textTheme.bodyText1,
            controller: _tabController,
            onTap: (index) {
              if (kDebugMode) {
                debugPrint('TabBar에서 선택된 index : $index');
              }
            },
            tabs: const [
              Tab(child: SnapbodyText(text: '전체')),
              Tab(child: SnapbodyText(text: '눈바딩')),
              Tab(child: SnapbodyText(text: '식단')),
              Tab(child: SnapbodyText(text: '운동')),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                // 전체
                AllAlbumScreen(),
                // 눈바딩
                NunBodyingAlbumScreen(),
                // 식단
                DigestAlbumScreen(),
                // 운동
                PracticeAlbumScreen(),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:snapbody/screen/album/album_screen.dart';

import 'package:snapbody/screen/my_settings/setting_screen.dart';

import 'package:snapbody/screen/home/home_screen.dart';


import '../constant/constant.dart';
import '../screen/album/album_screen.dart';

class SnapbodyScaffold extends StatelessWidget {
  const SnapbodyScaffold({
    Key? key,
    required this.title,
    required this.child,
    this.showAppBar = true,
    this.calendar,
    this.topPadding = 0,
    this.actions,
    this.onPressFloatingActionButton,
    this.bottomTapBar,
  }) : super(key: key);

  final String title;
  final Widget child;
  final bool showAppBar;
  final Widget? calendar;
  final double topPadding;
  final List<Widget>? actions;
  final VoidCallback? onPressFloatingActionButton;
  final TabBar? bottomTapBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HOME_BACKGROUND_COLOR,
      appBar: showAppBar
          ? AppBar(
              title: Text(title, style: Theme.of(context).textTheme.headline1),
              centerTitle: false,
              backgroundColor: BACKGROUND_COLOR,
              elevation: 0,
              actions: actions,
              automaticallyImplyLeading: false,
              bottom: bottomTapBar,
            )
          : null,
      body: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Stack(children: [child, calendar ?? const SizedBox()]),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
        ),
        child: SizedBox(
          height: 65,
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                          'assets/icons/icon_home_not_selected.svg'),
                      color: const Color(0xffC4C4C4),
                      padding: const EdgeInsets.only(bottom: 3),
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //       builder: (context) => const SnapbodyHomePage()),
                        // );
                        Get.to(() => const SnapbodyHomePage());
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                    const Text(
                      '홈',
                      style: TextStyle(
                        color: Color(0xffC4C4C4),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                          'assets/icons/icon_statistics_not_selected.svg'),
                      color: const Color(0xffC4C4C4),
                      padding: const EdgeInsets.only(bottom: 3),
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                    const Text(
                      '통계',
                      style: TextStyle(
                        color: Color(0xffC4C4C4),
                      ),
                    )
                  ],
                ),
                const IconButton(
                  onPressed: null,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  icon: Icon(null),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                          'assets/icons/icon_album_not_selected.svg'),
                      color: const Color(0xffC4C4C4),
                      padding: const EdgeInsets.only(bottom: 3),
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const AlbumWidget()),
                        );
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                    const Text(
                      '앨범',
                      style: TextStyle(
                        color: Color(0xffC4C4C4),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                          'assets/icons/icon_setting_not_selected.svg'),
                      color: const Color(0xffC4C4C4),
                      padding: const EdgeInsets.only(bottom: 3),
                      constraints: const BoxConstraints(),

                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const SettingsWidget()),
                        );
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,

                    ),
                    const Text(
                      '마이',
                      style: TextStyle(
                        color: Color(0xffC4C4C4),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Container(
          decoration: const ShapeDecoration(
              shape: CircleBorder(
                  side: BorderSide(
                      width: 5,
                      color: BACKGROUND_COLOR,
                      style: BorderStyle.solid)),
              shadows: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [BUTTON_START_COLOR, BUTTON_END_COLOR])),
          child: MaterialButton(
            onPressed: onPressFloatingActionButton,
            shape: const CircleBorder(),
            child: SvgPicture.asset(
              'assets/icons/camera.svg',
              color: BACKGROUND_COLOR,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

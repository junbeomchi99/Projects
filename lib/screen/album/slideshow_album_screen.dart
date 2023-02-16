import 'package:flutter/material.dart';
import 'package:snapbody/constant/constant.dart';

import 'package:snapbody/widget/snapbody_widgets.dart';

class SlideShowAlbumScreen extends StatelessWidget {
  const SlideShowAlbumScreen({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SnapbodyScaffold(
      showAppBar: true,
      title: '슬라이드쇼 선택',
      child: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '몸무게 목표 100% 달성',
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  '2022.03.01',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      height: 400,
                      child: Image.network(imagePath)),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Checkbox(
                      shape: const CircleBorder(),
                      activeColor: SECONDARY_COLOR,
                      value: false,
                      onChanged: (checked) {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '몸무게 목표 100% 달성',
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  '2022.03.01',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      height: 400,
                      child: Image.network(imagePath)),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Checkbox(
                      shape: const CircleBorder(),
                      activeColor: SECONDARY_COLOR,
                      value: true,
                      onChanged: (checked) {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

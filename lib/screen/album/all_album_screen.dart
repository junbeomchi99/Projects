import 'package:collection/collection.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:snapbody/constant/constant.dart';
import 'package:snapbody/util/staggered_gridview.dart';
import 'package:snapbody/widget/snapbody_text.dart';

class AllAlbumScreen extends StatelessWidget {
  const AllAlbumScreen({
    Key? key,
  }) : super(key: key);

  static const tilesNormal = [
    GridTile(1, 1),
    GridTile(1, 1),
    GridTile(1, 1),
  ];

  static const tilesWithNunbodying = [
    GridTile(2, 2),
    GridTile(1, 1),
    GridTile(1, 1),
  ];

  static const tilesOnlySlideShow = [
    GridTile(3, 3),
  ];

  //TODO: 이미지를 눌렀을 때 상세 페이지로 이동
  //TODO: 데이터를 가져와서 기간에 따라 분리
  //TODO: 일반 사진만 있을 때 - 동일 크기 3장 가로로 나열 반복,
  //TODO: 슬라이드쇼가 포함되었을 때 - 슬라이드쇼는 일반 사진의 가로*세로 2배, 오른쪽에 일반 사진 2장

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: const SnapbodyText(
            text: '최근',
            textType: TextType.title2,
          ),
        ),
        StaggeredGrid.count(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: [
            ...tilesNormal.mapIndexed((index, tile) {
              return StaggeredGridTile.count(
                crossAxisCellCount: tile.crossAxisCount,
                mainAxisCellCount: tile.mainAxisCount,
                child: ImageTile(
                  index: index,
                  width: tile.crossAxisCount * 200,
                  height: tile.mainAxisCount * 200,
                ),
              );
            }),
            ...tilesNormal.mapIndexed((index, tile) {
              return StaggeredGridTile.count(
                crossAxisCellCount: tile.crossAxisCount,
                mainAxisCellCount: tile.mainAxisCount,
                child: ImageTile(
                  index: index,
                  width: tile.crossAxisCount * 200,
                  height: tile.mainAxisCount * 200,
                ),
              );
            }),
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: const SnapbodyText(
            text: '저번 주',
            textType: TextType.title2,
          ),
        ),
        StaggeredGrid.count(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: [
            ...tilesWithNunbodying.mapIndexed((index, tile) {
              return StaggeredGridTile.count(
                crossAxisCellCount: tile.crossAxisCount,
                mainAxisCellCount: tile.mainAxisCount,
                child: ImageTile(
                  index: index,
                  width: tile.crossAxisCount * 200,
                  height: tile.mainAxisCount * 200,
                ),
              );
            }),
            ...tilesNormal.mapIndexed((index, tile) {

              return StaggeredGridTile.count(
                crossAxisCellCount: tile.crossAxisCount,
                mainAxisCellCount: tile.mainAxisCount,
                child: ImageTile(
                  index: index,
                  width: tile.crossAxisCount * 200,
                  height: tile.mainAxisCount * 200,
                ),
              );
            }),
          ],
        ),
      ]),
    );
  }
}

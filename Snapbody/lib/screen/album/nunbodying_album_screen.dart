import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:snapbody/constant/constant.dart';
import 'package:snapbody/screen/album/slideshow_album_screen_two.dart';
import 'package:snapbody/util/staggered_gridview.dart';

class NunBodyingAlbumScreen extends StatefulWidget {
  const NunBodyingAlbumScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NunBodyingAlbumScreen> createState() => _NunBodyingAlbumScreenState();
}

class _NunBodyingAlbumScreenState extends State<NunBodyingAlbumScreen> {
  final rnd = Random();
  late List<int> extents;
  int crossAxisCount = 4;

  bool filterOfFirst = false;
  bool filterOfSecond = false;
  bool filterOfThird = false;
  bool filterOfFourth = false;

  @override
  void initState() {
    super.initState();
    extents = List<int>.generate(10000, (int index) => rnd.nextInt(7) + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (filterOfFirst == true ||
                filterOfSecond == true ||
                filterOfThird == true ||
                filterOfFourth == true)
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: Image.network(
                          'https://picsum.photos/54/54?random=1',
                        ).image,
                      ),
                      const Text('초기화'),
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    filterOfFirst = false;
                    filterOfSecond = false;
                    filterOfThird = false;
                    filterOfFourth = false;

                    debugPrint('필터(첫번째) : ${filterOfFirst.toString()}');
                    debugPrint('필터(두번째) : ${filterOfSecond.toString()}');
                    debugPrint('필터(세번째) : ${filterOfThird.toString()}');
                    debugPrint('필터(네번째) : ${filterOfFourth.toString()}');
                  });
                },
              ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: Image.network(
                        'https://picsum.photos/54/54?random=2',
                      ).image,
                    ),
                    Text('첫번째',
                        style: filterOfFirst
                            ? Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: SECONDARY_DARK_COLOR)
                            : Theme.of(context).textTheme.caption),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  filterOfFirst = !filterOfFirst;
                  debugPrint('필터(첫번째) : ${filterOfFirst.toString()}');
                  debugPrint('필터(두번째) : ${filterOfSecond.toString()}');
                  debugPrint('필터(세번째) : ${filterOfThird.toString()}');
                  debugPrint('필터(네번째) : ${filterOfFourth.toString()}');
                });
              },
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: Image.network(
                        'https://picsum.photos/54/54?random=3',
                      ).image,
                    ),
                    Text('두번째',
                        style: filterOfSecond
                            ? Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: SECONDARY_DARK_COLOR)
                            : Theme.of(context).textTheme.caption),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  filterOfSecond = !filterOfSecond;
                  debugPrint('필터(첫번째) : ${filterOfFirst.toString()}');
                  debugPrint('필터(두번째) : ${filterOfSecond.toString()}');
                  debugPrint('필터(세번째) : ${filterOfThird.toString()}');
                  debugPrint('필터(네번째) : ${filterOfFourth.toString()}');
                });
              },
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: Image.network(
                        'https://picsum.photos/54/54?random=4',
                      ).image,
                    ),
                    Text('세번째',
                        style: filterOfThird
                            ? Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: SECONDARY_DARK_COLOR)
                            : Theme.of(context).textTheme.caption),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  filterOfThird = !filterOfThird;
                  debugPrint('필터(첫번째) : ${filterOfFirst.toString()}');
                  debugPrint('필터(두번째) : ${filterOfSecond.toString()}');
                  debugPrint('필터(세번째) : ${filterOfThird.toString()}');
                  debugPrint('필터(네번째) : ${filterOfFourth.toString()}');
                });
              },
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: Image.network(
                        'https://picsum.photos/54/54?random=5',
                      ).image,
                    ),
                    Text('네번째',
                        style: filterOfFourth
                            ? Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: SECONDARY_DARK_COLOR)
                            : Theme.of(context).textTheme.caption),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  filterOfFourth = !filterOfFourth;
                  debugPrint('필터(첫번째) : ${filterOfFirst.toString()}');
                  debugPrint('필터(두번째) : ${filterOfSecond.toString()}');
                  debugPrint('필터(세번째) : ${filterOfThird.toString()}');
                  debugPrint('필터(네번째) : ${filterOfFourth.toString()}');
                });
              },
            ),
          ],
        ),

        //TODO: Item 갯수에 따라서 '전체보기' 메뉴, 안보이게 하기
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '슬라이드쇼',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SlideShowAlbumScreenTwo(
                        imagePath:
                            'https://picsum.photos/800/600?random=1'.toString(),
                      ),
                    ));
              },
              child: Text(
                '전체 보기',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        //TODO: Carousel 추가
        Expanded(
          child: AlignedGridView.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: ImageTile(
                  index: index,
                  width: 100,
                  height: 120,
                ),
              );
            },
            itemCount: extents.length,
          ),
        ),
      ],
    );
  }
}

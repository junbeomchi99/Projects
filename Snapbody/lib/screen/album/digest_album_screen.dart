import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:snapbody/constant/constant.dart';
import 'package:snapbody/util/staggered_gridview.dart';

class DigestAlbumScreen extends StatefulWidget {
  const DigestAlbumScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DigestAlbumScreen> createState() => _DigestAlbumScreenState();
}

class _DigestAlbumScreenState extends State<DigestAlbumScreen> {
  final rnd = Random();
  late List<int> extents;
  int crossAxisCount = 4;


  bool filterOfBreakFast = false;
  bool filterOfLunch = false;
  bool filterOfDinner = false;
  bool filterOfSnack = false;


  @override
  void initState() {
    super.initState();
    extents = List<int>.generate(10000, (int index) => rnd.nextInt(7) + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 16,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (filterOfBreakFast == true ||
              filterOfLunch == true ||
              filterOfDinner == true ||
              filterOfSnack == true)
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
                  filterOfBreakFast = false;
                  filterOfLunch = false;
                  filterOfDinner = false;
                  filterOfSnack = false;

                  debugPrint('필터(아침) : ${filterOfBreakFast.toString()}');
                  debugPrint('필터(점심) : ${filterOfLunch.toString()}');
                  debugPrint('필터(저녁) : ${filterOfDinner.toString()}');
                  debugPrint('필터(간식) : ${filterOfSnack.toString()}');
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
                  Text('아침',
                      style: filterOfBreakFast
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
                filterOfBreakFast = !filterOfBreakFast;
                debugPrint('필터(아침) : ${filterOfBreakFast.toString()}');
                debugPrint('필터(점심) : ${filterOfLunch.toString()}');
                debugPrint('필터(저녁) : ${filterOfDinner.toString()}');
                debugPrint('필터(간식) : ${filterOfSnack.toString()}');
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
                  Text('점심',
                      style: filterOfLunch
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
                filterOfLunch = !filterOfLunch;
                debugPrint('필터(아침) : ${filterOfBreakFast.toString()}');
                debugPrint('필터(점심) : ${filterOfLunch.toString()}');
                debugPrint('필터(저녁) : ${filterOfDinner.toString()}');
                debugPrint('필터(간식) : ${filterOfSnack.toString()}');
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
                  Text('저녁',
                      style: filterOfDinner
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
                filterOfDinner = !filterOfDinner;
                debugPrint('필터(아침) : ${filterOfBreakFast.toString()}');
                debugPrint('필터(점심) : ${filterOfLunch.toString()}');
                debugPrint('필터(저녁) : ${filterOfDinner.toString()}');
                debugPrint('필터(간식) : ${filterOfSnack.toString()}');
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
                  Text('간식',
                      style: filterOfSnack
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
                filterOfSnack = !filterOfSnack;
                debugPrint('필터(아침) : ${filterOfBreakFast.toString()}');
                debugPrint('필터(점심) : ${filterOfLunch.toString()}');
                debugPrint('필터(저녁) : ${filterOfDinner.toString()}');
                debugPrint('필터(간식) : ${filterOfSnack.toString()}');
              });
            },
          ),
        ],
      ),
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
                height: 100,
              ),
            );
          },
          itemCount: extents.length,
        ),
      ),
    ]);
  }
}

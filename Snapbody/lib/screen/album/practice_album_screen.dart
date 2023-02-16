import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:snapbody/util/staggered_gridview.dart';

class PracticeAlbumScreen extends StatefulWidget {
  const PracticeAlbumScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PracticeAlbumScreen> createState() => _PracticeAlbumScreenState();
}

class _PracticeAlbumScreenState extends State<PracticeAlbumScreen> {
  final rnd = Random();
  late List<int> extents;
  int crossAxisCount = 4;
  bool filterOfChest = false;
  bool filterOfLeg = false;
  bool filterOfOxy = false;
  bool filterOfNoOxy = false;

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
        Expanded(
          child: AlignedGridView.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemBuilder: (context, index) {
              return ImageTile(
                index: index,
                width: 100,
                height: 100,
              );
            },
            itemCount: extents.length,
          ),
        ),
      ],
    );
  }
}

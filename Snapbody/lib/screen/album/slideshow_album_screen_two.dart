import 'package:flutter/material.dart';
import 'package:snapbody/constant/constant.dart';

class SlideShowAlbumScreenTwo extends StatefulWidget {
  const SlideShowAlbumScreenTwo({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  @override
  State<SlideShowAlbumScreenTwo> createState() =>
      _SlideShowAlbumScreenTwoState();
}

class _SlideShowAlbumScreenTwoState extends State<SlideShowAlbumScreenTwo> {
  bool isEdit = false;
  int _selectedIndex = 0;
  bool _allChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            child: const Icon(Icons.close, color: Colors.black),
            onTap: () {
              Navigator.pop(context);
            }),
        title: Text('슬라이드쇼 선택', style: Theme.of(context).textTheme.headline1),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () {
                setState(() {
                  isEdit = !isEdit;
                  debugPrint('수정 모드인가요? ${isEdit.toString()}입니다.');
                });
              },
              child: const Icon(
                Icons.edit,
                color: DARK_COLOR,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber,
        currentIndex: _selectedIndex,
        onTap: (value) {
          //TODO : 저장, 삭제, 공유 로직을 수행한다.

          setState(() {
            _selectedIndex = value;
            debugPrint(_selectedIndex.toString());
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.save_alt),
            label: '저장',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: '공유',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: '삭제',
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEdit)
              Row(
                children: [
                  Checkbox(
                    shape: const CircleBorder(),
                    activeColor: SECONDARY_COLOR,
                    value: _allChecked,
                    onChanged: (checked) {
                      setState(() {
                        _allChecked = checked!;
                        debugPrint('전체 체크 활성화 되었나요? ${_allChecked.toString()}');
                      });
                    },
                  ),
                  const Text('전체 선택'),
                ],
              ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '7일만에 받는 선물',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Text(
                    '2022.02.15',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Image.network(widget.imagePath),
                    ),
                    Positioned(
                      top: 5,
                      left: 5,
                      //TODO: CheckBox 클래스를 만들어서 각각 checked 상태값을 가지게 구현하자.
                      child: Checkbox(
                        shape: const CircleBorder(),
                        activeColor: SECONDARY_COLOR,
                        value: false,
                        onChanged: (checked) {},
                      ),
                    ),
                    const Positioned(
                      top: 180,
                      left: 120,
                      //TODO: 이미지에서 글자가 나올 부분의 색깔을 알아내서 색에 따라 글자 색을 다르게 한다.
                      child: Text('안녕하세요. 첫 선물입니다.',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
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
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Image.network(widget.imagePath),
                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}

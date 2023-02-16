import 'package:flutter/material.dart';

import '../constant/constant.dart';

class SnapbodyText extends StatelessWidget {
  const SnapbodyText({
    Key? key,
    required this.text,
    this.textType,
  }) : super(key: key);

  final String text;
  final TextType? textType;

  @override
  Widget build(BuildContext context) {
    switch (textType) {
      case TextType.title1:
        return Text(
          text,
          style: Theme.of(context).textTheme.headline1,
        );
      case TextType.title2:
        return Text(
          text,
          style: Theme.of(context).textTheme.headline2,
        );

      case TextType.title3:
        return Text(
          text,
          style: Theme.of(context).textTheme.headline3,
        );
      case TextType.body1:
        return Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        );
      case TextType.body2:
        return Text(
          text,
          style: Theme.of(context).textTheme.bodyText2,
        );
      case TextType.caption:
        return Text(
          text,
          style: Theme.of(context).textTheme.caption,
        );
      default:
        return Text(text);
    }
  }
}

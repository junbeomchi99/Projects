import 'package:flutter/material.dart';
import 'package:snapbody/constant/constant.dart';

class SnapBodyButton extends StatelessWidget {
  const SnapBodyButton({
    Key? key,
    this.text,
    this.onPressed,
    this.icon,
    this.shape,
    this.width,
    this.height,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String? text;
  final Icon? icon;
  final ShapeBorder? shape;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 60,
      decoration: ShapeDecoration(
          shape: shape ??
              const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [BUTTON_START_COLOR, BUTTON_END_COLOR])),
      child: MaterialButton(
        onPressed: onPressed ?? () {},
        shape: shape ?? const RoundedRectangleBorder(),
        child: icon != null // icon 우선
            ? const Icon(
                Icons.add_outlined,
                color: Colors.white,
              )
            : Text(text ?? '완료',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400)),
      ),
    );
  }
}

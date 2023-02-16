import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnapBodyIndicator extends Decoration {
  /// Radius of the dot, default set to 3
  final double radius;

  /// Color of the dot, default set to [Colors.blue]
  final Color color;

  /// Distance from the center, if you the value is positive, the dot will be positioned below the tab's center
  /// if the value is negative, then dot will be positioned above the tab's center, default set to 8
  final double distanceFromCenter;

  /// [PagingStyle] determines if the indicator should be fill or stroke
  final PaintingStyle paintingStyle;

  /// StrokeWidth, used for [PaintingStyle.stroke], default set to 2
  final double strokeWidth;

  final double horizontalPadding;

  const SnapBodyIndicator({
    this.paintingStyle = PaintingStyle.fill,
    this.radius = 3,
    this.color = Colors.blue,
    this.distanceFromCenter = 8,
    this.strokeWidth = 2,
    this.horizontalPadding = 0,
  });
  @override
  _CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(
      this,
      onChanged,
      radius,
      color,
      paintingStyle,
      distanceFromCenter,
      strokeWidth,
      horizontalPadding,
    );
  }
}

class _CustomPainter extends BoxPainter {
  final SnapBodyIndicator decoration;
  final double radius;
  final Color color;
  final double distanceFromCenter;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final double horizontalPadding;

  _CustomPainter(
    this.decoration,
    VoidCallback? onChanged,
    this.radius,
    this.color,
    this.paintingStyle,
    this.distanceFromCenter,
    this.strokeWidth,
    this.horizontalPadding,
  ) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(horizontalPadding >= 0);
    assert(horizontalPadding < configuration.size!.width / 2,
        "Padding must be less than half of the size of the tab");
    assert(configuration.size != null);
    assert(strokeWidth >= 0 &&
        strokeWidth < configuration.size!.width / 2 &&
        strokeWidth < configuration.size!.height / 2);

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.

    final Paint paint = Paint();
    double yAxisPos =
        offset.dy + configuration.size!.height / 2 + distanceFromCenter;
    paint.color = color;
    paint.style = paintingStyle;
    paint.strokeWidth = strokeWidth;
    //canvas.drawCircle(Offset(xAxisPos, yAxisPos), radius, paint);
    Offset myoffset = Offset(offset.dx + (horizontalPadding), yAxisPos);
    Size mysize = Size(configuration.size!.width, 5.h);

    final Rect rect = myoffset & mysize;

    final p1 = Offset(1.w, yAxisPos + 2.5.h);
    final p2 = Offset(320.w, yAxisPos + 2.5.h);
    final pt = Paint()
      ..color = const Color(0XFFC4C4C4)
      ..strokeWidth = 0.5;
    canvas.drawLine(p1, p2, pt);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          rect,
          bottomRight: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
        paint);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DaysOfWeek extends StatelessWidget {
  final Widget Function(BuildContext context, DateTime day)? dowBuilder;
  final List<DateTime> visibleDays;
  const DaysOfWeek({Key? key, this.dowBuilder, required this.visibleDays})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        _buildDaysOfWeek(context),
      ],
    );
  }

  TableRow _buildDaysOfWeek(BuildContext context) {
    return TableRow(
      children: List.generate(
        7,
        (index) => dowBuilder!(context, visibleDays[index]),
      ).toList(),
    );
  }
}

import 'package:flutter/material.dart';
import '../util/calendar_utils.dart';

class BodyOrWorkoutTab extends StatelessWidget {
  const BodyOrWorkoutTab({Key? key, required this.isBody, this.info})
      : super(key: key);

  final bool isBody;
  final Event? info;

  @override
  Widget build(BuildContext context) {
    if (info != null) {
      return Center(
        child: Stack(
          children: [
            isBody
                ? Image.asset('assets/images/Mask_group.png')
                : Image.asset(
                    'assets/images/work_out.png',
                  ),
            Positioned(
              left: 16,
              bottom: 45,
              child: isBody
                  ? const Text(
                      "D-34 | 56kg",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )
                  : const Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: '유산소',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          TextSpan(text: ' 30분', style: TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
            ),
            Positioned(
              left: 16,
              bottom: 24,
              child: isBody
                  ? Text(
                      info?.comment ?? "",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    )
                  : const Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: '무산소',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          TextSpan(
                              text: ' 삼두, 허벅지, 엉덩이',
                              style: TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
            )
          ],
        ),
      );
    } else {
      return Center(
        child: Stack(
          children: [
            isBody
                ? Positioned(
                    child: Image.asset('assets/images/no_bodyRecord.png'))
                : Image.asset('assets/images/no_workoutRecord.png'),
          ],
        ),
      );
    }
  }
}

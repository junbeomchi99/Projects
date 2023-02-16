import 'package:flutter/material.dart';

class MealTab extends StatelessWidget {
  const MealTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("assets/images/breakfast.png", fit: BoxFit.fill),
              Image.asset("assets/images/breakfast.png", fit: BoxFit.fill),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("assets/images/breakfast.png", fit: BoxFit.fill),
              Image.asset("assets/images/breakfast.png", fit: BoxFit.fill),
            ],
          )
        ],
      ),
    ));
  }
}

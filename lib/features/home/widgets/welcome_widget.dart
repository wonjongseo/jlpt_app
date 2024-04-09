import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    int curHour = now.hour;
    String gretting = '';

    if (curHour > 1 && curHour < 13) {
      gretting = 'おはようございます';
    } else if (curHour >= 13 && curHour < 19) {
      gretting = 'こんにちは';
    } else {
      gretting = 'こんばんは';
    }

    return Column(
      children: [
        Text(
          gretting,
          style: TextStyle(
            fontSize: Responsive.height22,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'JLPT종각へようこそ',
          style: TextStyle(
            fontSize: Responsive.height25,
            fontWeight: FontWeight.w900,
            color: Colors.cyan.shade700,
          ),
        ),
      ],
    );
  }
}

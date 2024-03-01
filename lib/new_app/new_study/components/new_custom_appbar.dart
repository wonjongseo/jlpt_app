import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/features/jlpt_test/screens/jlpt_test_screen.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackButton(),
        Align(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              text: currentIndex < 10
                  ? ' ${currentIndex + 1}'
                  : '${currentIndex + 1}',
              style: TextStyle(
                color: Colors.cyan.shade700,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: ' / 15',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
              onPressed: () => Get.to(
                    () => JlptTestScreen(),
                  ),
              child: Text('Test')),
        )
      ],
    );
  }
}

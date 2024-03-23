import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';

class AnimatedCircularProgressIndicator extends StatelessWidget {
  const AnimatedCircularProgressIndicator(
      {super.key, this.currentProgressCount, required this.totalProgressCount});

  final int? currentProgressCount;
  final int? totalProgressCount;

  @override
  Widget build(BuildContext context) {
    double percentage;
    if (currentProgressCount == null) {
      percentage = 0;
    } else {
      percentage = currentProgressCount! / totalProgressCount!;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: percentage),
            duration: const Duration(milliseconds: 1500),
            builder: (context, double value, child) => Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: value,
                  color: AppColors.primaryColor,
                  backgroundColor: Colors.grey.shade300,
                ),
                Center(
                  child: Text(
                    "${(value * 100).toInt()}%",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Responsive.width14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

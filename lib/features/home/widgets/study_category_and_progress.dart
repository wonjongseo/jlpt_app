import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/animated_circular_progressIndicator.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';

class StudyCategoryAndProgress extends StatelessWidget {
  final String caregory;
  final int curCnt;
  final int totalCnt;
  const StudyCategoryAndProgress({
    super.key,
    required this.caregory,
    required this.curCnt,
    required this.totalCnt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Responsive.height10 / 5).copyWith(
        bottom: Responsive.height15,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            caregory,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: Responsive.height15,
            ),
          ),
          SizedBox(width: Responsive.width10 / 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: curCnt / 100),
                  duration: const Duration(milliseconds: 1500),
                  builder: (context, value, child) {
                    return RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: const Color.fromARGB(255, 3, 3, 3),
                          fontSize: Responsive.width10 * 1.2,
                          letterSpacing: 2,
                        ),
                        children: [
                          TextSpan(
                              text: '${(value * 100).ceil()}',
                              style: TextStyle(color: Colors.cyan.shade700)),
                          const TextSpan(text: '/'),
                          TextSpan(text: '$totalCnt'),
                        ],
                      ),
                    );
                  },
                ),
                AnimatedLeanerProgressIndicator(
                  currentProgressCount: curCnt,
                  totalProgressCount: totalCnt,
                ),
              ],
            ),
          ),

          // SizedBox(
          //   height: Responsive.height45,
          //   width: Responsive.height45,
          //   child: AnimatedCircularProgressIndicator(
          //     currentProgressCount: curCnt,
          //     totalProgressCount: totalCnt,
          //   ),
          // ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';

class ScorePageDescription extends StatelessWidget {
  const ScorePageDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Dimentions.height10),
          const Text(
            '점수 페이지',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.scaffoldBackground),
          ),
          SizedBox(height: Dimentions.height20),
          const Text.rich(
            TextSpan(
              style: TextStyle(
                  height: 1.6,
                  wordSpacing: 1.2,
                  color: AppColors.scaffoldBackground),
              children: [
                TextSpan(text: '시험이 끝나면 점수 페이지에서 '),
                TextSpan(
                  text: '틀린 문제',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '를 또 한 번 확인하여 '),
                TextSpan(
                  text: '다시 한번 복습',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '합니다.\n\n'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

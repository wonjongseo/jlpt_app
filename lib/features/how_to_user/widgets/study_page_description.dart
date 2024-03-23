import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';

class StudyPageDescription extends StatelessWidget {
  const StudyPageDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Responsive.height10),
          const Text(
            '학습 페이지',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.scaffoldBackground),
          ),
          SizedBox(height: Responsive.height20),
          const Text.rich(
            TextSpan(
              style: TextStyle(
                  height: 1.6,
                  wordSpacing: 1.2,
                  color: AppColors.scaffoldBackground),
              children: [
                TextSpan(text: ' 학습 페이지에서 먼저 자신이 '),
                TextSpan(
                  text: '알고 있는 단어',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '인지, '),
                TextSpan(
                  text: '모르는 단어',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '인지를 가볍게 확인합니다.\n\n'),
                TextSpan(
                  text: '그 후 모르는 단어를 다시 한번 더 확인합니다.\n\n',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: ' 학습 중'),
                TextSpan(
                  text: ' 모르는 한자',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: '가 있다면 한자도 함께 학습합니다.\n\n',
                ),
                TextSpan(
                  text: ' JLPT 단어를 학습하면서 한자의 정보를 확인하면 하트가 필요합니다.',
                ),
                TextSpan(
                  text: '(하트는 시험에서 모든 단어를 맞추면 채워집니다)\n\n',
                ),
                TextSpan(text: ' 모르는 단어가 없을 때까지 해당 학습 페이지에서 학습 합니다.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

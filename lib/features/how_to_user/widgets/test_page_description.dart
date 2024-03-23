import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';

class TestPageDescription extends StatelessWidget {
  const TestPageDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Responsive.height10),
          const Text(
            '시험 페이지',
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
                TextSpan(
                  text: ' 탁음, 촉음 등을 정확히 알고 있는지',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: ' 확인하기 위해 '),
                TextSpan(
                  text: '일본어의 읽는 법',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '은 학습자가 '),
                TextSpan(
                  text: '직접 입력',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '하고 '),
                TextSpan(
                  text: '일본어의 의미',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '를 '),
                TextSpan(
                  text: '선택',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '합니다.\n\n '),

                // ---

                TextSpan(
                  text: '-주의-\n',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                TextSpan(text: ' 읽는 법은 학습 페이지에서 학습한 읽는 법과 '),
                TextSpan(
                  text: '동일하게',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: ' 작성해야 합니다.\n'),
                TextSpan(
                  text: '(단 장음(-,ー)은 입력하지 않아도 됩니다)\n\n',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                TextSpan(text: '읽는 법을 입력하고 키보드의 '),
                TextSpan(
                  text: '확인 버튼을 누르면 사지선다 문제가 표시',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '됩니다.\n\n'),
                // TextSpan(
                //   text: '선택',
                //   style: TextStyle(
                //     color: Colors.red,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                TextSpan(
                  text: '(읽는 법 주관식 기능은 설정에서 ON/OFF 할 수 있습니다)\n\n',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

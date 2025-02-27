import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';

class EngineerSaid extends StatelessWidget {
  const EngineerSaid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Responsive.height10),
          const Text(
            'JLPT 종각 앱 사용 방법에 앞서.',
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
                TextSpan(text: ' 개발자 본인은 일본어뿐만 아니라 모든 외국어의 학습에 가장 중요한 부분은 '),
                TextSpan(
                  text: '어휘력',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '이라고 생각합니다.\n\n'),
                TextSpan(text: ' 많은 블로그나 유튜브에서 외국어 공부법 혹은 외국어 단어 암기법이라고 검색하면 '),
                TextSpan(text: '어휘력이 중요하다고 강조하고 있고, 어휘력은 단순 암기이기 때문에 '),
                TextSpan(
                  text: '잊어 버리지 않도록 반복 학습',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '이 중요하다는 것도 강조하고 있는 것을 볼 수 있습니다.\n\n'),
                TextSpan(text: ' 그래서 '),
                TextSpan(
                  text: 'JLPT 종각',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '은 '),
                TextSpan(
                  text: '반복 학습',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '에 중점을 두었습니다.'),
                TextSpan(text: '\n\n\n'),
                TextSpan(text: '또한 일본어 학습에는 '),
                TextSpan(
                  text: '한자',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '도 중요합니다.\n\n'),
                TextSpan(text: ' 일본어를 그대로 학습하는 것보다도 '),
                TextSpan(
                  text: '훈독과 음독',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: ' 을 먼저 암기하고 일본어를 학습하면  '),
                TextSpan(
                  text: '학습력이 2배 이상',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: ' 증가한다고 생각합니다.\n\n'),
                TextSpan(
                    text:
                        ' 처음 보는 일본어라도 해당 일본어의 한자를 알고 있다면, 그 뜻을 추측할 수 있기 때문에 '),
                TextSpan(
                  text: '독해',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '에서도 '),
                TextSpan(
                  text: '큰 이점',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '이 될 것입니다.'),
                TextSpan(text: '\n\n'),
                TextSpan(
                    text:
                        ' 그래서 JLPT 종각은 일본어뿐만 아니라, N5급부터 N1급의 한자를 별도로 학습할 수 있고, JLPT N5급부터 N1급의 단어를 학습하면서도 '),
                TextSpan(
                  text: '한자를 클릭해서 바로바로',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: ' 해당 한자의 의미와 훈독과 음독을 학습할 수 있게 제작하였습니다. '),
                TextSpan(
                  text: '(준비되어 있지 않는 한자도 존재함)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

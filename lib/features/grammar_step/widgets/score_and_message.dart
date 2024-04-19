import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';

class ScoreAndMessage extends StatelessWidget {
  const ScoreAndMessage({
    Key? key,
    required this.score,
    required this.size,
  }) : super(key: key);

  final double score;
  final Size size;
  @override
  Widget build(BuildContext context) {
    String message = '';
    if (score >= 100) {
      message = '대단해요! 하트를 지급해 드렸습니다!';
    } else if (score <= 80 && score > 60) {
      message = '아쉽네요 ㅠ, 다음번에는 100점을 목표로 해봐요!';
    } else if (score <= 60 && score >= 40) {
      message = '분발 하셔야 하겠어요..ㅠㅠ';
    } else if (score <= 80 && score >= 60) {
      message = '문법 카드에서 예시를 확인해주세요!';
    } else {
      message = '문제를 다 맞추면 하트를 얻을 수 있어요!';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ZoomIn(
              child: Text(
                score.toInt().toString(),
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: Responsive.height10 * 6,
                  letterSpacing: 1.5,
                  fontFamily: 'ScoreStd',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            ZoomIn(
              child: Text(
                ' 점',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: Responsive.height10 * 3,
                  letterSpacing: 1.5,
                  fontFamily: 'ScoreStd',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
        ZoomIn(
          delay: const Duration(milliseconds: 300),
          child: Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Responsive.height16,
              color: AppColors.scaffoldBackground,
            ),
          ),
        ),
        SizedBox(height: Responsive.height30),
      ],
    );
  }
}

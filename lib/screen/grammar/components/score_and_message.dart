import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

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
      message = '대단해요!';
    } else if (score <= 80 && score > 60) {
      message = '아쉽네요 ㅠ, 다음번에는 100점을 목표로 해봐요!';
    } else if (score <= 60 && score >= 40) {
      message = '분발 하셔야 하겠어요..ㅠㅠ';
    } else if (score <= 60 && score >= 40) {
      message = '문법 카드에 [눈모양] 아이콘을 눌러서 예시를 확인해주세요!';
    } else {
      message = '문제를 체크하고 [제출] 버튼을 눌러주세요 ^^';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ZoomIn(
              // delay:const Duration(milliseconds: 1000),
              child: Text(
                score.toInt().toString(),
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 60,
                  letterSpacing: 1.5,
                  fontFamily: 'ScoreStd',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            ZoomIn(
              child: const Text(
                ' 점',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
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
              fontSize: size.width > 500 ? 16 : 14,
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

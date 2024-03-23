import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';

import '../../../config/colors.dart';

/*
 * 나만의 단어장 혹은 자주 틀리는 단어.
 */
class UserWordButton extends StatelessWidget {
  const UserWordButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.savedWordCount,
  });

  final Function() onTap;
  final String text;
  final int savedWordCount;

  @override
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.whiteGrey,
          boxShadow: [
            const BoxShadow(
              color: Colors.white,
              offset: Offset(1, 1),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: Center(
          child: Text.rich(
            TextSpan(
                text: '$text ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  fontSize: Responsive.width14,
                ),
                children: [
                  TextSpan(
                      text: savedWordCount.toString(),
                      style: const TextStyle(
                        color: Colors.purpleAccent,
                      )),
                  const TextSpan(text: '개 저장됨')
                ]),
          ),
        ),
      ),
    );
  }
}

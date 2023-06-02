import 'package:flutter/material.dart';
import 'package:japanese_voca/config/colors.dart';

class HangulNaviationButton extends StatelessWidget {
  const HangulNaviationButton({
    super.key,
    required this.hangul,
    required this.onTap,
    required this.totlaHangulCount,
  });
  final String hangul;
  final Function() onTap;
  final int totlaHangulCount;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            hangul,
            style: const TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteGrey,
              shadows: [
                Shadow(
                  offset: Offset(1, 1),
                  color: Colors.black,
                  blurRadius: 20,
                ),
              ],
            ),
          ),
          Text(
            '단어 ${totlaHangulCount.toString()} 개',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}

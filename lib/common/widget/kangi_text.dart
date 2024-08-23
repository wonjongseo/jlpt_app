import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';

class KangiText extends StatelessWidget {
  const KangiText({
    super.key,
    required this.japanese,
    required this.clickTwice,
    this.color = Colors.black,
    this.fontSize = 60,
  });

  final String japanese;
  final bool clickTwice;
  final double fontSize;

  final Color color;
  @override
  Widget build(BuildContext context) {
    // 동음 의이어가 있는가 없는가.
    bool isHomonym = japanese.contains('·');
    // 동음 이의어들

    List<String> homonymWords = japanese.split('·');

    if (!isHomonym) {
      return Text(
        japanese,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize == 60 ? Responsive.height50 : Responsive.height30,
          color: AppColors.scaffoldBackground,
          fontFamily: AppFonts.japaneseFont,
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            homonymWords[0],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize:
                  fontSize == 60 ? Responsive.height50 : Responsive.height30,
              color: AppColors.scaffoldBackground,
              fontFamily: AppFonts.japaneseFont,
            ),
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                '= ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: fontSize == 60
                      ? Responsive.height50 / 3
                      : Responsive.height30 / 3,
                  fontFamily: AppFonts.japaneseFont,
                ),
              ),
              ...List.generate(
                homonymWords.length - 1,
                (index) {
                  String japanese = '';
                  if (index == 0 && homonymWords.length == 2) {
                    japanese = homonymWords[index + 1];
                  } else if (index == homonymWords.length - 2) {
                    japanese = homonymWords[index + 1];
                  } else {
                    japanese = '${homonymWords[index + 1]}, ';
                  }
                  return Text(
                    japanese,
                    style: TextStyle(
                      color: color,
                      fontSize: fontSize == 60
                          ? Responsive.height50 / 2.5
                          : Responsive.height30 / 2.5,
                      fontFamily: AppFonts.japaneseFont,
                    ),
                  );
                },
              )
            ],
          ),
        ],
      );
    }
  }
}

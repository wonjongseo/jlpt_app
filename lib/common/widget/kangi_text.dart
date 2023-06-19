import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/common/widget/touchable_japanese.dart';
import 'package:flutter/material.dart';

class KangiText extends StatelessWidget {
  const KangiText({
    super.key,
    required this.japanese,
    required this.clickTwice,
    this.color = Colors.white,
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
      return TouchableJapanese(
        japanese: japanese,
        clickTwice: clickTwice,
        fontSize: fontSize == 60 ? Dimentions.height60 : Dimentions.height40,
        color: color,
        underlineColor: Colors.grey,
      );
    } else {
      return Column(
        children: [
          TouchableJapanese(
            japanese: homonymWords[0],
            clickTwice: clickTwice,
            fontSize:
                fontSize == 60 ? Dimentions.height60 : Dimentions.height40,
            color: color,
            underlineColor: Colors.grey,
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                '= ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: fontSize == 60
                      ? Dimentions.height60 / 3
                      : Dimentions.height40 / 3,
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

                  return TouchableJapanese(
                    underlineColor: Colors.grey,
                    japanese: japanese,
                    clickTwice: clickTwice,
                    color: color,
                    fontSize: fontSize == 60
                        ? Dimentions.height60 / 2.5
                        : Dimentions.height40 / 2.5,
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

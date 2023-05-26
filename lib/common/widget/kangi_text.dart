import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/kangi_related_card.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:flutter/material.dart';
import 'package:japanese_voca/common/common.dart';

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
    bool isHomonym = japanese.contains('/');
    // 동음 이의어들
    List<String> homonymWords = japanese.split('/');

    if (!isHomonym) {
      return TouchableJapanese(
        japanese: japanese,
        clickTwice: clickTwice,
        fontSize: fontSize,
        color: color,
        underlineColor: Colors.grey,
      );
    } else {
      return Column(
        children: [
          TouchableJapanese(
            japanese: homonymWords[0],
            clickTwice: clickTwice,
            fontSize: fontSize,
            underlineColor: Colors.grey,
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                '= ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize / 3,
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
                    fontSize: fontSize / 3,
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

class TouchableJapanese extends StatelessWidget {
  const TouchableJapanese({
    Key? key,
    required this.japanese,
    required this.clickTwice,
    required this.fontSize,
    required this.underlineColor,
    this.color = Colors.white,
  }) : super(key: key);
  final Color underlineColor;
  final String japanese;
  final bool clickTwice;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    List<int> kangiIndex = getKangiIndex(japanese);
    return Wrap(
      children: List.generate(japanese.length, (index) {
        return kangiIndex.contains(index)
            ? Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: fontSize == 0 ? 4 : 0),
                child: InkWell(
                  onTap: () => getDialogKangi(japanese[index], context,
                      clickTwice: clickTwice),
                  child: Text(
                    japanese[index],
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: underlineColor,
                        color: color,
                        fontSize: fontSize),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Text(
                japanese[index],
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: fontSize,
                      color: color,
                    ),
                textAlign: TextAlign.center,
              );
      }),
    );
  }
}

void getDialogKangi(String japanese, BuildContext context,
    {clickTwice = false}) {
  Size size = MediaQuery.of(context).size;
  KangiStepRepositroy kangiStepRepositroy = KangiStepRepositroy();

  Kangi? kangi = kangiStepRepositroy.getKangi(japanese);

  if (kangi == null) {
    Get.dialog(AlertDialog(
      content: Text('한자 $japanese가 아직 준비 되어 있지 않습니다.'),
    ));
    return;
  }
  Get.dialog(AlertDialog(
    titlePadding:
        const EdgeInsets.only(top: 16, bottom: 0, right: 16, left: 16),
    // contentPadding:
    //     const EdgeInsets.only(top: 0, bottom: 16, right: 16, left: 16),
    title: Text(
      kangi.japan,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          kangi.korea,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '음독 : ${kangi.undoc}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '훈독 : ${kangi.hundoc}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (kangi.relatedVoca.isNotEmpty && !clickTwice)
              ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    '나가기',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            const SizedBox(width: 10),
            if (clickTwice)
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text(
                  '나가기',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            else
              ElevatedButton(
                onPressed: () {
                  if (kangi.relatedVoca.isEmpty) {
                    Get.back();
                  } else {
                    int currentIndex = 0;
                    bool isShownMean = false;
                    bool isShownYomikata = false;
                    double sizeBoxWidth = size.width < 500 ? 8 : 16;
                    double sizeBoxHight = size.width < 500 ? 16 : 32;
                    Get.dialog(StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        String japanese = kangi.relatedVoca[currentIndex].word;

                        void moveWord(bool isNext) {
                          isShownMean = false;
                          isShownYomikata = false;
                          if (isNext) {
                            currentIndex++;

                            if (currentIndex >= kangi.relatedVoca.length) {
                              getBacks(2);
                              return;
                            } else {
                              setState(
                                () {},
                              );
                            }
                          } else {
                            currentIndex--;

                            if (currentIndex < 0) {
                              currentIndex = 0;
                              return;
                            }

                            setState(
                              () {},
                            );
                          }
                        }

                        return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            titlePadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () => getBacks(2),
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                    )),
                                Text(
                                  kangi.korea,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    MyWord.saveToMyVoca(
                                        kangi.relatedVoca[currentIndex],
                                        isManualSave: true);
                                  },
                                  icon: const Icon(
                                    Icons.save,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            content: KangiRelatedCard(
                              kangi: kangi,
                              onTap: moveWord,
                            ));
                      },
                    ), transitionCurve: Curves.easeInOut);
                  }
                },
                child: Text(
                  kangi.relatedVoca.isEmpty ? '나가기' : '연관 단어',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
          ],
        )
      ],
    ),
    // actions: [

    // ],
  ));
}

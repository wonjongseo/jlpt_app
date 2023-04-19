import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/screen/score/components/wrong_word_card.dart';

class KangiText extends StatelessWidget {
  const KangiText(
      {super.key, required this.japanese, required this.clickTwice});

  final String japanese;
  final bool clickTwice;
  @override
  Widget build(BuildContext context) {
    bool isMultiWord = japanese.contains('/');
    List<String> multiWord = japanese.split('/');

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: !isMultiWord
          ? TouchableJapanese(
              japanese: japanese,
              clickTwice: clickTwice,
              fontSize: 60,
            )
          : Column(
              children: [
                TouchableJapanese(
                  japanese: multiWord[0],
                  clickTwice: clickTwice,
                  fontSize: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    multiWord.length - 1,
                    (index) {
                      return TouchableJapanese(
                        japanese: ' (${multiWord[index + 1]}) ',
                        clickTwice: clickTwice,
                        fontSize: 30,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class TouchableJapanese extends StatelessWidget {
  const TouchableJapanese({
    Key? key,
    required this.japanese,
    required this.clickTwice,
    required this.fontSize,
  }) : super(key: key);

  final String japanese;
  final bool clickTwice;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    List<int> kangiIndex = getKangiIndex(japanese);
    return Wrap(
      // mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
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
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.grey,
                        fontSize: fontSize),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Text(
                japanese[index],
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(fontSize: fontSize),
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
    contentPadding:
        const EdgeInsets.only(top: 0, bottom: 16, right: 16, left: 16),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          kangi.japan,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ],
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
      ],
    ),
    actions: [
      if (kangi.relatedVoca.isNotEmpty && !clickTwice)
        CustomButton(text: '나가기', onTap: () => Get.back()),
      CustomButton(
          text: clickTwice
              ? '나가기'
              : kangi.relatedVoca.isEmpty
                  ? '나가기'
                  : '연관 단어 보기',
          onTap: clickTwice
              ? () {
                  Get.back();
                }
              : kangi.relatedVoca.isEmpty
                  ? () {
                      Get.back();
                    }
                  : () {
                      int currentIndex = 0;
                      bool isShownMean = false;
                      bool isShownYomikata = false;
                      double sizeBoxWidth = size.width < 500 ? 8 : 16;
                      double sizeBoxHight = size.width < 500 ? 16 : 32;
                      List<Word> unKownWord = [];
                      Get.dialog(StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        String japanese = kangi.relatedVoca[currentIndex].word;

                        void nextWord(bool isKnownWord) {
                          isShownMean = false;
                          isShownYomikata = false;

                          if (!isKnownWord) {
                            unKownWord.add(kangi.relatedVoca[currentIndex]);
                          }
                          currentIndex++;

                          if (currentIndex >= kangi.relatedVoca.length) {
                            if (unKownWord.isNotEmpty) {
                              Get.back();

                              Get.dialog(AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  content: Container(
                                    width: size.width < 500
                                        ? null
                                        : size.width / 1.5,
                                    height: size.width < 500
                                        ? null
                                        : size.width / 1.5,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(13)),
                                    child: Column(
                                      children: [
                                        Text('오답.'),
                                        const SizedBox(height: 10),
                                        Expanded(
                                            child: SingleChildScrollView(
                                          child: Column(
                                            children: List.generate(
                                              unKownWord.length,
                                              (index) => WrongWordCard(
                                                word: unKownWord[index].word,
                                                mean:
                                                    '${unKownWord[index].mean}\n${unKownWord[index].yomikata}',
                                                onTap: () => MyWord.saveMyVoca(
                                                  unKownWord[index],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ))
                                      ],
                                    ),
                                  )));
                            } else {
                              getBacks(2);
                              return;
                            }
                          } else {
                            setState(
                              () {},
                            );
                          }
                        }

                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          title: Text(kangi.korea),
                          elevation: 0,
                          content: Container(
                            width: size.width < 500 ? null : size.width / 1.5,
                            height: size.width < 500 ? null : size.width / 1.5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: sizeBoxHight / 2),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () => getBacks(2),
                                          icon:
                                              const Icon(Icons.arrow_back_ios)),
                                      IconButton(
                                          onPressed: () {
                                            MyWord.saveMyVoca(
                                                kangi.relatedVoca[currentIndex],
                                                isManualSave: true);
                                          },
                                          icon: SvgPicture.asset(
                                              'assets/svg/save.svg')),
                                    ],
                                  ),
                                ),
                                Text(kangi.korea),
                                SizedBox(height: sizeBoxHight / 3),
                                Text(kangi.relatedVoca[currentIndex].yomikata,
                                    style: TextStyle(
                                        color: isShownYomikata
                                            ? Colors.black
                                            : Colors.transparent)),
                                KangiText(japanese: japanese, clickTwice: true),
                                Text(kangi.relatedVoca[currentIndex].mean,
                                    style: TextStyle(
                                        color: isShownMean
                                            ? Colors.black
                                            : Colors.transparent)),
                                SizedBox(height: sizeBoxHight),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomButton(
                                          text: '의미',
                                          onTap: () => setState((() {
                                            isShownMean = !isShownMean;
                                          })),
                                        ),
                                        SizedBox(width: sizeBoxWidth),
                                        CustomButton(
                                          text: '읽는 법',
                                          onTap: () => setState((() {
                                            isShownYomikata = !isShownYomikata;
                                          })),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: sizeBoxWidth),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomButton(
                                          text: '몰라요',
                                          onTap: () {
                                            nextWord(false);
                                          },
                                        ),
                                        SizedBox(width: sizeBoxWidth),
                                        CustomButton(
                                          text: '알아요',
                                          onTap: () {
                                            nextWord(true);
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: sizeBoxHight),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }), transitionCurve: Curves.easeInOut);
                    })
    ],
  ));
}

import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:japanese_voca/common/common.dart';

class KangiText extends StatelessWidget {
  const KangiText(
      {super.key, required this.japanese, required this.clickTwice});

  final String japanese;
  final bool clickTwice;
  @override
  Widget build(BuildContext context) {
    List<int> kangiIndex = getKangiIndex(japanese);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(japanese.length, (index) {
          return kangiIndex.contains(index)
              ? InkWell(
                  onTap: () => getDialogKangi(japanese[index], context,
                      clickTwice: clickTwice),
                  child: Text(
                    japanese[index],
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.redAccent,
                          // decorationStyle: TextDecorationStyle.dashed,
                        ),
                    textAlign: TextAlign.center,
                  ),
                )
              : Text(
                  japanese[index],
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                );
        }),
      ),
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
    title: InkWell(
      onTap: () => copyWord(kangi.japan),
      child: Text(
        kangi.japan,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25),
      ),
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

                          if (isKnownWord) {
                            unKownWord.add(kangi.relatedVoca[currentIndex]);
                          }
                          currentIndex++;

                          if (currentIndex >= kangi.relatedVoca.length) {
                            getBacks(2);

                            return;
                          }

                          setState(
                            () {},
                          );
                        }

                        // void nextWord(bool isKnownWord) {
                        //   isShownMean = false;
                        //   isShownYomikata = false;

                        //   if (isKnownWord) {
                        //     currentIndex++;
                        //     if (currentIndex >= kangi.relatedVoca.length) {
                        //       getBacks(2);

                        //       return;
                        //     }
                        //   } else {
                        //     currentIndex--;
                        //     if (currentIndex < 0) {
                        //       currentIndex = 0;
                        //       return;
                        //     }
                        //   }
                        //   setState(
                        //     () {},
                        //   );
                        // }

                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
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
                                SizedBox(height: sizeBoxHight),
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
                                SizedBox(height: sizeBoxHight),
                                Text(kangi.relatedVoca[currentIndex].yomikata,
                                    style: TextStyle(
                                        color: isShownYomikata
                                            ? Colors.black
                                            : Colors.transparent)),
                                KangiText(japanese: japanese, clickTwice: true),
                                // Container(
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(8),
                                //   ),
                                //   child: Row(
                                //     mainAxisSize: MainAxisSize.min,
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children:
                                //         List.generate(japanese.length, (index) {
                                //       List<int> kangiIndex =
                                //           getKangiIndex(japanese);
                                //       return kangiIndex.contains(index)
                                //           ? InkWell(
                                //               onTap: () => getDialogKangi(
                                //                   japanese[index], context,
                                //                   clickTwice: true),
                                //               child: Text(
                                //                 japanese[index],
                                //                 style: Theme.of(context)
                                //                     .textTheme
                                //                     .headline3,
                                //                 textAlign: TextAlign.center,
                                //               ),
                                //             )
                                //           : Text(
                                //               japanese[index],
                                //               style: Theme.of(context)
                                //                   .textTheme
                                //                   .headline3,
                                //               textAlign: TextAlign.center,
                                //             );
                                //     }),
                                //   ),
                                // ),
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
                                          text: '이전',
                                          onTap: () {
                                            nextWord(false);
                                          },
                                        ),
                                        SizedBox(width: sizeBoxWidth),
                                        CustomButton(
                                          text: '다음',
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

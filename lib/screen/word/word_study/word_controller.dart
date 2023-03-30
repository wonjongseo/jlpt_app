import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:japanese_voca/repository/localRepository.dart';
import 'package:japanese_voca/screen/quiz/quiz_screen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_word_controller.dart';
import 'package:japanese_voca/screen/word/word_study/word_study_sceen.dart';

import '../../../model/word.dart';

class WordStudyController extends GetxController {
  WordStudyController({this.isAgainTest});
  JlptWordController jlptWordController = Get.find<JlptWordController>();

  KangiStepRepositroy kangiStepRepositroy = KangiStepRepositroy();

  late JlptStep jlptStep;
  int currentIndex = 0;
  int correctCount = 0;

  bool? isAgainTest;

  List<Word> unKnownWords = [];
  List<Word> words = [];

  bool isShowQustionmar = true;

  String transparentMean = '';
  String transparentYomikata = '';

  bool isShownMean = false;
  bool isShownYomikata = false;

  void showMean() {
    isShownMean = !isShownMean;
    update();
  }

  void showYomikata() {
    isShownYomikata = !isShownYomikata;
    update();
  }

  void getKangi(String japanese, BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            text: kangi.relatedVoca.isEmpty ? '나가기' : '연관 단어 보기',
            onTap: kangi.relatedVoca.isEmpty
                ? () {
                    Get.back();
                  }
                : () {
                    int currentIndex = 0;
                    bool isShownMean = false;
                    bool isShownYomikata = false;
                    double sizeBoxWidth = size.width < 500 ? 8 : 16;
                    double sizeBoxHight = size.width < 500 ? 16 : 32;
                    Get.dialog(StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      void nextWord(bool isNext) {
                        isShownMean = false;
                        isShownYomikata = false;

                        if (isNext) {
                          currentIndex++;
                          if (currentIndex >= kangi.relatedVoca.length) {
                            getBacks(2);

                            return;
                          }
                        } else {
                          currentIndex--;
                          if (currentIndex < 0) {
                            currentIndex = 0;
                            return;
                          }
                        }
                        setState(
                          () {},
                        );
                      }

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
                                        icon: const Icon(Icons.arrow_back_ios)),
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
                              InkWell(
                                onTap: () => copyWord(
                                    kangi.relatedVoca[currentIndex].word),
                                child: Text(
                                  kangi.relatedVoca[currentIndex].word,
                                  style: Theme.of(context).textTheme.headline3,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(kangi.relatedVoca[currentIndex].mean,
                                  style: TextStyle(
                                      color: isShownMean
                                          ? Colors.black
                                          : Colors.transparent)),
                              SizedBox(height: sizeBoxHight),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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

  Text get yomikata => isShowQustionmar
      ? Text(
          !isShownYomikata ? transparentYomikata : words[currentIndex].yomikata)
      : Text(words[currentIndex].yomikata,
          style: TextStyle(
              color: isShownYomikata ? Colors.black : Colors.transparent));

  Text get mean => isShowQustionmar
      ? Text(!isShownMean ? transparentMean : words[currentIndex].mean)
      : Text(words[currentIndex].mean,
          style: TextStyle(
              color: isShownMean ? Colors.black : Colors.transparent));

  @override
  void onInit() {
    super.onInit();

    isShowQustionmar = LocalReposotiry.getquestionMark();
    jlptStep = jlptWordController.getJlptStep();

    if (jlptStep.unKnownWord.isNotEmpty) {
      words = jlptStep.unKnownWord;
    } else {
      words = jlptStep.words;
    }
    if (isShowQustionmar) {
      transparentMean = createTransparentText(words[currentIndex].mean);
      transparentYomikata = createTransparentText(words[currentIndex].yomikata);
    }
  }

  String createTransparentText(String word) {
    String transparentText = '';
    for (int i = 0; i < word.length; i++) {
      if (word[i] == ' ') {
        transparentText += ' ';
      } else if (word[i] == ',') {
        transparentText += ',';
      } else {
        transparentText += '?';
      }
    }
    return transparentText;
  }

  void nextWord(bool isKnwon) async {
    isShownMean = false;
    isShownYomikata = false;

    Word currentWord = words[currentIndex];

    if (isKnwon == false) {
      Get.closeCurrentSnackbar();
      unKnownWords.add(currentWord);
      MyWord.saveMyVoca(currentWord);
    } else {
      correctCount++;
    }
    currentIndex++;

    if (currentIndex >= words.length) {
      //테스트 2번째

      if (unKnownWords.isNotEmpty) {
        if (isAgainTest != null) {
          final alertResult = await getAlertDialog(
              Text('${unKnownWords.length}가 남아 있습니다.'),
              const Text('테스트 페이지로 넘어가시겠습니까?'),
              barrierDismissible: true);
          if (alertResult != null) {
            if (alertResult!) {
              Get.closeAllSnackbars();
              jlptWordController.updateScore(correctCount);
              goToTest();
            } else {
              jlptWordController.updateScore(correctCount);
              Get.back();
            }
          } else {
            jlptWordController.updateScore(correctCount);
            Get.back();
          }

          return;
        }
        final alertResult = await getAlertDialog(
          Text('${unKnownWords.length}가 남아 있습니다.'),
          const Text('모르는 단어를 다시 보시겠습니까?'),
        );

        if (alertResult!) {
          Get.closeAllSnackbars();
          unKnownWords.shuffle();
          jlptStep.unKnownWord = unKnownWords;
          jlptWordController.updateScore(correctCount);
          Get.offNamed(WORD_STUDY_PATH,
              arguments: {'againTest': true}, preventDuplicates: false);
        } else {
          Get.closeAllSnackbars();
          jlptStep.unKnownWord = [];
          jlptWordController.updateScore(correctCount);
          Get.back();
        }

        return;
      } else {
        // 모르는 단어가 없는 경우
        jlptStep.unKnownWord = [];
        isAgainTest = true;
        jlptWordController.updateScore(correctCount);
        Get.back();
        return;
      }
    } else {}
    if (isShowQustionmar) {
      transparentMean = createTransparentText(words[currentIndex].mean);
      transparentYomikata = createTransparentText(words[currentIndex].yomikata);
    }

    // setState(() {});

    update();
  }

  void goToTest() async {
    bool? alertResult = await getTransparentAlertDialog(
      contentChildren: [
        CustomButton(text: '뜻', onTap: () => Get.back(result: true)),
        CustomButton(text: '읽는 법', onTap: () => Get.back(result: false)),
      ],
    );

    if (alertResult != null) {
      Get.toNamed(QUIZ_PATH,
          arguments: {'words': jlptStep.words, 'alertResult': alertResult});
    }
  }
}

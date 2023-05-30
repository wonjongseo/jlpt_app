import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/ad_controller.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/screen/quiz/quiz_screen.dart';
import 'package:japanese_voca/controller/jlpt_word_controller.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/jlpt_study_sceen.dart';

import '../../../model/word.dart';

class JlptStudyController extends GetxController {
  JlptStudyController({this.isAgainTest});
  JlptWordController jlptWordController = Get.find<JlptWordController>();
  AdController adController = Get.find<AdController>();

  late PageController pageController;

  late JlptStep jlptStep;

  double buttonWidth = 100;
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
    buttonWidth = 20;
    isShownYomikata = !isShownYomikata;
    update();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int page) {
    currentIndex = page;
    // update();
  }

  Widget yomikata() {
    if (words[currentIndex].yomikata[0] != '-' &&
        words[currentIndex].yomikata.contains('-')) {
      print('222222');
      words[currentIndex].yomikata =
          words[currentIndex].yomikata.replaceAll('-', '');
    }
    if (isShowQustionmar) {
      return Text(
        isShownYomikata ? words[currentIndex].yomikata : transparentYomikata,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      );
    } else {
      return ZoomIn(
        animate: isShownYomikata,
        duration: const Duration(milliseconds: 300),
        child: Text(
          words[currentIndex].yomikata,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: isShownYomikata ? Colors.white : Colors.transparent,
          ),
        ),
      );
    }
  }

  Widget mean() {
    // 또,
    words[currentIndex].mean = words[currentIndex].mean.replaceAll(';', ',');
    bool isMeanOverThree = words[currentIndex].mean.contains('\n3.');
    bool isMeanOverTwo = words[currentIndex].mean.contains('\n2.');

    double fontSize = 20;
    if (isShowQustionmar) {
      return Text(
        isShownMean ? words[currentIndex].mean : transparentMean,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      );
    } else if (isMeanOverThree) {
      fontSize = 16;
      List<String> means = words[currentIndex].mean.split('\n');
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: List.generate(
              3,
              (index) => Text(
                '${(index + 1).toString()}. ',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              3,
              (index) {
                String mean = means[index].split('. ')[1];
                if (mean.contains('; ')) {
                  List<String> temp = mean.split('; ');
                  print('temp: ${temp}');
                }
                return ZoomIn(
                  animate: isShownMean,
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    mean,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w700,
                      color: isShownMean ? Colors.white : Colors.transparent,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      );
    } else if (isMeanOverTwo) {
      fontSize = 18;

      List<String> means = words[currentIndex].mean.split('\n');

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: List.generate(
              2,
              (index) => Text(
                '${(index + 1).toString()}. ',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              2,
              (index) {
                String mean = means[index].split('. ')[1];
                return ZoomIn(
                  animate: isShownMean,
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    mean,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w700,
                      color: isShownMean ? Colors.white : Colors.transparent,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      );
    }
    String mean = words[currentIndex].mean;
    if (mean.contains('; ')) {
      List<String> temp = mean.split('; ');
      print('temp: ${temp}');
    }

    return ZoomIn(
      animate: isShownMean,
      duration: const Duration(milliseconds: 300),
      child: Text(
        mean,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: isShownMean ? Colors.white : Colors.transparent,
        ),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
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
      } else if (word[i] == '1') {
        transparentText += '1';
      } else if (word[i] == '2') {
        transparentText += '2';
      } else if (word[i] == '3') {
        transparentText += '3';
      } else if (word[i] == '.') {
        transparentText += '.';
      } else if (word[i] == ';') {
        transparentText += ';';
      } else if (word[i] == '\n') {
        transparentText += '\n';
      } else {
        transparentText += '?';
      }
    }
    return transparentText;
  }

  void nextWord(bool isWordKnwon) async {
    isShownMean = false;
    isShownYomikata = false;

    Word currentWord = words[currentIndex];

    if (isWordKnwon) {
      correctCount++;
    } else {
      Get.closeCurrentSnackbar();
      unKnownWords.add(currentWord);
      MyWord.saveToMyVoca(currentWord);
    }

    currentIndex++;
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
    if (currentIndex >= words.length) {
      if (unKnownWords.isNotEmpty) {
        if (isAgainTest != null) {
          // 단어 보기 두번째
          final alertResult = await getAlertDialog(
              Text('${unKnownWords.length}가 남아 있습니다.'),
              const Text('테스트 페이지로 넘어가시겠습니까?'),
              barrierDismissible: true);
          if (alertResult != null) {
            if (alertResult) {
              Get.closeAllSnackbars();
              // jlptWordController.updateScore(correctCount);
              goToTest();
            } else {
              // jlptWordController.updateScore(correctCount);
              Get.back();
            }
          } else {
            // jlptWordController.updateScore(correctCount);
            Get.back();
          }

          return;
        } else {
          // 첫번째 두번째
          final alertResult = await getAlertDialog(
            Text('${unKnownWords.length}가 남아 있습니다.'),
            const Text('모르는 단어를 다시 보시겠습니까?'),
          );

          if (alertResult!) {
            adController.showRewardedInterstitialAd();
            bool isAutoSave = LocalReposotiry.getAutoSave();
            Get.closeAllSnackbars();
            unKnownWords.shuffle();
            jlptStep.unKnownWord = unKnownWords;
            // jlptWordController.updateScore(correctCount);
            Get.offNamed(JLPT_STUDY_PATH,
                arguments: {'againTest': true, 'isAutoSave': isAutoSave},
                preventDuplicates: false);
          } else {
            Get.closeAllSnackbars();
            jlptStep.unKnownWord = [];
            // jlptWordController.updateScore(correctCount);
            Get.back();
          }

          return;
        }
      } else {
        // 모르는 단어가 없는 경우
        jlptStep.unKnownWord = [];
        isAgainTest = true;
        final alertResult = await askToWatchMovieAndGetHeart(
          title: const Text('점수를 기록하고 하트를 채워요!'),
          content: const Text('테스트 페이지로 넘어가시겠습니까?'),
        );
        if (alertResult) {
          await goToTest();
        } else {
          Get.back();
        }
        return;
      }
    } else {}
    if (isShowQustionmar) {
      transparentMean = createTransparentText(words[currentIndex].mean);
      transparentYomikata = createTransparentText(words[currentIndex].yomikata);
    }
    update();
  }

  Future<void> goToTest() async {
    bool? testType = await getTransparentAlertDialog(
      contentChildren: [
        CustomButton(text: '의미', onTap: () => Get.back(result: true)),
        CustomButton(text: '읽는 법', onTap: () => Get.back(result: false)),
      ],
    );

    if (testType != null) {
      Get.toNamed(
        QUIZ_PATH,
        arguments: {
          JLPT_TEST: jlptStep.words,
          TEST_TYPE: testType,
        },
      );
    }
  }
}

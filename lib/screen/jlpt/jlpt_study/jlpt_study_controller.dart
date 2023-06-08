import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/ad_controller.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_quiz/jlpt_quiz_screen.dart';
import 'package:japanese_voca/controller/jlpt_word_controller.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/jlpt_study_sceen.dart';

import '../../../config/colors.dart';
import '../../../model/word.dart';

class JlptStudyController extends GetxController {
  JlptWordController jlptWordController = Get.find<JlptWordController>();
  AdController adController = Get.find<AdController>();

  late PageController pageController;

  late JlptStep jlptStep;

  double buttonWidth = 100;
  int currentIndex = 0;
  int correctCount = 0;

  List<Word> unKnownWords = [];
  List<Word> words = [];

  bool isShowQustionmar = true;

  String transparentMean = '';
  String transparentYomikata = '';

  bool isShownMean = false;
  bool isShownYomikata = false;

  double getCurrentProgressValue() {
    return (currentIndex.toDouble() / words.length.toDouble()) * 100;
  }

  void saveCurrentWord() {
    Word currentWord = words[currentIndex];
    MyWord.saveToMyVoca(currentWord, isManualSave: true);
  }

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

    bool isMeanOverThree = words[currentIndex].mean.contains('\n3.');
    bool isMeanOverTwo = words[currentIndex].mean.contains('\n2.');

    double fontSize = 22;
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
      fontSize = 18;
      List<String> means = words[currentIndex].mean.split('\n');
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
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
        ),
      );
    } else if (isMeanOverTwo) {
      fontSize = 20;

      List<String> means = words[currentIndex].mean.split('\n');

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
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
        ),
      );
    }
    String mean = words[currentIndex].mean;

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

  bool isAginText = false;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    isShowQustionmar = LocalReposotiry.getquestionMark();
    jlptStep = jlptWordController.getJlptStep();

    if (jlptStep.unKnownWord.isNotEmpty) {
      isAginText = true;
      words = jlptStep.unKnownWord;
    } else {
      words = jlptStep.words;
    }
    if (isShowQustionmar) {
      transparentMean = createTransparentText(words[currentIndex].mean);
      transparentYomikata = createTransparentText(words[currentIndex].yomikata);
    }
  }

  void nextWord(bool isWordKnwon) async {
    isShownMean = false;
    isShownYomikata = false;

    Word currentWord = words[currentIndex];

    // [알아요] 버튼 클릭 시
    if (isWordKnwon) {
      correctCount++;
    }
    // [몰라요] 버튼 클릭 시
    else {
      jlptWordController.countOfWrong++;
      Get.closeCurrentSnackbar();
      unKnownWords.add(currentWord);
      MyWord.saveToMyVoca(currentWord);
    }

    currentIndex++;

    // 단어 학습 중. (남아 있는 단어 존재)
    if (currentIndex < words.length) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
    }
    // 단어 학습 완료. (남아 있는 단어 없음)
    else {
      // 전부 다 [알아요] 버튼을 눌렀는 지
      if (unKnownWords.isEmpty) {
        jlptStep.unKnownWord = []; // 남아 있을 모르는 단어 삭제.
        bool result = await askToWatchMovieAndGetHeart(
          title: const Text('점수를 기록하고 하트를 채워요!'),
          content: const Text(
            '테스트 페이지로 넘어가시겠습니까?',
            style: TextStyle(color: AppColors.scaffoldBackground),
          ),
        );
        if (result) {
          await goToTest();
          return;
        } else {
          Get.back();
          return;
        }
      }

      // [몰라요] 버튼을 누른 적이 있는지
      else {
        bool result = await askToWatchMovieAndGetHeart(
          title: Text('${unKnownWords.length}개가 남아 있습니다.'),
          content: const Text('모르는 단어를 다시 보시겠습니까?'),
        );

        // 몰라요 단어 다시 학습.
        if (result) {
          bool isAutoSave = LocalReposotiry.getAutoSave();

          unKnownWords.shuffle();

          currentIndex = 0; // 화면 에러 방지
          jlptStep.unKnownWord = unKnownWords;
          Get.offNamed(
            JLPT_STUDY_PATH,
            arguments: {'isAutoSave': isAutoSave},
            preventDuplicates: false,
          );
        } else {
          Get.closeAllSnackbars();
          jlptStep.unKnownWord = [];
          Get.back();
        }
      }
    }
    update();
    return;
  }

  Future<void> goToTest() async {
    // 테스트를 본 적이 있으면.
    if (jlptStep.wrongQestion != null && jlptStep.scores != 0) {
      bool result = await askToWatchMovieAndGetHeart(
        title: const Text('과거에 테스트에서 틀린 문제들이 있습니다.'),
        content: const Text(
          '틀린 문제를 기준으로 다시 보시겠습니까 ?',
          style: TextStyle(
            color: AppColors.scaffoldBackground,
          ),
        ),
      );
      if (result) {
        // 과거에 틀린 문제로만 테스트 보기.
        Get.toNamed(
          JLPT_QUIZ_PATH,
          arguments: {
            CONTINUTE_JLPT_TEST: jlptStep.wrongQestion,
          },
        );
      }
    }

    // 모든 문제로 테스트 보기.
    Get.toNamed(
      JLPT_QUIZ_PATH,
      arguments: {
        JLPT_TEST: jlptStep.words,
      },
    );
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
}

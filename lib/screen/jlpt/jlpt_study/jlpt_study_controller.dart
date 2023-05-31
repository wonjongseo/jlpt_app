import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/ad_controller.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/screen/quiz/quiz_screen.dart';
import 'package:japanese_voca/controller/jlpt_word_controller.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/jlpt_study_sceen.dart';

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
    print('yomikata');
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

    // [알아요] 버튼 클릭 시
    if (isWordKnwon) {
      correctCount++;
    }
    // [몰라요] 버튼 클릭 시
    else {
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
          content: const Text('테스트 페이지로 넘어가시겠습니까?'),
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
          title: Text('${unKnownWords.length}가 남아 있습니다.'),
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
    Get.toNamed(
      QUIZ_PATH,
      arguments: {
        JLPT_TEST: jlptStep.words,
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  GlobalKey meanKey = GlobalKey();
  GlobalKey yomikataKey = GlobalKey();
  GlobalKey knownKey = GlobalKey();
  GlobalKey unknownKey = GlobalKey();
  GlobalKey clickKangiKey = GlobalKey();
  GlobalKey testKey = GlobalKey();

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

  Text get yomikata => isShowQustionmar
      ? Text(
          key: yomikataKey,
          !isShownYomikata ? transparentYomikata : words[currentIndex].yomikata,
          style: const TextStyle(color: Colors.white))
      : Text(
          key: yomikataKey,
          words[currentIndex].yomikata,
          style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: isShownYomikata ? Colors.white : Colors.transparent));

  Text get mean => isShowQustionmar
      ? Text(
          key: meanKey,
          !isShownMean ? transparentMean : words[currentIndex].mean,
          style: const TextStyle(color: Colors.white),
        )
      : Text(words[currentIndex].mean,
          key: meanKey,
          style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: isShownMean ? Colors.white : Colors.transparent));

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

  void nextWord(bool isWordKnwon) async {
    isShownMean = false;
    isShownYomikata = false;

    Word currentWord = words[currentIndex];

    if (isWordKnwon == false) {
      Get.closeCurrentSnackbar();
      unKnownWords.add(currentWord);
      MyWord.saveToMyVoca(currentWord);
    } else {
      correctCount++;
    }
    currentIndex++;

    if (currentIndex >= words.length) {
      if (unKnownWords.isNotEmpty) {
        if (isAgainTest != null) {
          // 테스트 두번째
          final alertResult = await getAlertDialog(
              Text('${unKnownWords.length}가 남아 있습니다.'),
              const Text('테스트 페이지로 넘어가시겠습니까?'),
              barrierDismissible: true);
          if (alertResult != null) {
            if (alertResult) {
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
        } else {
          // 첫번째 두번째
          final alertResult = await getAlertDialog(
            Text('${unKnownWords.length}가 남아 있습니다.'),
            const Text('모르는 단어를 다시 보시겠습니까?'),
          );

          if (alertResult!) {
            bool isAutoSave = LocalReposotiry.getAutoSave();
            Get.closeAllSnackbars();
            unKnownWords.shuffle();
            jlptStep.unKnownWord = unKnownWords;
            jlptWordController.updateScore(correctCount);
            Get.offNamed(JLPT_STUDY_PATH,
                arguments: {'againTest': true, 'isAutoSave': isAutoSave},
                preventDuplicates: false);
          } else {
            Get.closeAllSnackbars();
            jlptStep.unKnownWord = [];
            jlptWordController.updateScore(correctCount);
            Get.back();
          }

          return;
        }
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

    update();
  }

  void goToTest() async {
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

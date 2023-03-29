import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/localRepository.dart';
import 'package:japanese_voca/screen/quiz/quiz_screen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_word_controller.dart';
import 'package:japanese_voca/screen/word/word_study/word_study_sceen.dart';

import '../../../model/word.dart';

class WordController extends GetxController {
  WordController({this.isAgainTest});
  JlptWordController jlptWordController = Get.find<JlptWordController>();

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
    print('onInit');
    print('isAgainTest: ${isAgainTest}');

    isShowQustionmar = LocalReposotiry.getquestionMark();

    // if (Get.arguments != null && Get.arguments['againTest'] != null) {
    //   isAgainTest = true;
    // }

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

  void copyWord() {
    Clipboard.setData(ClipboardData(text: words[currentIndex].word));

    if (!Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Copied',
        '${words[currentIndex].word}가 복사(Ctrl + C) 되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(seconds: 2),
      );
    }
  }
}

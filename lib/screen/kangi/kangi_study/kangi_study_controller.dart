import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/kangi_step.dart';
import 'package:japanese_voca/repository/localRepository.dart';
import 'package:japanese_voca/screen/kangi/kangi_step_controller.dart';
import 'package:japanese_voca/screen/quiz/quiz_screen.dart';
import 'package:japanese_voca/screen/word/word_study/word_study_sceen.dart';

import '../../../model/word.dart';

class KangiController extends GetxController {
  KangiController({this.isAgainTest});
  KangiStepController kangiController = Get.find<KangiStepController>();

  late KangiStep kangiStep;
  int currentIndex = 0;
  int correctCount = 0;

  bool? isAgainTest;

  List<Kangi> unKnownKangis = [];
  List<Kangi> kangis = [];

  bool isShowQustionmar = true;

  bool isShownKorean = false;
  bool isShownUndoc = false;
  bool isShownHundoc = false;

  void showKorean() {
    isShownKorean = !isShownKorean;
    update();
  }

  void showHundoc() {
    isShownHundoc = !isShownHundoc;
    update();
  }

  void showUndoc() {
    isShownUndoc = !isShownUndoc;
    update();
  }

  Text get undoc => Text(kangis[currentIndex].undoc,
      style:
          TextStyle(color: isShownUndoc ? Colors.black : Colors.transparent));

  Text get hundoc => Text(kangis[currentIndex].hundoc,
      style:
          TextStyle(color: isShownHundoc ? Colors.black : Colors.transparent));

  Text get korea => Text(kangis[currentIndex].korea,
      style:
          TextStyle(color: isShownKorean ? Colors.black : Colors.transparent));

  @override
  void onInit() {
    super.onInit();

    isShowQustionmar = LocalReposotiry.getquestionMark();

    // if (Get.arguments != null && Get.arguments['againTest'] != null) {
    //   isAgainTest = true;
    // }

    kangiStep = kangiController.getJlptStep();

    if (kangiStep.unKnownKangis.isNotEmpty) {
      kangis = kangiStep.unKnownKangis;
    } else {
      kangis = kangiStep.kangis;
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
    isShownKorean = false;
    isShownUndoc = false;

    Kangi currentKangi = kangis[currentIndex];

    if (isKnwon == false) {
      Get.closeCurrentSnackbar();
      unKnownKangis.add(currentKangi);
      Word word = Word(
          word: currentKangi.japan,
          mean: currentKangi.korea,
          yomikata: '${currentKangi.undoc}\n${currentKangi.hundoc}',
          headTitle: currentKangi.headTitle);
      MyWord.saveMyVoca(word);
    } else {
      correctCount++;
    }
    currentIndex++;

    if (currentIndex >= kangis.length) {
      //테스트 2번째

      if (unKnownKangis.isNotEmpty) {
        if (isAgainTest != null) {
          final alertResult = await getAlertDialog(
              Text('${unKnownKangis.length}가 남아 있습니다.'),
              const Text('테스트 페이지로 넘어가시겠습니까?'),
              barrierDismissible: true);
          if (alertResult != null) {
            if (alertResult) {
              Get.closeAllSnackbars();
              kangiController.updateScore(correctCount);
              goToTest();
            } else {
              kangiController.updateScore(correctCount);
              Get.back();
            }
          } else {
            kangiController.updateScore(correctCount);
            Get.back();
          }

          return;
        }
        final alertResult = await getAlertDialog(
          Text('${unKnownKangis.length}가 남아 있습니다.'),
          const Text('모르는 단어를 다시 보시겠습니까?'),
        );

        if (alertResult!) {
          Get.closeAllSnackbars();
          unKnownKangis.shuffle();
          kangiStep.unKnownKangis = unKnownKangis;
          kangiController.updateScore(correctCount);
          Get.offNamed(WORD_STUDY_PATH,
              arguments: {'againTest': true}, preventDuplicates: false);
        } else {
          Get.closeAllSnackbars();
          kangiStep.unKnownKangis = [];
          kangiController.updateScore(correctCount);
          Get.back();
        }

        return;
      } else {
        // 모르는 단어가 없는 경우
        kangiStep.unKnownKangis = [];
        isAgainTest = true;
        kangiController.updateScore(correctCount);
        Get.back();
        return;
      }
    } else {}

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
          arguments: {'kangis': kangiStep.kangis, 'alertResult': alertResult});
    }
  }
}

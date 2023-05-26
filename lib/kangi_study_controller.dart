import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/controller/kangi_controller.dart';
import 'package:japanese_voca/kangi_study_sceen.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/kangi_step.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/screen/quiz/quiz_screen.dart';

class KangiStudyController extends GetxController {
  KangiStudyController({this.isAgainTest});

  KangiController kangiController = Get.find<KangiController>();
  late PageController pageController;

  late KangiStep kangiStep;
  int currentIndex = 0;
  int correctCount = 0;

  bool? isAgainTest;

  List<Kangi> unKnownKangis = [];
  List<Kangi> kangis = [];

  bool isShownUndoc = false;
  bool isShownHundoc = false;
  bool isShownKorea = false;

  void showUndoc() {
    isShownUndoc = !isShownUndoc;
    update();
  }

  void showHundoc() {
    isShownHundoc = !isShownHundoc;
    update();
  }

  void showYomikata() {
    isShownKorea = !isShownKorea;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    kangiStep = kangiController.getKangiStep();

    if (kangiStep.unKnownKangis.isNotEmpty) {
      kangis = kangiStep.unKnownKangis;
      print('kangis: ${kangis}');
    } else {
      kangis = kangiStep.kangis;
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
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

  void onPageChanged(int page) {
    currentIndex = page;
    update();
  }

  void nextWord(bool isWordKnwon) async {
    print('nextWord');

    isShownUndoc = false;
    isShownHundoc = false;
    isShownKorea = false;

    Kangi currentWord = kangis[currentIndex];

    if (isWordKnwon == false) {
      Get.closeCurrentSnackbar();
      unKnownKangis.add(currentWord);
      // TODO
      // MyWord.saveToMyVoca(currentWord);
    } else {
      correctCount++;
    }
    currentIndex++;
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
    if (currentIndex >= kangis.length) {
      if (unKnownKangis.isNotEmpty) {
        if (isAgainTest != null) {
          // 테스트 두번째
          final testType = await getAlertDialog(
              Text('${unKnownKangis.length}가 남아 있습니다.'),
              const Text('테스트 페이지로 넘어가시겠습니까?'),
              barrierDismissible: true);
          if (testType != null) {
            if (testType) {
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
        } else {
          // 첫번째 두번째
          final alertResult = await getAlertDialog(
            Text('${unKnownKangis.length}가 남아 있습니다.'),
            const Text('모르는 단어를 다시 보시겠습니까?'),
          );

          if (alertResult!) {
            bool isAutoSave = LocalReposotiry.getAutoSave();
            Get.closeAllSnackbars();
            unKnownKangis.shuffle();
            kangiStep.unKnownKangis = unKnownKangis;
            kangiController.updateScore(correctCount);
            Get.offNamed(KANGI_STUDY_PATH,
                arguments: {'againTest': true, 'isAutoSave': isAutoSave},
                preventDuplicates: false);
          } else {
            Get.closeAllSnackbars();
            kangiStep.unKnownKangis = [];
            kangiController.updateScore(correctCount);
            Get.back();
          }

          return;
        }
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
    bool? testType = await getTransparentAlertDialog(
      contentChildren: [
        CustomButton(text: '의미', onTap: () => Get.back(result: true)),
        CustomButton(text: '읽는 법', onTap: () => Get.back(result: false)),
      ],
    );

    if (testType != null) {
      Get.toNamed(QUIZ_PATH, arguments: {
        TEST_TYPE: testType,
        KANGI_TEST: kangiStep.kangis,
      });
    }
  }
}

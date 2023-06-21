import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/screen/jlpt_and_kangi/kangi/controller/kangi_step_controller.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/screen/jlpt_and_kangi/kangi/kangi_study/kangi_study_sceen.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/kangi_step.dart';
import 'package:japanese_voca/screen/jlpt_and_kangi/kangi/kangi_test/kangi_test_screen.dart';
import 'package:japanese_voca/screen/setting/services/setting_controller.dart';

import '../../../../../model/my_word.dart';
import '../../../../user/controller/user_controller.dart';
import '../../components/kangi_related_card.dart';

class KangiStudyController extends GetxController {
  KangiStudyController({this.isAgainTest});

  KangiStepController kangiController = Get.find<KangiStepController>();
  SettingController settingController = Get.find<SettingController>();
  UserController userController = Get.find<UserController>();

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
    print('asdasd');

    isShownKorea = !isShownKorea;
    update();
  }

  double getCurrentProgressValue() {
    return (currentIndex.toDouble() / kangis.length.toDouble()) * 100;
  }

  void saveCurrentWord() {
    Word currentWord = Word(
        word: kangis[currentIndex].japan,
        mean: kangis[currentIndex].korea,
        yomikata:
            '${kangis[currentIndex].undoc} / ${kangis[currentIndex].hundoc}',
        headTitle: '');

    userController.clickUnKnownButtonCount++;
    MyWord.saveToMyVoca(currentWord);
  }

  void clickRelatedKangi() {
    if (!userController.user.isPremieum) {
      userController.openPremiumDialog();
      return;
    }
    Get.dialog(AlertDialog(
      content: KangiRelatedCard(
        kangi: kangis[currentIndex],
      ),
    ));
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    kangiStep = kangiController.getKangiStep();

    if (kangiStep.unKnownKangis.isNotEmpty) {
      kangis = kangiStep.unKnownKangis;
    } else {
      kangis = kangiStep.kangis;
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int page) {
    currentIndex = page;
    update();
  }

  void nextWord(bool isWordKnwon) async {
    isShownUndoc = false;
    isShownHundoc = false;
    isShownKorea = false;

    Kangi currentKangi = kangis[currentIndex];

    // [알아요] 버튼 클릭 시
    if (isWordKnwon) {
      correctCount++;
    }
    // [몰라요] 버튼 클릭 시
    else {
      unKnownKangis.add(currentKangi);
      if (settingController.isAutoSave) {
        saveCurrentWord();
      }
    }

    currentIndex++;

    // 단어 학습 중. (남아 있는 단어 존재)
    if (currentIndex < kangis.length) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
    }

    // 단어 학습 완료. (남아 있는 단어 없음)

    else {
      // 전부 다 [알아요] 버튼을 눌렀는 지
      if (unKnownKangis.isEmpty) {
        kangiStep.unKnownKangis = []; // 남아 있을 모르는 단어 삭제.
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
        int unKnownWordLength = unKnownKangis.length > kangis.length
            ? kangis.length
            : unKnownKangis.length;

        bool result = await askToWatchMovieAndGetHeart(
          title: Text('${unKnownWordLength}개가 남아 있습니다.'),
          content: const Text(
            '모르는 단어를 다시 보시겠습니까?',
            style: TextStyle(color: AppColors.scaffoldBackground),
          ),
        );

        // 몰라요 단어 다시 학습.
        if (result) {
          unKnownKangis.shuffle();

          currentIndex = 0; // 화면 에러 방지
          kangiStep.unKnownKangis = unKnownKangis;
          Get.offNamed(
            KANGI_STUDY_PATH,
            preventDuplicates: false,
          );
        } else {
          Get.closeAllSnackbars();
          kangiStep.unKnownKangis = [];
          Get.back();
          return;
        }
      }
    }
    update();
    return;
  }

  Future<void> goToTest() async {
    if (kangiStep.wrongQuestion != null && kangiStep.scores != 0) {
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
          KANGI_TEST_PATH,
          arguments: {
            CONTINUTE_KANGI_TEST: kangiStep.wrongQuestion,
          },
        );
        return;
      }
    }
    Get.toNamed(
      KANGI_TEST_PATH,
      arguments: {
        KANGI_TEST: kangiStep.kangis,
      },
    );
  }
}

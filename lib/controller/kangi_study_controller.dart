import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/ad_controller.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/controller/kangi_controller.dart';
import 'package:japanese_voca/screen/kangi/kangi_study_sceen.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/kangi_step.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/screen/kangi/kangi_quiz/kangi_quiz_screen.dart';

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
      // MyWord.saveToMyVoca(currentWord);
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
          title: Text('${unKnownKangis.length}가 남아 있습니다.'),
          content: const Text('모르는 단어를 다시 보시겠습니까?'),
        );

        // 몰라요 단어 다시 학습.
        if (result) {
          bool isAutoSave = LocalReposotiry.getAutoSave();

          unKnownKangis.shuffle();

          currentIndex = 0; // 화면 에러 방지
          kangiStep.unKnownKangis = unKnownKangis;
          Get.offNamed(
            KANGI_STUDY_PATH,
            arguments: {'isAutoSave': isAutoSave},
            preventDuplicates: false,
          );
        } else {
          Get.closeAllSnackbars();
          kangiStep.unKnownKangis = [];
          Get.back();
        }
      }
    }
    update();
    return;
  }

  Future<void> goToTest() async {
    Get.toNamed(
      KANGI_QUIZ_PATH,
      arguments: {
        KANGI_TEST: kangiStep.kangis,
      },
    );
  }
}
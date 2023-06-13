import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/controller/user_controller.dart';

import '../../../common/admob/banner_ad/banner_ad_controller.dart';
import '../../../common/common.dart';
import '../../../config/colors.dart';
import '../../../repository/grammar_step_repository.dart';
import '../../../repository/jlpt_step_repository.dart';
import '../../../repository/kangis_step_repository.dart';
import '../../../repository/local_repository.dart';
import '../../../repository/my_word_repository.dart';

class SettingController extends GetxController {
  bool isAutoSave = LocalReposotiry.getAutoSave();
  // bool isQuesetionMark = LocalReposotiry.getquestionMark();
  bool isTestKeyBoard = LocalReposotiry.getTestKeyBoard();

  bool toggleAutoSave() {
    isAutoSave = !isAutoSave;
    LocalReposotiry.autoSaveOnOff();
    update();
    return isAutoSave;
  }

  UserController userController = Get.find<UserController>();
  late BannerAdController? adController;

  @override
  void onInit() {
    super.onInit();

    if (!userController.isUserPremieum()) {
      adController = Get.find<BannerAdController>();
      if (!adController!.loadingSettingBanner) {
        adController!.loadingSettingBanner = true;
        adController!.createSettingBanner();
      }
    }
  }

  void flipAutoSave() {
    if (userController.user.isPremieum) {
      isAutoSave = toggleAutoSave();
    } else {
      userController.openPremiumDialog();
    }
  }

  void flipTestKeyBoard() {
    isTestKeyBoard = toggleTestKeyBoard();
  }

  bool toggleTestKeyBoard() {
    isTestKeyBoard = !isTestKeyBoard;
    LocalReposotiry.testKeyBoardOnfOFF();
    update();
    return isTestKeyBoard;
  }

  Future<void> initJlptWord() async {
    bool result = await askToWatchMovieAndGetHeart(
        title: const Text('Jlpt 단어를 초기화 하시겠습니까 ?'),
        content: const Text(
          '점수들도 함께 사라집니다. 그래도 진행하시겠습니까?',
          style: TextStyle(
            color: AppColors.scaffoldBackground,
          ),
        ));
    if (result) {
      userController.initializeProgress(TotalProgressType.JLPT);
      JlptStepRepositroy.deleteAllWord();
      Get.closeAllSnackbars();
      Get.snackbar(
        '초기화 완료!',
        '앱을 재시작 해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.whiteGrey.withOpacity(0.5),
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> initGrammar() async {
    bool result = await askToWatchMovieAndGetHeart(
        title: const Text('문법을 초기화 하시겠습니까 ?'),
        content: const Text(
          '점수들도 함께 사라집니다. 그래도 진행하시겠습니까?',
          style: TextStyle(
            color: AppColors.scaffoldBackground,
          ),
        ));

    if (result) {
      userController.initializeProgress(TotalProgressType.GRAMMAR);
      GrammarRepositroy.deleteAllGrammar();
      Get.closeAllSnackbars();
      Get.snackbar(
        '초기화 완료!',
        '앱을 재시작 해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.whiteGrey.withOpacity(0.5),
        animationDuration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> initkangi() async {
    bool result = await askToWatchMovieAndGetHeart(
        title: const Text('한자을 초기화 하시겠습니까 ?'),
        content: const Text(
          '점수들도 함께 사라집니다. 그래도 진행하시겠습니까?',
          style: TextStyle(
            color: AppColors.scaffoldBackground,
          ),
        ));

    if (result) {
      userController.initializeProgress(TotalProgressType.KANGI);
      KangiStepRepositroy.deleteAllKangiStep();
      Get.closeAllSnackbars();
      Get.snackbar(
        '초기화 완료!',
        '앱을 재시작 해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.whiteGrey.withOpacity(0.5),
        animationDuration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> initMyWords() async {
    bool result = await askToWatchMovieAndGetHeart(
      title: const Text('나만의 단어를 초기화 하시겠습니까 ?'),
      content: const Text(
        '되돌릴 수 없습니다, 그래도 진행하시겠습니까?',
        style: TextStyle(
          color: AppColors.scaffoldBackground,
        ),
      ),
    );

    if (result) {
      MyWordRepository.deleteAllMyWord();

      Get.closeAllSnackbars();
      Get.snackbar(
        '초기화 완료!',
        '앱을 재시작 해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.whiteGrey.withOpacity(0.5),
        animationDuration: const Duration(seconds: 2),
      );
    }
  }

  void showAgainAppDescription() async {
    bool result = await askToWatchMovieAndGetHeart(
        title: const Text('앱 설명을 다시 보시겠습니까?'), content: const Text(''));

    if (result) {
      LocalReposotiry.isSeenGrammarTutorial(isRestart: true);
      LocalReposotiry.isSeenHomeTutorial(isRestart: true);
      LocalReposotiry.isSeenMyWordTutorial(isRestart: true);
      LocalReposotiry.isSeenWordStudyTutorialTutorial(isRestart: true);

      Get.snackbar(
        '앱 설명 완료!',
        '앱을 재시작 해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.whiteGrey.withOpacity(0.5),
        animationDuration: const Duration(seconds: 2),
      );
    }
  }
}

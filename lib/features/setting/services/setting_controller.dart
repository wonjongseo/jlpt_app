import 'dart:async';
import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/app_constant.dart';
import 'package:japanese_voca/common/commonDialog.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

import '../../../common/common.dart';
import '../../../config/colors.dart';
import '../../../repository/grammar_step_repository.dart';
import '../../../repository/jlpt_step_repository.dart';
import '../../../repository/kangis_step_repository.dart';
import '../../../repository/local_repository.dart';
import '../../../repository/my_word_repository.dart';

class SettingController extends GetxController {
  bool isTestKeyBoard = LocalReposotiry.getTestKeyBoard();
  // 초기화 버튼을 눌렀는가
  bool isInitial = false;

  UserController userController = Get.find<UserController>();

  void flipTestKeyBoard() {
    isTestKeyBoard = toggleTestKeyBoard();
  }

  bool toggleTestKeyBoard() {
    isTestKeyBoard = !isTestKeyBoard;
    LocalReposotiry.testKeyBoardOnfOFF();
    update();
    return isTestKeyBoard;
  }

  void successDeleteAndQuitApp() {
    Get.closeAllSnackbars();
    Get.snackbar(
      '초기화 완료, 재실행 해주세요!',
      '3초 뒤 자동적으로 앱이 종료됩니다.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.whiteGrey.withOpacity(0.7),
      duration: const Duration(seconds: 4),
      animationDuration: const Duration(seconds: 2),
    );
    Future.delayed(const Duration(seconds: 4), () {
      if (kReleaseMode) {
        exit(0);
      }
    });
  }

  Future<bool> initJlptWord() async {
    bool result = await CommonDialog.askBeforeDeleteDatasDialog('JLPT 단어를');

    if (result) {
      isInitial = true;
      userController.initializeProgress(TotalProgressType.JLPT);
      JlptStepRepositroy.deleteAllWord();
    }
    return result;
  }

  Future<bool> initGrammar() async {
    bool result = await CommonDialog.askBeforeDeleteDatasDialog('JLPT 문법을');

    if (result) {
      isInitial = true;
      userController.initializeProgress(TotalProgressType.GRAMMAR);
      GrammarRepositroy.deleteAllGrammar();
    }
    return result;
  }

  Future<bool> initkangi() async {
    bool result = await CommonDialog.askBeforeDeleteDatasDialog('JLPT 한자를');

    if (result) {
      isInitial = true;
      userController.initializeProgress(TotalProgressType.KANGI);
      KangiStepRepositroy.deleteAllKangiStep();
    }
    return result;
  }

  Future<bool> initMyWords() async {
    bool result = await CommonDialog.askBeforeDeleteDatasDialog('나만의 단어를',
        message: '나만의 단어장1과 나만의 단어장2에 저장된 데이터가 제거 됩니다.\n그래도 진행하시겠습니까?');

    if (result) {
      isInitial = true;
      MyWordRepository.deleteAllMyWord();
    }
    return result;
  }

  void allDataDelete() {
    userController.initializeProgress(TotalProgressType.JLPT);
    JlptStepRepositroy.deleteAllWord();
    userController.initializeProgress(TotalProgressType.KANGI);
    KangiStepRepositroy.deleteAllKangiStep();
    userController.initializeProgress(TotalProgressType.GRAMMAR);
    GrammarRepositroy.deleteAllGrammar();
    successDeleteAndQuitApp();
  }
}

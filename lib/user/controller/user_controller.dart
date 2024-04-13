import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/network_manager.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/home/screens/home_screen.dart';
import 'package:japanese_voca/features/my_voca/screens/my_voca_sceen.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';
import 'package:japanese_voca/main.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/model/user.dart';
import 'package:japanese_voca/user/repository/user_repository.dart';
import 'package:japanese_voca/user/screen/hiden_screen.dart';

// ignore: constant_identifier_names

enum TotalProgressType { JLPT, GRAMMAR, KANGI }

enum SOUND_OPTIONS { VOLUMN, PITCH, RATE }

class UserController extends GetxController {
  late TextEditingController textEditingController;
  String selectedDropDownItem = 'japanese';
  List<Word>? searchedWords;
  bool isSearchReq = false;
  UserRepository userRepository = UserRepository();
  late User user;

  Future<void> sendQuery() async {
    searchedWords = null;
    isSearchReq = true;
    update();
    searchedWords = await JlptRepositry.searchWords(textEditingController.text);
    isSearchReq = false;
    update();
  }

  void changeuserPremieum(bool premieum) {
    user.isPremieum = premieum;
    userRepository.updateUser(user);
    update();
  }

  void changeDropDownButtonItme(String? v) {
    selectedDropDownItem = v!;
    update();
  }

  late double volumn;
  late double pitch;
  late double rate;

  int clickUnKnownButtonCount = 0;

  UserController() {
    user = userRepository.getUser();
    volumn = LocalReposotiry.getVolumn();
    pitch = LocalReposotiry.getPitch();
    rate = LocalReposotiry.getRate();
    textEditingController = TextEditingController();
  }

  void updateSoundValues(SOUND_OPTIONS command, double newValue) {
    if (newValue >= 1 && newValue <= 0) return;

    switch (command) {
      case SOUND_OPTIONS.VOLUMN:
        LocalReposotiry.updateVolumn(newValue);
        volumn = newValue;
        break;
      case SOUND_OPTIONS.PITCH:
        LocalReposotiry.updatePitch(newValue);
        pitch = newValue;
        break;
      case SOUND_OPTIONS.RATE:
        LocalReposotiry.updateRate(newValue);
        rate = newValue;
        break;
    }
    update();
  }

  void onChangedSoundValues(SOUND_OPTIONS command, double newValue) {
    switch (command) {
      case SOUND_OPTIONS.VOLUMN:
        volumn = newValue;
        break;
      case SOUND_OPTIONS.PITCH:
        pitch = newValue;
        break;
      case SOUND_OPTIONS.RATE:
        rate = newValue;
        break;
    }
    update();
  }

  void initializeProgress(TotalProgressType totalProgressType) {
    switch (totalProgressType) {
      case TotalProgressType.JLPT:
        for (int i = 0; i < user.currentJlptWordScroes.length; i++) {
          user.currentJlptWordScroes[i] = 0;
        }
        break;
      case TotalProgressType.GRAMMAR:
        for (int i = 0; i < user.currentGrammarScores.length; i++) {
          user.currentGrammarScores[i] = 0;
        }
        break;
      case TotalProgressType.KANGI:
        for (int i = 0; i < user.currentKangiScores.length; i++) {
          user.currentKangiScores[i] = 0;
        }
        break;
    }
    userRepository.updateUser(user);
  }

  void updateCurrentProgress(
      TotalProgressType totalProgressType, int index, int addScore) {
    switch (totalProgressType) {
      case TotalProgressType.JLPT:
        if (user.currentJlptWordScroes[index] + addScore >= 0) {
          if (user.currentJlptWordScroes[index] + addScore >
              user.jlptWordScroes[index]) {
            user.currentJlptWordScroes[index] = user.jlptWordScroes[index];
          } else {
            user.currentJlptWordScroes[index] += addScore;
          }
        }

        break;
      case TotalProgressType.GRAMMAR:
        if (user.currentGrammarScores[index] + addScore >= 0) {
          if (user.currentGrammarScores[index] + addScore >
              user.grammarScores[index]) {
            user.currentGrammarScores[index] = user.grammarScores[index];
          } else {
            user.currentGrammarScores[index] += addScore;
          }
        }

        break;
      case TotalProgressType.KANGI:
        if (user.currentKangiScores[index] + addScore >= 0) {
          if (user.currentKangiScores[index] + addScore >
              user.kangiScores[index]) {
            user.currentKangiScores[index] = user.kangiScores[index];
          } else {
            user.currentKangiScores[index] += addScore;
          }
        }

        break;
    }
    userRepository.updateUser(user);
    update();
  }

  void changeUserAuth() {
    Get.to(() => HidenScreen());
  }

  void updateMyWordSavedCount(bool isSaved,
      {bool isYokumatiageruWord = true, int count = 1}) {
    print('updateYokumatikageruWord');
    print('before');
    print('user.yokumatigaeruMyWords : ${user.yokumatigaeruMyWords}');

    if (isYokumatiageruWord) {
      if (isSaved) {
        user.yokumatigaeruMyWords += count;
        showGoToTheMyScreen();
      } else {
        user.yokumatigaeruMyWords -= count;
      }
      print('after');
      print('user.yokumatigaeruMyWords : ${user.yokumatigaeruMyWords}');

      print('=============');
    } else {
      if (isSaved) {
        user.manualSavedMyWords += count;
        // showGoToTheMyScreen();
      } else {
        user.manualSavedMyWords -= count;
      }
      print('after');
      print('user.manualSavedMyWords : ${user.manualSavedMyWords}');

      print('=============');
    }
    userRepository.updateUser(user);

    update();
  }

  void showGoToTheMyScreen() {
    int savedCount = user.yokumatigaeruMyWords;
    if (savedCount % 15 == 0) {
      Get.dialog(
        AlertDialog(
          shape: Border.all(width: 1, color: AppColors.mainBordColor),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('단어를 $savedCount개나 저장하셨습니다.'),
              SizedBox(height: Responsive.height10),
              const Text('저장한 단어를 학습하시겠습니까 ?'),
              TextButton(
                onPressed: () {
                  Get.offNamedUntil(
                    MY_VOCA_PATH,
                    arguments: {
                      MY_VOCA_TYPE: MyVocaEnum.YOKUMATIGAERU_WORD,
                    },
                    ModalRoute.withName(HOME_PATH),
                  );
                },
                child: Text(
                  '나만의 단어장 가기',
                  style: TextStyle(
                    color: AppColors.mainBordColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

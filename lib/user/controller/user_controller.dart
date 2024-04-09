import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/network_manager.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/model/user.dart';
import 'package:japanese_voca/user/repository/user_repository.dart';

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
    searchedWords = await NetWorkManager.searchWrod(
        textEditingController.text, selectedDropDownItem);
    isSearchReq = false;
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
}

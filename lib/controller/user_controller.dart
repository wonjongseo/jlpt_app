import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/model/user.dart';
import 'package:japanese_voca/repository/user_repository.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_function_description.dart';
import '../config/colors.dart';

// ignore: constant_identifier_names
enum TotalProgressType { JLPT, GRAMMAR, KANGI }

class UserController extends GetxController {
  UserRepository userRepository = UserRepository();
  late User user;

  UserController() {
    user = userRepository.getUser();
  }

  void plusHeart({int plusHeartCount = 1}) {
    if (user.heartCount + plusHeartCount > 30) return;
    user.heartCount += plusHeartCount;
    userRepository.updateUser(user);
    update();
  }

  Future<bool> useHeart() async {
    if (user.heartCount <= 0) {
      return false;
    }
    user.heartCount--;
    update();
    userRepository.updateUser(user);

    return true;
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
          user.currentJlptWordScroes[index] += addScore;
        }

        break;
      case TotalProgressType.GRAMMAR:
        if (user.currentGrammarScores[index] + addScore >= 0) {
          user.currentGrammarScores[index] += addScore;
        }

        break;
      case TotalProgressType.KANGI:
        if (user.currentKangiScores[index] + addScore >= 0) {
          user.currentKangiScores[index] += addScore;
        }

        break;
    }
    userRepository.updateUser(user);
    update();
  }

  void openPremiumDialog() {
    Get.dialog(AlertDialog(
      title: const Text(
        '해당 기능은 유료 버전에서 사용할 수 있습니다.',
        style: TextStyle(
          color: AppColors.scaffoldBackground,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(
            premiumBenefitText.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '기능${index + 1}. ${premiumBenefitText[index]}',
                style: const TextStyle(
                  color: AppColors.scaffoldBackground,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  // launchUrl(Uri.parse('https://wonjongseo.netlify.app/#/'));
                  Get.dialog(AlertDialog(
                    title: const Text(
                      '아직 유료버전이 준비 되어 있지 않습니다.',
                      style: TextStyle(
                        color: AppColors.scaffoldBackground,
                        fontSize: 12,
                      ),
                    ),
                  ));
                },
                child: const Text('유료버전 다운로드 하러 가기.')),
          )
        ],
      ),
    ));
  }
}

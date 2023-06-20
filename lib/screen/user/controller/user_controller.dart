import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/model/user.dart';
import 'package:japanese_voca/screen/user/repository/user_repository.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app_function_description.dart';
import '../../../config/colors.dart';

// ignore: constant_identifier_names
const int HERAT_COUNT_AD = 3;
const int HERAT_COUNT_DEFAULT = 1;
const int HERAT_COUNT_MAX = 30;
const int RESTRICT_SUB_STEP_NUM = 3;

enum TotalProgressType { JLPT, GRAMMAR, KANGI }

class UserController extends GetxController {
  UserRepository userRepository = UserRepository();
  late User user;

  int clickUnKnownButtonCount = 0;

  UserController() {
    user = userRepository.getUser();
  }

  bool isUserPremieum() {
    return user.isPremieum;
  }

  void plusHeart({int plusHeartCount = HERAT_COUNT_DEFAULT}) {
    if (user.heartCount + plusHeartCount > HERAT_COUNT_MAX) return;
    user.heartCount += plusHeartCount;
    userRepository.updateUser(user);
    update();
  }

  Future<bool> useHeart() async {
    if (isUserPremieum()) {
      return true;
    }

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

  void openPremiumDialog({List<String>? messages}) {
    Get.dialog(AlertDialog(
      title: const Text(
        '해당 기능은 JLPT 종각 Plus 버전에서 사용할 수 있습니다.',
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
          if (messages != null)
            ...List.generate(
              messages.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '기능${index + premiumBenefitText.length + 1}. ${messages[index]}',
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: Dimentions.height60,
            child: ElevatedButton(
                onPressed: () {
                  if (GetPlatform.isIOS) {
                    launchUrl(
                        Uri.parse('https://apps.apple.com/app/id6450434849'));
                  } else if (GetPlatform.isAndroid) {
                    launchUrl(Uri.parse(
                        'https://play.google.com/store/apps/details?id=com.wonjongseo.jlpt_jonggack_plus'));
                  } else {
                    launchUrl(
                        Uri.parse('https://apps.apple.com/app/id6450434849'));
                  }
                },
                child: Text(
                  'Plus 버전 다운로드 하러 가기.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimentions.width16),
                )),
          )
        ],
      ),
    ));
  }
}

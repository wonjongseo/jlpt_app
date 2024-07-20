import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/home/screens/home_screen.dart';
import 'package:japanese_voca/features/setting/services/setting_controller.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeTutorialService {
  SettingController settingController = Get.find<SettingController>();
  GlobalKey searchKey = GlobalKey(debugLabel: 'searchKey');

  GlobalKey basicVocaKey = GlobalKey(debugLabel: 'basicVocaKey');
  GlobalKey jlptVocaKey = GlobalKey(debugLabel: 'jlptVocaKey');
  GlobalKey myVocaKey = GlobalKey(debugLabel: 'myVocaKey');

  GlobalKey settingKey = GlobalKey(debugLabel: 'settingKey');
  late PageController pageController;
  int index = 0;
  List<TargetFocus> targets = [];

  Future settingFunctions() async {
    bool isKeyBoardActive = await Get.dialog(
      AlertDialog(
        title: Text(
          '주관식 문제를 활성화 하시겠습니까?',
          style: TextStyle(
            fontSize: Responsive.height16,
          ),
        ),
        content: const Text(
          '테스트 중에는 읽는 법을 직접 입력하는 기능이 있습니다. 해당 기능을 활성화 하시겠습니까?',
        ),
        actions: [
          TextButton(
              onPressed: () => Get.back(result: true),
              child: Text(
                '네',
                style: TextStyle(
                  color: AppColors.mainColor,
                ),
              )),
          TextButton(
              onPressed: () => Get.back(result: false),
              child: Text(
                '아니요',
                style: TextStyle(
                  color: AppColors.mainColor,
                ),
              )),
        ],
      ),
    );

    if (isKeyBoardActive) {
      if (!settingController.isTestKeyBoard) {
        settingController.flipTestKeyBoard();
      }
    } else {
      if (settingController.isTestKeyBoard) {
        settingController.flipTestKeyBoard();
      }
    }

    Get.closeAllSnackbars();
    Get.snackbar(
      '초기 설정이 완료 되었습니다.',
      '해당 설정들은 설정 페이지에서 재설정 할 수 있습니다.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.whiteGrey.withOpacity(0.5),
      duration: const Duration(seconds: 4),
      animationDuration: const Duration(seconds: 2),
    );
  }

  initTutorial() {
    targets.addAll([
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "searchKey",
        keyTarget: searchKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: const TutorialMessage(
              headTitle: '단어 검색',
              message: 'JLPT종각 앱에 저장된 단어를 검색할 수 있습니다.',
            ),
          ),
        ],
      ),
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "basicVocaKey",
        keyTarget: basicVocaKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: const TutorialMessage(
              headTitle: '왕초보 단어장',
              message:
                  '이 단어장은 일본어 입문자가 JLPT 준비에 앞서 히라가나와 가타카나를 학습할 수 있도록 도와줍니다.',
            ),
          ),
        ],
      ),
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "jlptVocaKey",
        keyTarget: jlptVocaKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: const TutorialMessage(
              headTitle: 'JLPT 단어장',
              message: '이 단어장은 N5부터 N1까지의 일본어를 학습할 수 있도록 도와줍니다.',
            ),
          ),
        ],
      ),
      TargetFocus(
        shape: ShapeLightFocus.RRect,
        identify: "myVocaKey",
        keyTarget: myVocaKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: const TutorialMessage(
              headTitle: '나만의 단어장',
              message: '이 단어장은 직접 단어를 저장하여 학습할 수 있도록 도와줍니다.',
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "settingKey",
        keyTarget: settingKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: const TutorialMessage(
              headTitle: '설정',
              message: '소리의 음향 조절, 속절, 목소리 톤 등의 설정을 할 있습니다.',
            ),
          ),
        ],
      ),
    ]);
  }

  void showTutorial(BuildContext context) {
    TutorialCoachMark(
      alignSkip: Alignment.topLeft,
      onFinish: () async {
        await settingFunctions();

        Get.offNamed(HOME_PATH);
      },
      onSkip: () {
        settingFunctions();
        return true;
      },
      onClickTarget: (target) {
        if (target.identify == 'basicVocaKey') {
          index = 1;
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        }
        if (target.identify == 'jlptVocaKey') {
          index = 2;
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        }
      },

      textStyleSkip: const TextStyle(
          color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold),
      targets: targets, // List<TargetFocus>
    ).show(context: context);
  }
}

class TutorialMessage extends StatelessWidget {
  const TutorialMessage(
      {super.key, required this.headTitle, required this.message});

  final String headTitle;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Responsive.height15),
        Text(
          headTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: Responsive.height22,
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: message,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.height10 * 1.7),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/**
TargetFocus(
        identify: "myVocaKey",
        keyTarget: myVocaKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '나만의 단어장',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22.0),
                ),
                const Text.rich(
                  TextSpan(
                    text: '1. ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                          text: '직접',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                      TextSpan(text: ' 일본어 단어를 '),
                      TextSpan(
                          text: '저장',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                      TextSpan(text: '하여 학습 할 수 있습니다.')
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text.rich(
                  TextSpan(
                    text: '2. ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                          text: 'Excel 파일',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                      TextSpan(text: '을 이용해 나만의 단어를 관리 및 학습 할 수 있습니다.'),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.height20),
              ],
            ),
          ),
        ],
      ),
 */
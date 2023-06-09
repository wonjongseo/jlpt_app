import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_contrainer.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_controller.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/repository/grammar_step_repository.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';
import 'package:japanese_voca/user_controller2.dart';

import '../../controller/setting_controller.dart';
import '../../repository/local_repository.dart';
import 'components/setting_button.dart';
import 'components/setting_switch.dart';

const SETTING_PATH = '/setting';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  // bool isAutoSave = LocalReposotiry.getAutoSave();

  @override
  Widget build(BuildContext context) {
    BannerAdController adController = Get.find<BannerAdController>();
    UserController2 userController2 = Get.find<UserController2>();
    if (!adController.loadingSettingBanner) {
      adController.loadingSettingBanner = true;
      adController.createSettingBanner();
    }
    return Scaffold(
      appBar: _appBar(),
      body: _body(userController2),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  SingleChildScrollView _body(UserController2 userController2) {
    return SingleChildScrollView(
      child: Center(
        child: GetBuilder<SettingController>(builder: (settingController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SettingSwitch(
                isOn: settingController.isAutoSave,
                onChanged: (value) {
                  if (userController2.user.isPremieum) {
                    settingController.isAutoSave =
                        settingController.toggleAutoSave();
                  } else {
                    userController2.openPremiumDialog();
                  }

                  // setState(() {});
                },
                text: '모름 / 틀림 단어 자동 저장',
              ),
              SettingSwitch(
                isOn: settingController.isQuesetionMark,
                onChanged: (value) {
                  settingController.isQuesetionMark =
                      settingController.toggleQuesetionMark();
                  Get.closeAllSnackbars();
                  // setState(() {});
                },
                text: '의미 / 읽는법 글자수 표시',
              ),
              SettingSwitch(
                isOn: settingController.isTestKeyBoard,
                onChanged: (value) {
                  settingController.isTestKeyBoard =
                      settingController.settingController();
                  Get.closeAllSnackbars();
                  // setState(() {});
                },
                text: 'JLPT 퀴즈 읽는 법 키보드 표시',
              ),
              SettingButton(
                onPressed: () async {
                  bool result = await askToWatchMovieAndGetHeart(
                      title: const Text('Jlpt 단어를 초기화 하시겠습니까 ?'),
                      content: const Text(
                        '점수들도 함께 사라집니다. 그래도 진행하시겠습니까?',
                        style: TextStyle(
                          color: AppColors.scaffoldBackground,
                        ),
                      ));
                  if (result) {
                    JlptStepRepositroy.deleteAllWord();
                    Get.closeAllSnackbars();
                    Get.snackbar(
                      '초기화 완료!',
                      '앱을 재시작 해주세요.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.white.withOpacity(0.5),
                      duration: const Duration(seconds: 2),
                      animationDuration: const Duration(seconds: 2),
                    );
                  }
                },
                text: 'Jlpt 초기화 (단어 섞기)',
              ),
              SettingButton(
                onPressed: () async {
                  bool result = await askToWatchMovieAndGetHeart(
                      title: const Text('문법을 초기화 하시겠습니까 ?'),
                      content: const Text(
                        '점수들도 함께 사라집니다. 그래도 진행하시겠습니까?',
                        style: TextStyle(
                          color: AppColors.scaffoldBackground,
                        ),
                      ));

                  if (result) {
                    GrammarRepositroy.deleteAllGrammar();
                    Get.closeAllSnackbars();
                    Get.snackbar(
                      '초기화 완료!',
                      '앱을 재시작 해주세요.',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.white.withOpacity(0.5),
                      animationDuration: const Duration(seconds: 2),
                    );
                  }
                },
                text: '문법 초기화 (문법 섞기)',
              ),
              SettingButton(
                onPressed: () async {
                  bool result = await askToWatchMovieAndGetHeart(
                      title: const Text('한자을 초기화 하시겠습니까 ?'),
                      content: const Text(
                        '점수들도 함께 사라집니다. 그래도 진행하시겠습니까?',
                        style: TextStyle(
                          color: AppColors.scaffoldBackground,
                        ),
                      ));

                  if (result) {
                    KangiStepRepositroy.deleteAllKangiStep();
                    Get.closeAllSnackbars();
                    Get.snackbar(
                      '초기화 완료!',
                      '앱을 재시작 해주세요.',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.white.withOpacity(0.5),
                      animationDuration: const Duration(seconds: 2),
                    );
                  }
                },
                text: '한자 초기화 (한자 섞기)',
              ),
              SettingButton(
                text: '나만의 단어 초기화',
                onPressed: () async {
                  bool result = await askToWatchMovieAndGetHeart(
                      title: const Text('나만의 단어를 초기화 하시겠습니까 ?'),
                      content: const Text(
                        '되돌릴 수 없습니다, 그래도 진행하시겠습니까?',
                        style: TextStyle(
                          color: AppColors.scaffoldBackground,
                        ),
                      ));

                  if (result) {
                    MyWordRepository.deleteAllMyWord();

                    Get.closeAllSnackbars();
                    Get.snackbar(
                      '초기화 완료!',
                      '앱을 재시작 해주세요.',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.white.withOpacity(0.5),
                      animationDuration: const Duration(seconds: 2),
                    );
                  }
                },
              ),
              const SizedBox(height: 5),
              SettingButton(
                text: '앱 설명 보기',
                onPressed: () async {
                  bool result = await askToWatchMovieAndGetHeart(
                      title: const Text('앱 설명을 다시 보시겠습니까?'),
                      content: const Text(''));

                  if (result) {
                    LocalReposotiry.isSeenGrammarTutorial(isRestart: true);
                    LocalReposotiry.isSeenHomeTutorial(isRestart: true);
                    LocalReposotiry.isSeenMyWordTutorial(isRestart: true);
                    LocalReposotiry.isSeenWordStudyTutorialTutorial(
                        isRestart: true);

                    Get.snackbar(
                      '앱 설명 완료!',
                      '앱을 재시작 해주세요.',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.white.withOpacity(0.5),
                      animationDuration: const Duration(seconds: 2),
                    );
                  }
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('설정'),
      elevation: 0,
      leading: const BackButton(color: Colors.white),
    );
  }

  GetBuilder<BannerAdController> _bottomNavigationBar() {
    return GetBuilder<BannerAdController>(
      builder: (controller) {
        return BannerContainer(bannerAd: controller.settingBanner);
      },
    );
  }
}

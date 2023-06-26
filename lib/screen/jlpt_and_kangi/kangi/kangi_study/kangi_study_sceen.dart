import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/screen/jlpt_and_kangi/kangi/kangi_study/controller/kangi_study_controller.dart';
import 'package:japanese_voca/screen/jlpt_and_kangi/kangi/kangi_study/kangi_study_buttons_temp.dart';

import '../../../../common/admob/banner_ad/global_banner_admob.dart';
import '../../../../common/common.dart';
import '../../../../common/widget/app_bar_progress_bar.dart';
import '../../../../config/theme.dart';
import '../../../setting/services/setting_controller.dart';
import '../../../user/controller/user_controller.dart';
import 'kangi_button.dart';

final String KANGI_STUDY_PATH = '/kangi_study';
final String IS_TEST_AGAIN = 'isTestAgain';

// ignore: must_be_immutable
class KangiStudySceen extends StatelessWidget {
  KangiStudySceen({super.key}) {
    if (Get.arguments != null && Get.arguments[IS_TEST_AGAIN] != null) {
      kangiStudyController = Get.put(KangiStudyController());
    } else {
      kangiStudyController = Get.put(KangiStudyController());
    }
  }
  // UserController userController = Get.find<UserController>();
  late KangiStudyController kangiStudyController;
  SettingController settingController = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<KangiStudyController>(builder: (controller) {
      double currentValue = controller.getCurrentProgressValue();

      return Scaffold(
        appBar: _appBar(size, currentValue, controller),
        body: _body(controller),
        bottomNavigationBar: const GlobalBannerAdmob(),
      );
    });
  }

  Widget _body(KangiStudyController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Stack(
              children: [
                if (!settingController.isAutoSave)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: OutlinedButton(
                      onPressed: () {
                        controller.saveCurrentWord();
                      },
                      child: const Text(
                        '저장',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteGrey,
                        ),
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: OutlinedButton(
                    onPressed: () {
                      controller.openDialogForWritingOrder();
                    },
                    child: const Text(
                      '획순',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteGrey,
                      ),
                    ),
                  ),
                ),
                if (controller.kangis.length >= 4)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: OutlinedButton(
                      onPressed: () async {
                        bool result = await askToWatchMovieAndGetHeart(
                          title: const Text('점수를 기록하고 하트를 채워요!'),
                          content: const Text(
                            '테스트 페이지로 넘어가시겠습니까?',
                            style:
                                TextStyle(color: AppColors.scaffoldBackground),
                          ),
                        );

                        if (result) {
                          controller.goToTest();
                        }
                      },
                      child: const Text(
                        '시험',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteGrey,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.kangis.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ZoomIn(
                    duration: const Duration(milliseconds: 300),
                    animate: controller.isShownKorea,
                    child: Text(
                      controller.kangis[index].korea,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimentions.height20,
                            color: controller.isShownKorea
                                ? Colors.white
                                : Colors.transparent,
                          ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      kangiStudyController.clickRelatedKangi();
                    },
                    child: Text(
                      controller.kangis[index].japan,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimentions.height60,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        fontFamily: AppFonts.japaneseFont,
                        decorationColor: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              '음독 :  ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimentions.height20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '훈독 :  ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimentions.height20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ZoomIn(
                              animate: controller.isShownUndoc,
                              duration: const Duration(milliseconds: 300),
                              child: Text(
                                controller.kangis[index].undoc,
                                style: TextStyle(
                                  fontSize: Dimentions.height20,
                                  fontWeight: FontWeight.w700,
                                  color: controller.isShownUndoc
                                      ? Colors.white
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                            ZoomIn(
                              animate: controller.isShownHundoc,
                              duration: const Duration(milliseconds: 300),
                              child: Text(
                                controller.kangis[index].hundoc,
                                style: TextStyle(
                                  fontSize: Dimentions.height20,
                                  fontWeight: FontWeight.w700,
                                  color: controller.isShownHundoc
                                      ? Colors.white
                                      : Colors.transparent,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const Expanded(
          flex: 4,
          child: KangiStudyButtonsTemp(),
        ),
        const Spacer(flex: 2),
      ],
    );
  }

  AppBar _appBar(
      Size size, double currentValue, KangiStudyController controller) {
    return AppBar(
      title: AppBarProgressBar(
        size: size,
        currentValue: currentValue,
      ),
    );
  }
}

class KangiStudyButtons extends StatelessWidget {
  const KangiStudyButtons({super.key});

  @override
  Widget build(BuildContext context) {
    double buttonWidth = 130;
    double buttonHeight = 50;

    return GetBuilder<KangiStudyController>(builder: (controller) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZoomOut(
                animate: controller.isShownKorea,
                child: KangiButton(
                  text: '한자',
                  width: buttonWidth / 1.3,
                  height: buttonHeight,
                  onTap: controller.showYomikata,
                ),
              ),
              SizedBox(width: Dimentions.width10),
              ZoomOut(
                animate: controller.isShownUndoc,
                duration: const Duration(milliseconds: 300),
                child: KangiButton(
                  text: '음독',
                  // width: buttonWidth,
                  height: buttonHeight,
                  onTap: controller.showUndoc,
                ),
              ),
              SizedBox(width: Dimentions.width10),
              ZoomOut(
                animate: controller.isShownHundoc,
                child: KangiButton(
                  text: '훈독',
                  // width: buttonWidth,
                  height: buttonHeight,
                  onTap: controller.showHundoc,
                ),
              ),
            ],
          ),
          SizedBox(height: Dimentions.height10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KangiButton(
                text: '몰라요',
                width: buttonWidth,
                height: buttonHeight,
                onTap: () => controller.nextWord(false),
              ),
              SizedBox(width: Dimentions.width10),
              KangiButton(
                width: buttonWidth,
                height: buttonHeight,
                text: '알아요',
                onTap: () => controller.nextWord(true),
              ),
            ],
          ),
        ],
      );
    });
  }
}

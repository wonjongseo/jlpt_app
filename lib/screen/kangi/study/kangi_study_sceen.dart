import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:japanese_voca/common/admob/banner_ad/banner_ad_contrainer.dart';
import 'package:japanese_voca/controller/kangi_controller.dart';
import 'package:japanese_voca/controller/kangi_study_controller.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/screen/kangi/components/kangi_related_card.dart';

import '../../../common/admob/banner_ad/banner_ad_controller.dart';
import '../../../common/widget/app_bar_progress_bar.dart';
import '../../../config/theme.dart';
import '../../../controller/setting_controller.dart';
import '../../../controller/user_controller.dart';
import 'kangi_button.dart';

final String KANGI_STUDY_PATH = '/kangi_study';
final String IS_TEST_AGAIN = 'isTestAgain';

// ignore: must_be_immutable
class KangiStudySceen extends StatelessWidget {
  KangiStudySceen({super.key}) {
    if (Get.arguments != null && Get.arguments[IS_TEST_AGAIN] != null) {
      kangiStudyController = Get.put(KangiStudyController(isAgainTest: true));
    } else {
      kangiStudyController = Get.put(KangiStudyController());
    }
    if (!userController.user.isPremieum) {
      adController = Get.find<BannerAdController>();
      if (kangiStudyController.isAgainTest == false &&
          !adController!.loadingStudyBanner) {
        adController!.loadingStudyBanner = true;
        adController!.createStudyBanner();
      }
    }
  }
  UserController userController = Get.find<UserController>();
  late KangiStudyController kangiStudyController;
  late BannerAdController? adController;
  SettingController settingController = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<KangiStudyController>(builder: (controller) {
      double currentValue = controller.getCurrentProgressValue();

      return Scaffold(
        floatingActionButton: _floatingActionButton(controller),
        appBar: _appBar(size, currentValue, controller),
        body: _body(controller),
        bottomNavigationBar: _bottomNavigationBar(),
      );
    });
  }

  FloatingActionButton? _floatingActionButton(KangiStudyController controller) {
    if (controller.kangis.length >= 4) {
      return FloatingActionButton.extended(
          onPressed: () async {
            await controller.goToTest();
          },
          label: const Text(
            '시험 보기',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ));
    } else {
      return null;
    }
  }

  Column _body(KangiStudyController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!settingController.isAutoSave)
                IconButton(
                  onPressed: () => controller.saveCurrentWord(),
                  icon: const Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          flex: 8,
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
                            fontSize: 20,
                            color: controller.isShownKorea
                                ? Colors.white
                                : Colors.transparent,
                          ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      if (!userController.user.isPremieum) {
                        userController.openPremiumDialog();
                        return;
                      }
                      Get.dialog(AlertDialog(
                        content: KangiRelatedCard(
                          kangi: controller.kangis[controller.currentIndex],
                        ),
                      ));
                    },
                    child: Text(
                      controller.kangis[index].japan,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 65,
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
                        const Column(
                          children: [
                            Text(
                              '음독 :  ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '훈독 :  ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
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
                                  fontSize: 18,
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
                                  fontSize: 18,
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
        Expanded(
          flex: 3,
          child: KangiStudyButtons(),
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

  GetBuilder<BannerAdController> _bottomNavigationBar() {
    return GetBuilder<BannerAdController>(builder: (controller) {
      return BannerContainer(bannerAd: controller.studyBanner);
    });
  }
}

class KangiStudyButtons extends StatelessWidget {
  const KangiStudyButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double buttonWidth = 130;
    double buttonHeight = 50;

    KangiStudyController controller = Get.find<KangiStudyController>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ZoomOut(
              animate: controller.isShownKorea,
              child: KangiButton(
                text: '한자',
                // width: buttonWidth / 1.3,
                height: buttonHeight,
                onTap: controller.showYomikata,
              ),
            ),
            const SizedBox(width: 10),
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
            const SizedBox(width: 10),
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
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KangiButton(
              text: '몰라요',
              width: buttonWidth,
              height: buttonHeight,
              onTap: () => controller.nextWord(false),
            ),
            const SizedBox(width: 10),
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
  }
}

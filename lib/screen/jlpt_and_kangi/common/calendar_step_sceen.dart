import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/widget/calendar_card.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/screen/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/screen/jlpt_and_kangi/kangi/controller/kangi_step_controller.dart';
import 'package:japanese_voca/screen/jlpt_and_kangi/jlpt/jlpt_study/jlpt_study_tutorial_sceen.dart';
import 'package:japanese_voca/screen/jlpt_and_kangi/jlpt/jlpt_study/jlpt_study_sceen.dart';
import 'package:japanese_voca/screen/user/controller/user_controller.dart';

import '../../../common/widget/heart_count.dart';
import '../../../common/repository/local_repository.dart';
import '../../listen_controller.dart';
import '../../listen_page.dart';

const String JLPT_CALENDAR_STEP_PATH = '/jlpt-calendar-step';

// ignore: must_be_immutable
class CalendarStepSceen extends StatelessWidget {
  late JlptStepController jlptWordController;
  late KangiStepController kangiController;
  late String chapter;
  late bool isSeenTutorial;
  late bool isJlpt;
  UserController userController = Get.find<UserController>();

  CalendarStepSceen({super.key}) {
    isJlpt = Get.arguments['isJlpt'];
    if (isJlpt) {
      jlptWordController = Get.find<JlptStepController>();

      chapter = Get.arguments['chapter'];
      jlptWordController.setJlptSteps(chapter);
      isSeenTutorial = LocalReposotiry.isSeenWordStudyTutorialTutorial();
    } else {
      kangiController = Get.find<KangiStepController>();
      chapter = Get.arguments['chapter'];
      kangiController.setKangiSteps(chapter);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isJlpt) {
      return Scaffold(
        bottomNavigationBar: const GlobalBannerAdmob(),
        appBar: AppBar(
          title: Text('N${jlptWordController.level}급 단어 - $chapter'),
          actions: const [HeartCount()],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: OutlinedButton(
                  onPressed: () {
                    Get.put(ListenController(chapter: chapter));
                    Get.to(() => WordListenScreen());
                  },
                  child: Text(
                    'N${jlptWordController.level}급 - $chapter 자동 듣기',
                    style: const TextStyle(
                      color: AppColors.whiteGrey,
                    ),
                  )),
            ),
            Expanded(
              child: GetBuilder<JlptStepController>(builder: (controller) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: controller.jlptSteps.length,
                  itemBuilder: (context, subStep) {
                    if (subStep == 0) {
                      return CalendarCard(
                        isAabled: true,
                        jlptStep: controller.jlptSteps[subStep],
                        onTap: () {
                          controller.setStep(subStep);
                          if (!isSeenTutorial) {
                            isSeenTutorial = true;
                            Get.to(
                              () => const JlptStudyTutorialSceen(),
                              transition: Transition.circularReveal,
                            );
                          } else {
                            Get.toNamed(JLPT_STUDY_PATH);
                          }
                        },
                      );
                    }

                    return CalendarCard(
                      isAabled: controller.userController.isUserFake() ||
                          (controller.jlptSteps[subStep - 1].isFinished ??
                              false),
                      jlptStep: controller.jlptSteps[subStep],
                      onTap: () {
                        // 무료버전일 경우.
                        if (!controller.restrictN1SubStep(subStep)) {
                          controller.goToStudyPage(subStep, isSeenTutorial);
                        }
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('N${kangiController.level}급 한자 - $chapter'),
        actions: const [HeartCount()],
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
      body: GetBuilder<KangiStepController>(builder: (controller) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: controller.kangiSteps.length,
          itemBuilder: (context, subStep) {
            if (subStep == 0) {
              return KangiCalendarCard(
                isAabled: true,
                kangiStep: controller.kangiSteps[subStep],
                onTap: () => kangiController.goToStudyPage(subStep),
              );
            }
            return KangiCalendarCard(
              isAabled: controller.kangiSteps[subStep - 1].isFinished ?? false,
              kangiStep: controller.kangiSteps[subStep],
              onTap: () {
                if (!kangiController.restrictN1SubStep(subStep)) {
                  kangiController.goToStudyPage(subStep);
                }
              },
            );
          },
        );
      }),
    );
  }
}

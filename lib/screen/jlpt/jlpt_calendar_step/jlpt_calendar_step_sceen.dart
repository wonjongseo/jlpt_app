import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/ad_controller.dart';
import 'package:japanese_voca/common/widget/calendar_card.dart';
import 'package:japanese_voca/controller/jlpt_word_controller.dart';
import 'package:japanese_voca/controller/kangi_controller.dart';
import 'package:japanese_voca/screen/kangi/study/kangi_study_sceen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/jlpt_study_tutorial_sceen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/jlpt_study_sceen.dart';

import '../../../common/admob/banner_ad/banner_ad_contrainer.dart';
import '../../../common/admob/banner_ad/banner_ad_controller.dart';
import '../../../common/widget/heart_count.dart';
import '../../../repository/local_repository.dart';

const String JLPT_CALENDAR_STEP_PATH = '/jlpt-calendar-step';

// ignore: must_be_immutable
class JlptCalendarStepSceen extends StatelessWidget {
  late JlptWordController jlptWordController;
  late KangiController kangiController;
  late String chapter;
  late bool isSeenTutorial;
  late bool isJlpt;

  AdController adController = Get.find<AdController>();
  BannerAdController bannerAdController = Get.find<BannerAdController>();

  JlptCalendarStepSceen({super.key}) {
    isJlpt = Get.arguments['isJlpt'];
    if (isJlpt) {
      jlptWordController = Get.find<JlptWordController>();
      chapter = Get.arguments['chapter'];
      jlptWordController.setJlptSteps(chapter);
      isSeenTutorial = LocalReposotiry.isSeenWordStudyTutorialTutorial();
    } else {
      kangiController = Get.find<KangiController>();
      chapter = Get.arguments['chapter'];
      kangiController.setKangiSteps(chapter);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!bannerAdController.loadingCalendartBanner) {
      bannerAdController.loadingCalendartBanner = true;
      bannerAdController.createCalendarBanner();
    }
    if (isJlpt) {
      return Scaffold(
        bottomNavigationBar: GetBuilder<BannerAdController>(
          builder: (controller) {
            return BannerContainer(bannerAd: controller.calendarBanner);
          },
        ),
        appBar: AppBar(
          title: Text(chapter),
          leading: const BackButton(color: Colors.white),
          actions: const [HeartCount()],
        ),
        body: GetBuilder<JlptWordController>(builder: (controller) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 5.0,
            ),
            itemCount: controller.jlptSteps.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return CalendarCard(
                  isAabled: true,
                  jlptStep: controller.jlptSteps[index],
                  onTap: () {
                    controller.setStep(index);
                    if (isSeenTutorial) {
                      Get.toNamed(JLPT_STUDY_PATH);
                    } else {
                      isSeenTutorial = !isSeenTutorial;
                      Get.to(
                        () => const JlptStudyTutorialSceen(),
                        transition: Transition.circularReveal,
                      );
                    }
                  },
                );
              }

              return CalendarCard(
                isAabled: controller.jlptSteps[index - 1].isFinished ?? false,
                jlptStep: controller.jlptSteps[index],
                onTap: () {
                  controller.setStep(index);
                  if (isSeenTutorial) {
                    Get.toNamed(JLPT_STUDY_PATH);
                  } else {
                    isSeenTutorial = !isSeenTutorial;
                    Get.to(
                      () => const JlptStudyTutorialSceen(),
                      transition: Transition.circularReveal,
                    );
                  }
                },
              );
            },
          );
        }),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: Text(chapter),
        actions: const [HeartCount()],
      ),
      bottomNavigationBar: GetBuilder<BannerAdController>(
        builder: (controller) {
          return BannerContainer(bannerAd: controller.calendarBanner);
        },
      ),
      body: GetBuilder<KangiController>(builder: (controller) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: controller.kangiSteps.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return KangiCalendarCard(
                isAabled: true,
                kangiStep: controller.kangiSteps[index],
                onTap: () {
                  controller.setStep(index);
                  Get.toNamed(KANGI_STUDY_PATH);
                },
              );
            }
            return KangiCalendarCard(
              isAabled: controller.kangiSteps[index - 1].isFinished ?? false,
              kangiStep: controller.kangiSteps[index],
              onTap: () {
                controller.setStep(index);
                Get.toNamed(KANGI_STUDY_PATH);
              },
            );
          },
        );
      }),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/ad_controller.dart';
import 'package:japanese_voca/common/widget/calendar_card.dart';
import 'package:japanese_voca/controller/jlpt_word_controller.dart';
import 'package:japanese_voca/controller/kangi_controller.dart';
import 'package:japanese_voca/kangi_study_sceen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/jlpt_study_tutorial_sceen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/jlpt_study_sceen.dart';

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
  late int randomNumber = 3;
  late int studiedCount = 0;
  final Random random = Random();

  AdController adController = Get.find<AdController>();

  JlptCalendarStepSceen({super.key}) {
    randomNumber = random.nextInt(3) + 1; // 1 - 3

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
    if (isJlpt) {
      return Scaffold(
        appBar: AppBar(
          title: Text(chapter),
          leading: const BackButton(color: Colors.white),
          actions: const [HeartCount()],
          //  actions: [
          // TextButton(
          //     onPressed: () => Get.toNamed(LISTEN_SCREEN_PATH),
          //     child: const Text(
          //       '단어 자동 듣기',
          //       style: TextStyle(color: Colors.white),
          //     ))
          // ],
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
              return JlptCalendarCard(
                jlptStep: controller.jlptSteps[index],
                onTap: () {
                  studiedCount++;
                  if (studiedCount == randomNumber) {
                    adController.showRewardedInterstitialAd();
                    randomNumber = random.nextInt(2) + 3;
                  }

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
      body: GetBuilder<KangiController>(builder: (controller) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: controller.kangiSteps.length,
          itemBuilder: (context, index) {
            return KangiCalendarCard(
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

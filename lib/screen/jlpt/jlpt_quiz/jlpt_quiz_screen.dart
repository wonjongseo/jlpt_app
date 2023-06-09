import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_contrainer.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/controller/jlpt_test_controller.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_quiz/components/body.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_quiz/components/progress_bar.dart';

import '../../../common/admob/banner_ad/banner_ad_controller.dart';

const JLPT_QUIZ_PATH = '/quiz';
const JLPT_TEST = 'jlpt';
const CONTINUTE_JLPT_TEST = 'continue_jlpt_test';
const MY_VOCA_TEST = 'my_vcoa_test';

class JlptQuizScreen extends StatelessWidget {
  const JlptQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BannerAdController adController = Get.find<BannerAdController>();
    JlptTestController questionController = Get.put(JlptTestController());

    // 모든 문제로 테스트 준비해기

    if (Get.arguments != null && Get.arguments[MY_VOCA_TEST] != null) {
      questionController.startMyVocaQuiz(Get.arguments[MY_VOCA_TEST]);
    } else if (Get.arguments != null && Get.arguments[JLPT_TEST] != null) {
      questionController.startJlptQuiz(Get.arguments[JLPT_TEST]);
    }
    // 과거에 틀린 문제로만 테스트 준비하기
    else {
      questionController.startJlptQuizHistory(
        Get.arguments[CONTINUTE_JLPT_TEST],
      );
    }

    if (!adController.loadingTestBanner) {
      adController.loadingTestBanner = true;
      adController.createTestBanner();
    }
    return Scaffold(
      appBar: _appBar(questionController),
      body: const Body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  AppBar _appBar(JlptTestController questionController) {
    return AppBar(
      title: const ProgressBar(isKangi: false),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () =>
            questionController.isMyWordTest ? getBacks(1) : getBacks(2),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        GetBuilder<JlptTestController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: TextButton(
              onPressed: questionController.skipQuestion,
              child: Text(
                controller.text,
                style: TextStyle(color: controller.color, fontSize: 20),
              ),
            ),
          );
        })
      ],
    );
  }

  GetBuilder<BannerAdController> _bottomNavigationBar() {
    return GetBuilder<BannerAdController>(builder: (controller) {
      return BannerContainer(bannerAd: controller.testBanner);
    });
  }
}

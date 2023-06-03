import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:japanese_voca/ad_controller.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_contrainer.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_quiz/components/body.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_quiz/components/progress_bar.dart';

import '../../../common/admob/banner_ad/banner_ad_controller.dart';

const JLPT_QUIZ_PATH = '/quiz';
const KANGI_TEST = 'kangi';
const JLPT_TEST = 'jlpt';
const TEST_TYPE = 'type';

class JlptQuizScreen extends StatelessWidget {
  const JlptQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BannerAdController adController = Get.find<BannerAdController>();
    QuestionController questionController = Get.put(QuestionController());

    if (!adController.loadingTestBanner) {
      adController.loadingTestBanner = true;
      adController.createTestBanner();
    }

    questionController.startJlptQuiz(Get.arguments[JLPT_TEST]);
    return Scaffold(
      appBar: _appBar(questionController),
      body: const Body(),
      bottomNavigationBar:
          GetBuilder<BannerAdController>(builder: (controller) {
        return BannerContainer(bannerAd: controller.testBanner);
      }),
    );
  }

  AppBar _appBar(QuestionController questionController) {
    return AppBar(
      title: const ProgressBar(isKangi: false),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () => getBacks(2),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        GetBuilder<QuestionController>(builder: (controller) {
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
}

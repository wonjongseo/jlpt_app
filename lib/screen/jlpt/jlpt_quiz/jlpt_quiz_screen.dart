import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_contrainer.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/controller/jlpt_quiz_controller.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_quiz/components/body.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_quiz/components/progress_bar.dart';

import '../../../common/admob/banner_ad/banner_ad_controller.dart';

const JLPT_QUIZ_PATH = '/quiz';
const JLPT_TEST = 'jlpt';
const CONTINUTE_JLPT_TEST = 'continue_jlpt_test';
const MY_VOCA_TEST = 'my_vcoa_test';
const MY_VOCA_TEST_KNOWN = 'known';
const MY_VOCA_TEST_UNKNWON = 'un_known';

class JlptQuizScreen extends StatelessWidget {
  const JlptQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    JlptQuizController questionController = Get.put(JlptQuizController());
    questionController.init(Get.arguments);

    return Scaffold(
      appBar: _appBar(questionController),
      body: const Body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  AppBar _appBar(JlptQuizController questionController) {
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
        GetBuilder<JlptQuizController>(builder: (controller) {
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

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_contrainer.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/entity/jlpt_and_kangi/jlpt/jlpt_test/controller/jlpt_test_controller.dart';
import 'package:japanese_voca/entity/jlpt_and_kangi/jlpt/jlpt_test/components/jlpt_test_body.dart';
import 'package:japanese_voca/entity/jlpt_and_kangi/common/progress_bar.dart';

import '../../../../common/admob/banner_ad/banner_ad_controller.dart';
import '../../../../config/colors.dart';

const JLPT_TEST_PATH = '/test';
const JLPT_TEST = 'jlpt';
const CONTINUTE_JLPT_TEST = 'continue_jlpt_test';
const MY_VOCA_TEST = 'my_vcoa_test';
const MY_VOCA_TEST_KNOWN = 'known';
const MY_VOCA_TEST_UNKNWON = 'un_known';

class JlptTestScreen extends StatelessWidget {
  const JlptTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    JlptTestController questionController = Get.put(JlptTestController());
    questionController.init(Get.arguments);

    return Scaffold(
      appBar: _appBar(questionController),
      body: const JlptTestBody(),
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
        onPressed: () => getBacks(2),
      ),
      iconTheme: const IconThemeData(color: AppColors.scaffoldBackground),
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

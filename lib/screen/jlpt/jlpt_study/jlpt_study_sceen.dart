import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:japanese_voca/common/admob/banner_ad/banner_ad_contrainer.dart';
import 'package:japanese_voca/common/widget/kangi_text.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/components/jlpt_study_buttons.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/jlpt_study_controller.dart';
import 'package:japanese_voca/controller/user_controller.dart';

import '../../../common/admob/banner_ad/banner_ad_controller.dart';
import '../../../common/widget/app_bar_progress_bar.dart';
import '../../../common/widget/heart_count.dart';
import '../../setting/services/setting_controller.dart';

final String JLPT_STUDY_PATH = '/jlpt_study';

// ignore: must_be_immutable
class JlptStudyScreen extends StatelessWidget {
  final JlptStudyController wordController = Get.put(JlptStudyController());
  UserController userController = Get.find<UserController>();

  SettingController settingController = Get.find<SettingController>();

  late BannerAdController? adController;
  JlptStudyScreen({super.key}) {
    adController = Get.find<BannerAdController>();
    if (!userController.user.isPremieum) {
      if (wordController.isAginText == false &&
          !adController!.loadingStudyBanner) {
        adController!.loadingStudyBanner = true;
        adController!.createStudyBanner();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<JlptStudyController>(builder: (controller) {
      double currentValue = controller.getCurrentProgressValue();
      return Scaffold(
        floatingActionButton: _floatingActionButton(),
        appBar: _appBar(size, currentValue),
        body: _body(context, controller),
        bottomNavigationBar: _bottomNavigationBar(),
      );
    });
  }

  FloatingActionButton? _floatingActionButton() {
    if (wordController.words.length >= 4) {
      return FloatingActionButton.extended(
        onPressed: () async {
          await wordController.goToTest();
        },
        label: const Text(
          '시험 보기',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return null;
    }
  }

  GetBuilder<BannerAdController> _bottomNavigationBar() {
    return GetBuilder<BannerAdController>(
      builder: (controller) {
        return BannerContainer(bannerAd: controller.studyBanner);
      },
    );
  }

  Widget _body(BuildContext context, JlptStudyController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!settingController.isAutoSave)
                  IconButton(
                    onPressed: () => wordController.saveCurrentWord(),
                    icon: const Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.words.length,
              itemBuilder: (context, index) {
                String japanese = controller.words[index].word;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(child: controller.yomikata()),
                    KangiText(japanese: japanese, clickTwice: false),
                    const SizedBox(height: 20),
                    SizedBox(child: controller.mean()),
                  ],
                );
              },
            ),
          ),
          const Spacer(flex: 1),
          JlptStudyButtons(wordController: controller),
          const Spacer(flex: 2),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  AppBar _appBar(Size size, double currentValue) {
    return AppBar(
      actions: const [
        HeartCount(),
      ],
      leading: IconButton(
        onPressed: () async {
          wordController.jlptStep.unKnownWord = [];
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: AppBarProgressBar(size: size, currentValue: currentValue),
    );
  }
}

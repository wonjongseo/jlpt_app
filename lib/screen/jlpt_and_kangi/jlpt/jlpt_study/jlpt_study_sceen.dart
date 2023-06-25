import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:japanese_voca/common/widget/kangi_text.dart';

import 'package:japanese_voca/screen/jlpt_and_kangi/jlpt/jlpt_study/jlpt_study_controller_temp.dart';

import '../../../../common/admob/banner_ad/global_banner_admob.dart';
import '../../../../common/widget/app_bar_progress_bar.dart';
import '../../../../common/widget/heart_count.dart';
import '../../../setting/services/setting_controller.dart';
import 'components/jlpt_study_buttons_temp.dart';

final String JLPT_STUDY_PATH = '/jlpt_study';

// ignore: must_be_immutable
class JlptStudyScreen extends StatelessWidget {
  final JlptStudyControllerTemp wordController =
      Get.put(JlptStudyControllerTemp());

  SettingController settingController = Get.find<SettingController>();

  JlptStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<JlptStudyControllerTemp>(builder: (controller) {
      double currentValue = controller.getCurrentProgressValue();
      return Scaffold(
        floatingActionButton: _floatingActionButton(),
        appBar: _appBar(size, currentValue),
        body: _body(context, controller),
        bottomNavigationBar: const GlobalBannerAdmob(),
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
          '시험',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return null;
    }
  }

  Widget _body(BuildContext context, JlptStudyControllerTemp controller) {
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
            flex: 7,
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
          JlptStudyButtonsTemp(wordController: controller),
          const Spacer(flex: 2),
          const SizedBox(height: 10)
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

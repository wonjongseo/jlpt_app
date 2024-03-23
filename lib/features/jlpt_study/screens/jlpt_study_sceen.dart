import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/widget/app_bar_progress_bar.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/common/widget/heart_count.dart';

import 'package:japanese_voca/features/jlpt_study/jlpt_study_controller.dart';
import 'package:japanese_voca/features/jlpt_study/widgets/word_card.dart';
import 'package:japanese_voca/features/setting/services/setting_controller.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';

final String JLPT_STUDY_PATH = '/jlpt_study';

// ignore: must_be_immutable
class JlptStudyScreen extends StatelessWidget {
  final JlptStudyController wordController = Get.put(JlptStudyController());

  SettingController settingController = Get.find<SettingController>();
  KangiStepRepositroy kangiStepRepositroy = KangiStepRepositroy();
  JlptStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JlptStudyController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          actions: const [HeartCount()],
          title: RichText(
            text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Responsive.height10 * 2.4,
                ),
                children: [
                  TextSpan(
                    text: '${controller.currentIndex + 1}',
                    style: TextStyle(
                      color: Colors.cyan.shade500,
                      fontSize: Responsive.height10 * 3,
                    ),
                  ),
                  const TextSpan(text: ' / '),
                  TextSpan(text: '${controller.jlptStep.words.length}')
                ]),
          ),
        ),
        body: _body(context, controller),
        bottomNavigationBar: const GlobalBannerAdmob(),
      );
    });
  }

  Widget _body(BuildContext context, JlptStudyController controller) {
    return Stack(
      children: [
        PageView.builder(
          controller: controller.pageController,
          onPageChanged: controller.onPageChanged,
          itemCount: controller.words.length,
          itemBuilder: (context, index) {
            return WordCard(
                word: controller.words[index], controller: controller);
          },
        ),
        Positioned(
            bottom: 20,
            right: 20,
            child: TextButton(
              onPressed: () {
                wordController.goToTest();
              },
              child: Text('학습'),
            ))
      ],
    );
  }
}

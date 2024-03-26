import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/common/widget/heart_count.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';

import 'package:japanese_voca/features/jlpt_study/widgets/word_card.dart';
import 'package:japanese_voca/features/setting/services/setting_controller.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';

final String JLPT_STUDY_PATH = '/jlpt_study';

// ignore: must_be_immutable
class JlptStudyScreen extends StatefulWidget {
  const JlptStudyScreen({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  State<JlptStudyScreen> createState() => _JlptStudyScreenState();
}

class _JlptStudyScreenState extends State<JlptStudyScreen> {
  final JlptStepController wordController = Get.find<JlptStepController>();
  late int currentIndex;
  SettingController settingController = Get.find<SettingController>();
  TtsController ttsController = TtsController();
  KangiStepRepositroy kangiStepRepositroy = KangiStepRepositroy();

  late PageController pageController;
  @override
  void initState() {
    wordController.currentIndex = widget.currentIndex;
    currentIndex = widget.currentIndex;
    super.initState();
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JlptStepController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          actions: const [HeartCount()],
          title: RichText(
            text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Responsive.height10 * 2,
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
                  TextSpan(text: '${controller.getJlptStep().words.length}')
                ]),
          ),
        ),
        body: _body(context, controller),
        bottomNavigationBar: const GlobalBannerAdmob(),
      );
    });
  }

  void onPageChanged(int page) {
    currentIndex = page;
    wordController.currentIndex = page;
    setState(() {});
    // update();
  }

  Widget _body(BuildContext context, JlptStepController controller) {
    return Stack(
      children: [
        PageView.builder(
          controller: pageController,
          onPageChanged: controller.onPageChanged,
          itemCount: controller.getJlptStep().words.length,
          itemBuilder: (context, index) {
            return WordCard(
                word: controller.getJlptStep().words[index],
                controller: controller);
          },
        ),
        Positioned(
            bottom: 20,
            right: 20,
            child: TextButton(
              onPressed: () {
                wordController.goToTest();
              },
              child: const Text('학습'),
            ))
      ],
    );
  }
}

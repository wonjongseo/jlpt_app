import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/common/widget/heart_count.dart';
import 'package:japanese_voca/config/size.dart';
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
  TtsController ttsController = Get.find<TtsController>();
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
    ttsController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JlptStepController>(builder: (controller) {
      return Scaffold(
        appBar: _appBar(controller),
        body: _body(context, controller),
        bottomNavigationBar: const GlobalBannerAdmob(),
      );
    });
  }

  PreferredSize _appBar(JlptStepController controller) {
    int wordsLen = controller.getJlptStep().words.length;
    return PreferredSize(
      preferredSize: const Size.fromHeight(appBarHeight),
      child: AppBar(
        actions: const [HeartCount()],
        title: wordsLen != controller.currentIndex
            ? RichText(
                text: TextSpan(
                  style:
                      TextStyle(color: Colors.black, fontSize: appBarTextSize),
                  children: [
                    TextSpan(
                      text: '${controller.currentIndex + 1}',
                      style: TextStyle(
                        color: Colors.cyan.shade500,
                        fontSize: Responsive.height10 * 2.5,
                      ),
                    ),
                    const TextSpan(text: ' / '),
                    TextSpan(text: '$wordsLen')
                  ],
                ),
              )
            : Text(''),
      ),
    );
  }

  void onPageChanged(int page) {
    currentIndex = page;
    wordController.currentIndex = page;
    setState(() {});
  }

  Widget _body(BuildContext context, JlptStepController controller) {
    int wordsLen = controller.getJlptStep().words.length;
    return PageView.builder(
      controller: pageController,
      onPageChanged: (value) async {
        await ttsController.stop();
        controller.onPageChanged(value);
      },
      itemCount: wordsLen + 1,
      itemBuilder: (context, index) {
        if (index == wordsLen) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: InkWell(
              onTap: () => controller.goToTest(),
              child: Card(
                child: Center(
                  child: Text(
                    'Go to the QUIZ!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan.shade600,
                        fontSize: Responsive.height10 * 2.4),
                  ),
                ),
              ),
            ),
          );
        }
        return WordCard(
          word: controller.getJlptStep().words[index],
          controller: controller,
        );
      },
    );
  }
}

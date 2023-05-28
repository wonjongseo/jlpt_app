import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/kangi_text.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/components/jlpt_study_buttons.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/jlpt_study_controller.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../common/widget/app_bar_progress_bar.dart';

final String JLPT_STUDY_PATH = '/jlpt_study';

// ignore: must_be_immutable
class JlptStudyScreen extends StatelessWidget {
  late JlptStudyController wordController;
  bool isAutoSave = LocalReposotiry.getAutoSave();

  List<TargetFocus> targets = [];

  JlptStudyScreen({super.key}) {
    if (Get.arguments != null && Get.arguments['againTest'] != null) {
      wordController = Get.put(JlptStudyController(isAgainTest: true));
    } else {
      wordController = Get.put(JlptStudyController());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<JlptStudyController>(builder: (controller) {
      double currentValue = ((controller.currentIndex).toDouble() /
              controller.words.length.toDouble()) *
          100;

      return Scaffold(
        appBar: _appBar(size, currentValue),
        body: _body(context, controller),
      );
    });
  }

  Widget _body(BuildContext context, JlptStudyController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isAutoSave)
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Word currentWord =
                      wordController.words[wordController.currentIndex];
                  MyWord.saveToMyVoca(
                    currentWord,
                    isManualSave: true,
                  );
                },
                icon: const Icon(
                  Icons.save,
                  size: 22,
                  color: Colors.white,
                ),
              ),
            ),
          const Spacer(flex: 1),
          Expanded(
            flex: 2,
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
          const SizedBox(height: 32),
          JlptStudyButtons(wordController: controller),
          const Spacer(flex: 1),
          if (!isAutoSave) const SizedBox(height: 20)
        ],
      ),
    );
  }

  AppBar _appBar(Size size, double currentValue) {
    return AppBar(
      actions: [
        if (wordController.words.length >= 4)
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: TextButton(
              onPressed: wordController.goToTest,
              child: const Text(
                'TEST',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
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

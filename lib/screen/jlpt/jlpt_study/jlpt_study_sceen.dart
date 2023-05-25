import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/repository/localRepository.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/components/jlpt_study_buttons.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/components/jlpt_study_card.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/jlpt_controller.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

final String JLPT_STUDY_PATH = '/jlpt_study';

// ignore: must_be_immutable
class JlptStudyScreen extends StatelessWidget {
  late JlptStudyController wordController;

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

    return Scaffold(
      appBar: _appBar(size),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    bool isAutoSave = LocalReposotiry.getAutoSave();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 22),
      child: GetBuilder<JlptStudyController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isAutoSave)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Word currentWord =
                        wordController.words[wordController.currentIndex];
                    MyWord.saveMyVoca(currentWord, isManualSave: true);
                  },
                  icon: const Icon(Icons.save, size: 22, color: Colors.white),
                ),
              ),
            const Spacer(flex: 1),
            JlptStrudyCard(controller: controller),
            const SizedBox(height: 32),
            const JlptStudyButtons(),
            const Spacer(flex: 1),
          ],
        );
      }),
    );
  }

  AppBar _appBar(Size size) {
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
      title: GetBuilder<JlptStudyController>(builder: (controller) {
        double currentValue = ((controller.currentIndex).toDouble() /
                controller.words.length.toDouble()) *
            100;
        return FAProgressBar(
          currentValue: currentValue,
          maxValue: 100,
          displayText: '%',
          size: size.width > 500 ? 35 : 25,
          formatValueFixed: 0,
          backgroundColor: AppColors.darkGrey,
          progressColor: AppColors.lightGreen,
          borderRadius: size.width > 500
              ? BorderRadius.circular(30)
              : BorderRadius.circular(12),
          displayTextStyle: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontSize: size.width > 500 ? 18 : 14),
        );
      }),
    );
  }
}

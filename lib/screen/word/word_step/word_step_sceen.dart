import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/background.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_word_controller.dart';
import 'package:japanese_voca/screen/word/word_study/word_study_sceen.dart';
import 'package:japanese_voca/screen/word/word_step/components/word_step_card.dart';

final String WORD_STEP_PATH = '/word-step';

class WordStepSceen extends StatelessWidget {
  late JlptWordController jlptWordController;
  String firstHiragana = '';
  WordStepSceen({super.key}) {
    jlptWordController = Get.find<JlptWordController>();
    firstHiragana = Get.arguments['firstHiragana'];
    jlptWordController.setJlptSteps(firstHiragana);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(firstHiragana),
      ),
      body: GetBuilder<JlptWordController>(builder: (controller) {
        return BackgroundWidget(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 5.0,
            ),
            itemCount: controller.jlptSteps.length,
            itemBuilder: (context, index) {
              return WordStepCard(
                color: colors[index % colors.length],
                jlptStep: controller.jlptSteps[index],
                onTap: () {
                  controller.setStep(index);
                  Get.toNamed(WORD_STUDY_PATH);
                },
              );
            },
          ),
        );
      }),
    );
  }
}

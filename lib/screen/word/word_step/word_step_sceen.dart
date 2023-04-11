import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_word_controller.dart';
import 'package:japanese_voca/screen/word/word_study/word_study_sceen.dart';
import 'package:japanese_voca/screen/word/word_step/components/word_step_card.dart';

final String WORD_STEP_PATH = '/word-step';

class WordStepSceen extends StatelessWidget {
  late JlptWordController jlptWordController;
  String firstHiragana = '';
  final String level;
  WordStepSceen({super.key, required this.level}) {
    jlptWordController = Get.find<JlptWordController>();
    firstHiragana = Get.arguments['firstHiragana'];
    jlptWordController.setJlptSteps(firstHiragana);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(firstHiragana),
        elevation: 0,
      ),
      body: GetBuilder<JlptWordController>(builder: (controller) {
        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5.0,
          children: List.generate(
            controller.jlptSteps.length,
            (step) {
              return WordStepCard(
                jlptStep: controller.jlptSteps[step],
                onTap: () {
                  controller.setStep(step);
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

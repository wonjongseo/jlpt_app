import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/controller/jlpt_word_controller.dart';
import 'package:japanese_voca/screen/word/n_word_study_sceen.dart';
import 'package:japanese_voca/screen/word/word_step/components/word_step_card.dart';

final String WORD_STEP_PATH = '/word-step';

class WordStepSceen extends StatelessWidget {
  late JlptWordController jlptWordController;
  String headTitle = '';

  WordStepSceen({super.key}) {
    jlptWordController = Get.put(JlptWordController());
    headTitle = Get.arguments['headTitle'];
    jlptWordController.setJlptSteps(headTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(headTitle),
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
                  Get.toNamed(N_WORD_STUDY_PATH);
                },
              );
            },
          ),
        );
      }),
    );
  }
}

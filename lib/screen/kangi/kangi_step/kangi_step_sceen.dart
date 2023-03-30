import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/kangi/kangi_step/components/word_step_card.dart';
import 'package:japanese_voca/screen/kangi/kangi_step_controller.dart';
import 'package:japanese_voca/screen/kangi/kangi_study/kangi_study_sceen.dart';

final String KANGI_STEP_PATH = '/kangi-step';

class KangiStepSceen extends StatelessWidget {
  late KangiStepController kangiController;
  String firstHangul = '';

  KangiStepSceen({super.key}) {
    kangiController = Get.put(KangiStepController());
    firstHangul = Get.arguments['firstHangul'];
    kangiController.setJlptSteps(firstHangul);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(firstHangul),
        elevation: 0,
      ),
      body: GetBuilder<KangiStepController>(builder: (controller) {
        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5.0,
          children: List.generate(
            controller.kangiSteps.length,
            (step) {
              return KangiStepCard(
                kangiStep: controller.kangiSteps[step],
                onTap: () {
                  controller.setStep(step);
                  Get.toNamed(KANGI_STUDY_PATH);
                },
              );
            },
          ),
        );
      }),
    );
  }
}

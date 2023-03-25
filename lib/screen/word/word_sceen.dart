import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/controller/jlpt_word_controller.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/screen/word/n_word_study_sceen.dart';

final String WORD_PATH = '/word';

class WordSceen extends StatefulWidget {
  const WordSceen({super.key});

  @override
  State<WordSceen> createState() => _WordSceenState();
}

class _WordSceenState extends State<WordSceen> {
  JlptWordController jlptWordController = Get.put(JlptWordController());
  String headTitle = '';

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
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
        List<JlptStep> jlptSteps = controller.jlptSteps;
        return GridView.count(
          padding: const EdgeInsets.all(20.0),
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          children: List.generate(
            controller.jlptSteps.length,
            (step) {
              return StepCard(
                  jlptStep: jlptSteps[step],
                  onTap: () {
                    controller.setStep(step);
                    Get.toNamed(N_WORD_STUDY_PATH);
                  });
            },
          ),
        );
      }),
    );
  }
}

class StepCard extends StatelessWidget {
  const StepCard({
    super.key,
    required this.jlptStep,
    required this.onTap,
  });
  final VoidCallback onTap;
  final JlptStep jlptStep;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: jlptStep.scores == jlptStep.words.length
                ? AppColors.correctColor
                : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(10)),
        child: GridTile(
          footer: Center(
            child: Text(
              '${jlptStep.scores.toString()} / ${jlptStep.words.length}',
            ),
          ),
          child: Center(
            child: Text((jlptStep.step + 1).toString(),
                style: Theme.of(context).textTheme.displayMedium),
          ),
        ),
      ),
    );
  }
}

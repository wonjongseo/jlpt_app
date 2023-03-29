import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/controller/grammar_controller.dart';
import 'package:japanese_voca/controller/jlpt_word_controller.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/screen/word/n_word_study_sceen.dart';

final String WORD_STEP_PATH = '/word-step';

class WordStepSceen extends StatefulWidget {
  const WordStepSceen({super.key});

  @override
  State<WordStepSceen> createState() => _WordStepSceenState();
}

class _WordStepSceenState extends State<WordStepSceen> {
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
    double width = MediaQuery.of(context).size.width;
    print('width: ${width}');

    return Scaffold(
      appBar: AppBar(
        title: Text(headTitle),
        elevation: 0,
      ),
      body: GetBuilder<JlptWordController>(builder: (controller) {
        List<JlptStep> jlptSteps = controller.jlptSteps;
        return GridView.count(
          // padding: const EdgeInsets.all(50.0),
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5.0,
          children: List.generate(
            controller.jlptSteps.length,
            (step) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: InkWell(
                    onTap: () {
                      controller.setStep(step);
                      Get.toNamed(N_WORD_STUDY_PATH);
                    },
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/calender.svg',
                          color: controller.jlptSteps[step].scores ==
                                  controller.jlptSteps[step].words.length
                              ? AppColors.lightGreen
                              : null,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: width / 20),
                            Padding(
                              padding: EdgeInsets.only(top: width / 30),
                              child: Text(
                                  (controller.jlptSteps[step].step + 1)
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(fontSize: (width / 10))),
                            ),
                            SizedBox(height: width / 100),
                            Center(
                              child: Text(
                                '${controller.jlptSteps[step].scores.toString()} / ${controller.jlptSteps[step].words.length}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: width / 40,
                                    ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              );
            },
          ),
        );
      }),
    );
  }
}

Color getColor(double range) {
  if (range > 0 && range < 0.1) {
    return Colors.redAccent;
  } else if (range < 0.35) {
    return Colors.yellowAccent;
  } else if (range < 0.65) {
    return Colors.orangeAccent;
  } else {
    return Colors.greenAccent;
  }
}

Row _progressbar(Size size, double progressValue) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        height: 10,
        width: size.width / 1.5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey.withOpacity(0.2),
            color: getColor(progressValue),
            value: progressValue,
          ),
        ),
      ),
    ],
  );
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

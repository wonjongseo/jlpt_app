import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/background.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/controller/grammar_controller.dart';
import 'package:japanese_voca/model/grammar_step.dart';
import 'package:japanese_voca/model/word_step.dart';
import 'package:japanese_voca/screen/grammar/grammar_screen.dart';

final String GRAMMAR_STEP_PATH = '/grammar_step';

class GrammarStepSceen extends StatefulWidget {
  const GrammarStepSceen({super.key});

  @override
  State<GrammarStepSceen> createState() => _GrammarStepSceenState();
}

class _GrammarStepSceenState extends State<GrammarStepSceen> {
  GrammarController jlptWordController = Get.find<GrammarController>();

  String level = '1';

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    // level = Get.arguments['level'] ;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GetBuilder<GrammarController>(builder: (controller) {
        return BackgroundWidget(
          child: GridView.count(
            // padding: const EdgeInsets.al(50.0),
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 5.0,
            children: List.generate(
              controller.grammers.length,
              (step) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: InkWell(
                      onTap: () {
                        controller.setStep(step);
                        Get.toNamed(GRAMMER_PATH);
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/calender.svg',
                            color: controller.grammers[step].scores ==
                                    controller.grammers[step].grammars.length
                                ? AppColors.lightGreen
                                : Colors.black87,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: width / 20),
                              Padding(
                                padding: EdgeInsets.only(top: width / 30),
                                child: Text(
                                    (controller.grammers[step].step + 1)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(fontSize: (width / 10))),
                              ),
                              SizedBox(height: width / 100),
                              Center(
                                child: Text(
                                  '${controller.grammers[step].scores.toString()} / ${controller.grammers[step].grammars.length}',
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

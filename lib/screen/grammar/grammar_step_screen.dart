import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/heart_count.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/entity/grammar/controller/grammar_controller.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/common/repository/local_repository.dart';
import '../../common/admob/banner_ad/banner_ad_contrainer.dart';
import '../../common/admob/banner_ad/banner_ad_controller.dart';

// ignore: must_be_immutable
class GrammarStepSceen extends StatelessWidget {
  GrammarStepSceen({super.key, required this.level});

  final String level;
  late bool isSeenTutorial;

  @override
  Widget build(BuildContext context) {
    isSeenTutorial = LocalReposotiry.isSeenGrammarTutorial();
    GrammarController grammarController =
        Get.put(GrammarController(level: level));
    grammarController.initAdFunction();

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('N$level 문법'),
        actions: const [HeartCount()],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      body: _body(width, context),
    );
  }

  GetBuilder<GrammarController> _body(double width, BuildContext context) {
    return GetBuilder<GrammarController>(
      builder: (controller) {
        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5.0,
          children: List.generate(
            controller.grammers.length,
            (subStep) {
              if (subStep == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: InkWell(
                      onTap: () =>
                          controller.goToSturyPage(subStep, isSeenTutorial),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/calender.svg',
                            color: controller.isSuccessedAllGrammar(subStep)
                                ? AppColors.lightGreen
                                : Colors.white,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: width / 20),
                              Padding(
                                padding: EdgeInsets.only(top: width / 30),
                                child: Text(
                                    (controller.grammers[subStep].step + 1)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(
                                          fontSize: (width / 10),
                                        )),
                              ),
                              SizedBox(height: width / 100),
                              Center(
                                child: Text(
                                  '${controller.grammers[subStep].scores.toString()} / ${controller.grammers[subStep].grammars.length}',
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
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: InkWell(
                    // 이전 챕터를  풀었야만 접속 가능.
                    onTap: controller.isFinishedPreviousSubStep(subStep)
                        ? () {
                            if (!controller.restrictN1SubStep(subStep)) {
                              controller.goToSturyPage(subStep, isSeenTutorial);
                            }
                          }
                        : null,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/calender.svg',
                          color: controller.isSuccessedAllGrammar(subStep)
                              ? AppColors.lightGreen
                              : controller.isFinishedPreviousSubStep(subStep)
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.2),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: width / 20),
                            Padding(
                              padding: EdgeInsets.only(top: width / 30),
                              child: Text(
                                  (controller.grammers[subStep].step + 1)
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                        fontSize: (width / 10),
                                        color: controller
                                                .isFinishedPreviousSubStep(
                                                    subStep)
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.2),
                                      )),
                            ),
                            SizedBox(height: width / 100),
                            Center(
                              child: Text(
                                '${controller.grammers[subStep].scores.toString()} / ${controller.grammers[subStep].grammars.length}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color:
                                          controller.isFinishedPreviousSubStep(
                                                  subStep)
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.2),
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
      },
    );
  }

  GetBuilder<BannerAdController> _bottomNavigationBar() {
    return GetBuilder<BannerAdController>(
      builder: (controller) {
        return BannerContainer(bannerAd: controller.calendarBanner);
      },
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
                color: AppColors.scaffoldBackground.withOpacity(0.3),
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

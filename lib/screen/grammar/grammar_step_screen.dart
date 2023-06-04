import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/heart_count.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/screen/grammar/controller/grammar_controller.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/screen/grammar/grammar_screen.dart';
import 'package:japanese_voca/screen/grammar/components/grammar_tutorial_screen.dart';

import '../../common/admob/banner_ad/banner_ad_contrainer.dart';
import '../../common/admob/banner_ad/banner_ad_controller.dart';

// ignore: must_be_immutable
class GrammarStepSceen extends StatelessWidget {
  GrammarStepSceen({super.key, required this.level});
  final String level;
  late bool isSeenTutorial;
  final BannerAdController bannerAdController = Get.find<BannerAdController>();

  @override
  Widget build(BuildContext context) {
    if (!bannerAdController.loadingCalendartBanner) {
      bannerAdController.loadingCalendartBanner = true;
      bannerAdController.createCalendarBanner();
    }
    isSeenTutorial = LocalReposotiry.isSeenGrammarTutorial();

    Get.put(GrammarController(level: level));
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'N$level 문법',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
        leading: const BackButton(color: Colors.white),
        actions: const [HeartCount()],
      ),
      bottomNavigationBar: GetBuilder<BannerAdController>(
        builder: (controller) {
          return BannerContainer(bannerAd: controller.calendarBanner);
        },
      ),
      body: GetBuilder<GrammarController>(
        builder: (controller) {
          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 5.0,
            children: List.generate(
              controller.grammers.length,
              (step) {
                if (step == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: InkWell(
                        onTap: () {
                          controller.setStep(step);

                          if (!isSeenTutorial) {
                            isSeenTutorial = !isSeenTutorial;
                            Get.to(
                              () => const GrammerTutorialScreen(),
                              transition: Transition.circularReveal,
                            );
                          } else {
                            Get.toNamed(GRAMMER_PATH);
                          }
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/calender.svg',
                              color: controller.grammers[step].scores ==
                                      controller.grammers[step].grammars.length
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
                                      (controller.grammers[step].step + 1)
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(
                                              fontSize: (width / 10),
                                              color: Colors.white)),
                                ),
                                SizedBox(height: width / 100),
                                Center(
                                  child: Text(
                                    '${controller.grammers[step].scores.toString()} / ${controller.grammers[step].grammars.length}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.white,
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
                      onTap: controller.grammers[step - 1].isFinished ?? false
                          ? () {
                              controller.setStep(step);

                              if (!isSeenTutorial) {
                                isSeenTutorial = !isSeenTutorial;
                                Get.to(
                                  () => const GrammerTutorialScreen(),
                                  transition: Transition.circularReveal,
                                );
                              } else {
                                Get.toNamed(GRAMMER_PATH);
                              }
                            }
                          : null,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/calender.svg',
                            color: controller.grammers[step].scores ==
                                    controller.grammers[step].grammars.length
                                ? AppColors.lightGreen
                                : controller.grammers[step - 1].isFinished ??
                                        false
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
                                    (controller.grammers[step].step + 1)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(
                                          fontSize: (width / 10),
                                          color: controller.grammers[step - 1]
                                                      .isFinished ??
                                                  false
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.2),
                                        )),
                              ),
                              SizedBox(height: width / 100),
                              Center(
                                child: Text(
                                  '${controller.grammers[step].scores.toString()} / ${controller.grammers[step].grammars.length}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: controller.grammers[step - 1]
                                                    .isFinished ??
                                                false
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
      ),
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

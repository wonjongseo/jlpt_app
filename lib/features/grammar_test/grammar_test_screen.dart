import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/app_bar_progress_bar.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/grammar_test/controller/grammar_test_controller.dart';
import 'package:japanese_voca/features/grammar_test/components/grammar_test_card.dart';
import 'package:japanese_voca/features/grammar_step/widgets/score_and_message.dart';

import '../../common/admob/banner_ad/global_banner_admob.dart';

const GRAMMAR_TEST_SCREEN = '/grammar_test';

// ignore: must_be_immutable
class GrammarTestScreen extends StatelessWidget {
  late GrammarTestController grammarTestController;
  GrammarTestScreen({super.key}) {
    grammarTestController = Get.put(GrammarTestController());

    grammarTestController.init(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // 점수 백분율

    return Scaffold(
      appBar: _appBar(size),
      bottomNavigationBar: const GlobalBannerAdmob(),
      body: _body(size),
    );
  }

  Widget _body(Size size) {
    return GetBuilder<GrammarTestController>(builder: (controller) {
      double score = grammarTestController.getScore();
      return Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: Responsive.height10,
              left: Responsive.width15,
              right: Responsive.width15,
            ),
            child: Container(
              color: AppColors.whiteGrey,
              child: SingleChildScrollView(
                controller: controller.scrollController,
                child: Padding(
                  padding: EdgeInsets.all(Responsive.height16),
                  child: Column(
                    children: [
                      if (controller.isSubmitted)
                        ScoreAndMessage(
                          score: score,
                          size: size,
                        )
                      else
                        Padding(
                          padding: EdgeInsets.only(bottom: Responsive.height16),
                          child: const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '빈칸에 맞는 답을 선택해 주세요.',
                              style: TextStyle(
                                color: AppColors.scaffoldBackground,
                              ),
                            ),
                          ),
                        ),
                      ...List.generate(
                        controller.questions.length,
                        (questionIndex) {
                          return GrammarTestCard(
                            size: size,
                            questionIndex: questionIndex,
                            question: controller.questions[questionIndex],
                            onChanged: (int selectedAnswerIndex) {
                              controller.clickButton(
                                  questionIndex, selectedAnswerIndex);
                            },
                            isCorrect: !controller.wrongQuetionIndexList
                                .contains(questionIndex),
                            isSubmitted: controller.isSubmitted,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  AppBar _appBar(Size size) {
    // 진행률 백분율

    return AppBar(
      scrolledUnderElevation: 0.0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () async {
          if (grammarTestController.isSubmitted) {
            grammarTestController.saveScore();
            Get.back();
            return;
          }
          bool result = await reallyQuitText();
          if (result) {
            Get.back();
            return;
          }
        },
      ),
      title: GetBuilder<GrammarTestController>(
        builder: (grammarTestController) {
          double currentProgressValue =
              grammarTestController.getCurrentProgressValue();
          return AppBarProgressBar(
            size: size,
            currentValue: currentProgressValue,
          );
        },
      ),
      actions: [
        GetBuilder<GrammarTestController>(
          builder: (grammarTestController) {
            if (grammarTestController.isSubmitted) {
              return Card(
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () => grammarTestController.againTest(),
                  child: Padding(
                    padding: EdgeInsets.all(Responsive.width14),
                    child: Text(
                      '다시!',
                      style: TextStyle(
                        fontSize: Responsive.width14,
                        fontWeight: FontWeight.w600,
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ),
                ),
              );
            }

            return Card(
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () => grammarTestController
                    .submit(grammarTestController.getScore()),
                child: Padding(
                  padding: EdgeInsets.all(Responsive.width14),
                  child: Text(
                    '제출!',
                    style: TextStyle(
                      fontSize: Responsive.width14,
                      fontWeight: FontWeight.w600,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

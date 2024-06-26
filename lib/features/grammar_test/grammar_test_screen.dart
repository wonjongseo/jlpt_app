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
              top: Responsive.height50,
              left: Responsive.width20,
              right: Responsive.width20,
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
                      SizedBox(height: Responsive.height16)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: Responsive.width16),
            child: controller.isSubmitted
                ? Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                          ),
                          child: Text(
                            '나가기',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.height14,
                            ),
                          ),
                          onPressed: () {
                            controller.saveScore();
                            getBacks(2);
                          },
                        ),
                        SizedBox(
                          width: Responsive.height8,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                            ),
                            onPressed: () {
                              controller.againTest();
                            },
                            child: Text(
                              '다시 하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Responsive.height14,
                              ),
                            ))
                      ],
                    ),
                  )
                : Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                      ),
                      onPressed: () => controller.submit(score),
                      child: Text(
                        '제출',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.height14,
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
          }),
      title:
          GetBuilder<GrammarTestController>(builder: (grammarTestController) {
        double currentProgressValue =
            grammarTestController.getCurrentProgressValue();
        return AppBarProgressBar(
          size: size,
          currentValue: currentProgressValue,
        );
      }),
    );
  }
}

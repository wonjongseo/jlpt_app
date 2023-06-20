import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_contrainer.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/app_bar_progress_bar.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/screen/grammar/grammar_test/controller/grammar_test_controller.dart';
import 'package:japanese_voca/screen/grammar/grammar_test/components/grammar_test_card.dart';
import 'package:japanese_voca/screen/grammar/components/score_and_message.dart';

import '../../../common/admob/banner_ad/banner_ad_controller.dart';

const GRAMMAR_TEST_SCREEN = '/grammar_test';

class GrammarTestScreen extends StatelessWidget {
  GrammarTestScreen({super.key});

  // late ScrollController scrollController;
  GrammarTestController grammarTestController =
      Get.put(GrammarTestController());

  @override
  Widget build(BuildContext context) {
    grammarTestController.init(Get.arguments);
    Size size = MediaQuery.of(context).size;

    // 진행률 백분율
    double currentProgressValue =
        grammarTestController.getCurrentProgressValue();

    // 점수 백분율

    return Scaffold(
      appBar: _appBar(currentProgressValue, size),
      bottomNavigationBar: _bottomNavigationBar(),
      body: _body(size),
    );
  }

  BannerContainer _bottomNavigationBar() {
    return const BannerContainer();
  }

  Widget _body(Size size) {
    return GetBuilder<GrammarTestController>(builder: (controller) {
      double score = grammarTestController.getScore();
      return Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: Dimentions.height60,
                left: Dimentions.height20,
                right: Dimentions.height20),
            child: Container(
              color: AppColors.whiteGrey,
              child: SingleChildScrollView(
                controller: controller.scrollController,
                child: Padding(
                  padding: EdgeInsets.all(Dimentions.height16),
                  child: Column(
                    children: [
                      if (controller.isSubmitted)
                        // 점수와 격려의 메세지 출력.
                        ScoreAndMessage(
                          score: score,
                          size: size,
                        )
                      else
                        Padding(
                          padding: EdgeInsets.only(bottom: Dimentions.height16),
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
                      SizedBox(height: Dimentions.height16)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: Dimentions.height16),
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
                          child: const Text(
                            '나가기',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            controller.saveScore();
                            getBacks(2);
                          },
                        ),
                        SizedBox(width: Dimentions.height16 / 2),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                            ),
                            onPressed: () {
                              controller.againTest();
                            },
                            child: const Text(
                              '다시 하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                      onPressed: () {
                        controller.submit(score);
                      },
                      child: const Text(
                        '제출',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      );
    });
  }

  AppBar _appBar(double currentValue, Size size) {
    return AppBar(
      leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () async {
            bool result = await reallyQuizText();
            if (result) {
              getBacks(2);
              return;
            }
          }),
      title: AppBarProgressBar(
        size: size,
        currentValue: currentValue,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/controller/kangi_question_controller.dart';
import 'package:japanese_voca/screen/kangi/kangi_quiz/components/kangi_question_card.dart';
import 'package:japanese_voca/screen/quiz/components/progress_bar.dart';

const KANGI_QUIZ_PATH = '/kangi_quiz';
const KANGI_TEST = 'kangi';
const JLPT_TEST = 'jlpt';

class KangiQuizScreen extends StatelessWidget {
  const KangiQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    KangiQuestionController kangiQuestionController =
        Get.put(KangiQuestionController());

    kangiQuestionController.startKangiQuiz(Get.arguments[KANGI_TEST]);

    return Scaffold(
      appBar: AppBar(
        title: const ProgressBar(),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            getBacks(2);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          GetBuilder<KangiQuestionController>(builder: (controller) {
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: TextButton(
                onPressed: kangiQuestionController.skipQuestion,
                child: Text(
                  controller.text,
                  style: TextStyle(color: controller.color, fontSize: 20),
                ),
              ),
            );
          })
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(
                    (() => Text.rich(
                          TextSpan(
                            text:
                                "問題 ${kangiQuestionController.questionNumber.value}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                            children: [
                              TextSpan(
                                text:
                                    "/${kangiQuestionController.questions.length}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Divider(
                  thickness: 1.5,
                  color: Colors.white.withOpacity(0.7),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: kangiQuestionController.pageController,
                    onPageChanged: kangiQuestionController.updateTheQnNum,
                    itemCount: kangiQuestionController.questions.length,
                    itemBuilder: (context, index) {
                      return KangiQuestionCard(
                        question: kangiQuestionController.questions[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

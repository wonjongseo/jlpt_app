import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:japanese_voca/screen/quiz/components/body.dart';
import 'package:japanese_voca/screen/quiz/components/progress_bar.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_calendar_step/jlpt_calendar_step_sceen.dart';

const QUIZ_PATH = '/quiz';
const KANGI_TEST = 'kangi';
const JLPT_TEST = 'jlpt';
const TEST_TYPE = 'type';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController questionController = Get.put(QuestionController());

    if (Get.arguments[TEST_TYPE] != null && Get.arguments[JLPT_TEST] != null) {
      questionController.startJlptQuiz(
        Get.arguments[JLPT_TEST],
        Get.arguments[TEST_TYPE],
      );
    } else if (Get.arguments[TEST_TYPE] != null &&
        Get.arguments[KANGI_TEST] != null) {
      questionController.startKangiQuiz(
          Get.arguments[KANGI_TEST], Get.arguments[TEST_TYPE]);
    } else {
      questionController.startGrammarQuiz(Get.arguments['words']);
    }

    return Scaffold(
      appBar: AppBar(
        title: const ProgressBar(),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => getBacks(2),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          GetBuilder<QuestionController>(builder: (controller) {
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: TextButton(
                onPressed: questionController.skipQuestion,
                child: Text(
                  controller.text,
                  style: TextStyle(color: controller.color, fontSize: 20),
                ),
              ),
            );
          })
        ],
      ),
      body: const Body(),
    );
  }
}

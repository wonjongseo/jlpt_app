import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_quiz/components/body.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_quiz/components/progress_bar.dart';

const JLPT_QUIZ_PATH = '/quiz';
const KANGI_TEST = 'kangi';
const JLPT_TEST = 'jlpt';
const TEST_TYPE = 'type';

class JlptQuizScreen extends StatelessWidget {
  const JlptQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController questionController = Get.put(QuestionController());

    questionController.startJlptQuiz(Get.arguments[JLPT_TEST]);
    return Scaffold(
      appBar: AppBar(
        title: const ProgressBar(isKangi: false),
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

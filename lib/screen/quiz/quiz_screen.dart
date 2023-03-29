import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:japanese_voca/screen/quiz/components/body.dart';
import 'package:japanese_voca/screen/quiz/components/progress_bar.dart';
import 'package:japanese_voca/screen/word/word_step/word_step_sceen.dart';

const QUIZ_PATH = '/quiz';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());

    if (Get.arguments['alertResult'] != null) {
      _questionController.startJlptQuiz(
          Get.arguments['words'], Get.arguments['alertResult']);
    } else {
      _questionController.startGrammarQuiz(Get.arguments['words']);

      // grammar
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          title: const ProgressBar(),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
              Get.back();
            },
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            GetBuilder<QuestionController>(builder: (controller) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: TextButton(
                  onPressed: _questionController.skipQuestion,
                  child: Text(
                    controller.text,
                    style: TextStyle(color: controller.color, fontSize: 20),
                  ),
                ),
              );
            })
          ],
        ),
        body: const Body());
  }
}

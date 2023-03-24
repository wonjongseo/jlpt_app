import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';

import 'package:get/get.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:japanese_voca/screen/quiz/components/body.dart';

const QUIZ_PATH = '/quiz';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
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

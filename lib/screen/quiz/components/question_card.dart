import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:japanese_voca/model/Question.dart';
import 'package:japanese_voca/screen/quiz/components/option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    // QuestionController _controller = Get.put(QuestionController());
    return GetBuilder<QuestionController>(builder: (controller) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.circular(25),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Column(
          children: [
            InkWell(
              onTap: () => copyWord(question.question.word),
              child: Text(
                question.question.word,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: const Color(0xFF101010),
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            const SizedBox(height: 20 / 2),
            SingleChildScrollView(
              child: Column(
                  children: List.generate(
                question.options.length,
                (index) => Option(
                  test: question.options[index],
                  index: index,
                  press: () => controller.checkAns(question, index),
                ),
              )),
            )
          ],
        ),
      );
    });
  }
}

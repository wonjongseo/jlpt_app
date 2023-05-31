import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';

import '../../../../common/common.dart';
import '../../../../controller/kangi_question_controller.dart';
import '../../../../model/Question.dart';
import 'kangi_question_option.dart';

class KangiQuestionCard extends StatelessWidget {
  KangiQuestionCard({super.key, required this.question});

  final Question question;
  final KangiQuestionController controller =
      Get.find<KangiQuestionController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: AppColors.whiteGrey,
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  children: List.generate(
                question.options.length,
                (index) => KangiQuestionOption(
                  test: question.options[index],
                  index: index,
                  press: () => controller.checkAns(question, index),
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/screen/jlpt_and_kangi/jlpt/jlpt_test/controller/jlpt_test_controller.dart';
import 'package:japanese_voca/model/Question.dart';

import 'jlpt_test_option.dart';
import 'jlpt_test_text_form_field.dart';

class JlptTestCard extends StatelessWidget {
  JlptTestCard({super.key, required this.question});

  final Question question;
  final JlptTestController controller = Get.find<JlptTestController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.whiteGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Text(
            question.question.word,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: const Color(0xFF101010),
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.japaneseFont,
                ),
          ),
          const SizedBox(height: 40),
          if (controller.settingController.isTestKeyBoard)
            const JlptTestTextFormField(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  children: List.generate(
                question.options.length,
                (index) => JlptTestOption(
                  test: question.options[index],
                  index: index,
                  press: controller.isSubmitted
                      ? () {}
                      : () {
                          controller.checkAns(question, index);
                        },
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

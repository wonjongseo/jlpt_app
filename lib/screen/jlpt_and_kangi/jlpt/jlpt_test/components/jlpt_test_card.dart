import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
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
    String qustionWord = question.question.word;

    if (qustionWord.contains('·')) {
      qustionWord = qustionWord.split('·')[0];
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimentions.width20),
      padding: EdgeInsets.all(Dimentions.width20),
      decoration: BoxDecoration(
        color: AppColors.whiteGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimentions.width24),
          topRight: Radius.circular(Dimentions.width24),
        ),
      ),
      child: Column(
        children: [
          Text(
            qustionWord,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: const Color(0xFF101010),
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.japaneseFont,
                ),
          ),
          SizedBox(height: Dimentions.height40),
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

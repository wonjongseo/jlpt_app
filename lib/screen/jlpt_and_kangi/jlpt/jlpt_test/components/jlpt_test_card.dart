import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/screen/jlpt_and_kangi/jlpt/jlpt_test/controller/jlpt_test_controller.dart';
import 'package:japanese_voca/model/Question.dart';

import 'jlpt_test_option.dart';

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
            GetBuilder<JlptTestController>(builder: (qnController) {
              return TextFormField(
                autofocus: true,
                style: TextStyle(
                    color: qnController.getTheTextEditerBorderRightColor(
                        isBorder: false)),
                onTapOutside: (event) {
                  if (controller.questionNumber.value <
                      controller.questions.length) {
                    if (event.position.dx > 75 &&
                        controller.textEditingController!.text.isEmpty) {
                      controller.requestFocus();
                      if (!Get.isSnackbarOpen) {
                        Get.snackbar(
                          '주의!',
                          '읽는 법을 먼저 입력해주세요',
                          duration: const Duration(seconds: 2),
                          colorText: AppColors.whiteGrey,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.scaffoldBackground,
                        );
                      }
                    }
                  }
                },
                onChanged: (value) {
                  controller.inputValue = value;
                },
                focusNode: controller.focusNode,
                onFieldSubmitted: (value) {
                  controller.onFieldSubmitted(value);
                  FocusScope.of(context).unfocus();
                },
                controller: controller.textEditingController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: qnController.getTheTextEditerBorderRightColor(),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: qnController.getTheTextEditerBorderRightColor(),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  label: Text(
                    ' 읽는 법',
                    style: TextStyle(
                      color: AppColors.scaffoldBackground.withOpacity(0.5),
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }),
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
                      : () => controller.checkAns(question, index),
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
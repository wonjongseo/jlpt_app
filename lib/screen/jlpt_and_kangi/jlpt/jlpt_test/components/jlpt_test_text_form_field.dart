import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';

import '../../../../../config/colors.dart';
import '../controller/jlpt_test_controller.dart';

class JlptTestTextFormField extends StatelessWidget {
  const JlptTestTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JlptTestController>(
      builder: (controller) {
        return TextFormField(
          autofocus: true,
          style: TextStyle(
            color: controller.getTheTextEditerBorderRightColor(isBorder: false),
          ),
          // onTapOutside: (event) {
          //   if (controller.questionNumber.value < controller.questions.length) {
          //     if (event.position.dx > 75 &&
          //         controller.textEditingController!.text.isEmpty) {
          //       controller.requestFocus();

          //       if (!Get.isSnackbarOpen) {
          //         Get.snackbar(
          //           '주의!',
          //           '읽는 법을 먼저 입력해주세요',
          //           duration: const Duration(seconds: 2),
          //           colorText: AppColors.whiteGrey,
          //           snackPosition: SnackPosition.BOTTOM,
          //           backgroundColor: AppColors.scaffoldBackground,
          //         );
          //       }
          //     }
          //   }
          // },
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
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Tooltip(
                message: '장음 (-, ー) 은 생략해도 됩니다.',
                child: Icon(
                  Icons.tips_and_updates,
                  size: 16,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            hintText: '읽는 법을 먼저 입력해주세요.',
            hintStyle: TextStyle(fontSize: Dimentions.width10),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: controller.getTheTextEditerBorderRightColor(),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: controller.getTheTextEditerBorderRightColor(),
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
      },
    );
  }
}

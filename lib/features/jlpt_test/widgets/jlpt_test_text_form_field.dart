import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/string.dart';
import 'package:japanese_voca/config/theme.dart';

import '../../../config/colors.dart';
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
            fontFamily: AppFonts.japaneseFont,
          ),
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
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.height8,
              ),
              child: Tooltip(
                triggerMode: TooltipTriggerMode.tap,
                message: AppString.shortAnswerToolTip.tr,
                child: Icon(
                  Icons.tips_and_updates,
                  size: Responsive.height16,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            hintText: AppString.shortAnswerHelp.tr,
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
              ' ${AppString.pronunciation.tr}',
              style: TextStyle(
                color: AppColors.scaffoldBackground.withOpacity(0.5),
                fontSize: Responsive.height16,
              ),
            ),
          ),
        );
      },
    );
  }
}

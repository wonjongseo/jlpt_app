import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';

void showSnackBar(
  String message, {
  Duration? duration,
}) {
  if (Get.isSnackbarOpen) return;
  Get.snackbar(
    '',
    '',
    duration: duration ?? const Duration(milliseconds: 1500),
    titleText: Container(),
    messageText: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: AppFonts.japaneseFont,
            ),
          ),
        ),
        InkWell(
          onTap: Get.closeAllSnackbars,
          child: const Text(
            '닫기',
            style: TextStyle(color: Colors.redAccent),
          ),
        )
      ],
    ),
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.symmetric(
      horizontal: Responsive.width10 * 2,
    ),
    backgroundColor: Colors.white,
    borderWidth: 1,
    borderColor: AppColors.mainBordColor,
    icon: const Icon(
      Icons.check,
      color: Colors.green,
    ),
  );
}

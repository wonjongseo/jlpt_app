import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/word/n_word_study_sceen.dart';

Future<bool?> getAlertDialog(Widget title, Widget content) async {
  return Get.dialog(
    barrierDismissible: false,
    AlertDialog(
      title: title,
      content: content,
      actions: [
        CustomButton(
          onTap: () {
            Get.back(result: true);
          },
          text: 'Yes',
        ),
        CustomButton(
          onTap: () {
            Get.back(result: false);
          },
          text: 'No',
        )
      ],
    ),
  );
}

Future<bool?> getTransparentAlertDialog(
    {Widget? title, List<Widget>? contentChildren}) async {
  return Get.dialog<bool>(
    AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      contentPadding: const EdgeInsets.symmetric(vertical: 2),
      actionsAlignment: MainAxisAlignment.spaceAround,
      title: title,
      content: SizedBox(
        width: 300,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: contentChildren ??
              [
                CustomButton(
                    text: '뜻',
                    onTap: () {
                      Get.back(result: true);
                    }),
                CustomButton(
                    text: '읽는 법',
                    onTap: () {
                      Get.back(result: false);
                    }),
              ],
        ),
      ),
    ),
  );
}

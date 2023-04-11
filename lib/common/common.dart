import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';

void getBacks(int count) {
  for (int i = 0; i < count; i++) {
    Get.back();
  }
}

List<int> getKangiIndex(String japanese) {
  List<int> result = [];
  for (int i = 0; i < japanese.length; i++) {
    if (japanese[i].compareTo('一') >= 0 && japanese[i].compareTo('龥') <= 0) {
      result.add(i);
    }
    // if (japanese[i].compareTo('ぁ') >= 0 && japanese[i].compareTo('ん') <= 0 ||
    //     japanese[i].compareTo('ァ') >= 0 && japanese[i].compareTo('ヶ') <= 0) {
    //   result.add(i);
    // }
  }
  return result;
}

Future<bool?> getAlertDialog(Widget title, Widget content,
    {barrierDismissible = false}) async {
  return Get.dialog(
    barrierDismissible: barrierDismissible,
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

void copyWord(String text) {
  Clipboard.setData(ClipboardData(text: text));

  if (!Get.isSnackbarOpen) {
    Get.closeAllSnackbars();
    Get.snackbar(
      'Copied',
      '${text}가 복사(Ctrl + C) 되었습니다.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(seconds: 2),
    );
  }
}


/**
 * 
    
          
 */
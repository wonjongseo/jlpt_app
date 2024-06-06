import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/app_constant.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../model/kangi.dart';

Future<bool> isIpad() async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  final deviceInfo = await deviceInfoPlugin.deviceInfo;
  final allInfo = deviceInfo.data;
  print('allInfo : ${allInfo}');

  if (allInfo['systemName'] != null) {
    if (allInfo['systemName'].contains('iPad')) {
      return true;
    }
  }
  return false;
}

bool isKangi(String word) {
  return word.compareTo('一') >= 0 && word.compareTo('龠') <= 0;
}

bool isKatakana(String word) {
  return word.compareTo('\u30A0') >= 0 && word.compareTo('\u30FF') <= 0;
}

bool isHiragana(String word) {
  return word.compareTo('\u3040') >= 0 && word.compareTo('\u309F') <= 0;
}

bool isJapanses(String word) {
  return isKangi(word) || isKatakana(word) || isHiragana(word);
}

void getBacks(int count) {
  for (int i = 0; i < count; i++) {
    Get.back();
  }
}

List<int> getKangiIndex(
    String japanese, KangiStepRepositroy kangiStepRepositroy) {
  List<int> result = [];
  for (int i = 0; i < japanese.length; i++) {
    if (isKangi(japanese[i])) {
      Kangi? kangi = kangiStepRepositroy.getKangi(japanese[i]);
      if (kangi != null) {
        result.add(i);
      }
    }
  }
  return result;
}

// 광고를 볼지 물어보고 하트를 제공
Future<bool> askToWatchMovieAndGetHeart({
  Text? title,
  Text? content,
}) async {
  bool result = await Get.dialog(
    AlertDialog(
      title: title,
      titleTextStyle: TextStyle(
          fontSize: Responsive.width18, color: AppColors.scaffoldBackground),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (content != null) content,
          SizedBox(height: Responsive.height10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: threeWordButtonWidth,
                child: ElevatedButton(
                    onPressed: () => Get.back(result: true),
                    child: const Text('네')),
              ),
              SizedBox(
                width: threeWordButtonWidth,
                child: ElevatedButton(
                    onPressed: () => Get.back(result: false),
                    child: const Text('아니요')),
              ),
            ],
          )
        ],
      ),
    ),
    barrierDismissible: false,
  );

  return result;
}

Future<bool> reallyQuitText() async {
  bool result = await askToWatchMovieAndGetHeart(
      title: const Text('테스트를 그만두시겠습니까?'),
      content: const Text(
        '테스트 중간에 나가면 점수가 기록되지 않습니다. 그래도 나가시겠습니까?',
        style: TextStyle(color: AppColors.scaffoldBackground),
      ));

  return result;
}

void copyWord(String text) {
  Clipboard.setData(ClipboardData(text: text));

  if (!Get.isSnackbarOpen) {
    Get.closeAllSnackbars();
    Get.snackbar(
      'Copied',
      '$text가 복사(Ctrl + C) 되었습니다.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.whiteGrey.withOpacity(0.5),
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(seconds: 2),
    );
  }
}

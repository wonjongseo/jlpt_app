import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

const int INIT_HEART_COUNT = 30;

class UserController extends GetxController {
  late int heartCount;

  @override
  void onInit() async {
    super.onInit();

    if (!await UserRepository.isExistData()) {
      log('isExistData == true');
      await UserRepository.initData();
      heartCount = INIT_HEART_COUNT;
    }

    heartCount = UserRepository.getHeart();
  }

  Future<bool> useHeart() async {
    if (heartCount <= 0) {
      return false;
    }
    heartCount = await UserRepository.subTractHeart();

    update();

    return true;
  }

  void plusHeart({int plusHeartCount = 1}) {
    if (heartCount + plusHeartCount > 30) return;
    heartCount += plusHeartCount;
    UserRepository.addHeart(heartCount);
    update();
  }
}

class UserRepository {
  static String boxKey = 'heart_key';
  static String heartKey = 'heart';

  static Future<bool> isExistData() async {
    final box = Hive.box(boxKey);

    return box.isNotEmpty;
  }

  static void addHeart(int plusHeartCount) {
    final box = Hive.box(boxKey);
    box.put(heartKey, plusHeartCount);
  }

  static Future<int> initData() async {
    final box = Hive.box(boxKey);

    await box.put(heartKey, INIT_HEART_COUNT);

    int currentHeartCount = await box.get(heartKey);

    return currentHeartCount;
  }

  static int getHeart() {
    final box = Hive.box(boxKey);
    // If null == 30
    return box.get(heartKey, defaultValue: INIT_HEART_COUNT);
  }

  static Future<int> subTractHeart() async {
    final box = Hive.box(boxKey);

    int currentHeartCount = await box.get(heartKey);

    currentHeartCount--;

    await box.put(heartKey, currentHeartCount);

    currentHeartCount = await box.get(heartKey);

    return currentHeartCount;
  }
}

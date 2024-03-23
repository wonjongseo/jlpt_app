import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/screens/book_step_screen.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';

import 'package:japanese_voca/common/admob/controller/ad_controller.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

class HomeController extends GetxController {
  late AdController? adController;
  UserController userController = Get.find<UserController>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    if (scaffoldKey.currentState!.isEndDrawerOpen) {
      scaffoldKey.currentState!.closeEndDrawer();
      update();
    } else {
      scaffoldKey.currentState!.openEndDrawer();
      update();
    }
  }

  void goToJlptStudy(String index) async {
    Get.put(JlptStepController(level: index));

    Get.to(
      () => BookStepScreen(
        level: index,
        isJlpt: true,
      ),
      duration: const Duration(milliseconds: 300),
    );
  }

  void goToKangiScreen(String level) {
    Get.to(
      () => BookStepScreen(
        level: level,
        isJlpt: false,
      ),
      duration: const Duration(milliseconds: 300),
    );
  }
}

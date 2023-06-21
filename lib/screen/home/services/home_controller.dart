import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/admob/banner_ad/banner_ad_controller.dart';
import '../../../common/admob/controller/ad_controller.dart';
import '../../user/controller/user_controller.dart';
import '../../../common/repository/local_repository.dart';
import '../../jlpt_and_kangi/common/book_step_screen.dart';
import 'home_tutorial_service.dart';

class HomeController extends GetxController {
  late PageController pageController;

  late AdController? adController;
  UserController userController = Get.find<UserController>();

  late int currentPageIndex;
  late bool isSeenTutorial;

  HomeTutorialService? homeTutorialService = null;

  void initAd() {}

  @override
  void onInit() {
    super.onInit();
    currentPageIndex = LocalReposotiry.getUserJlptLevel();
    pageController = PageController(initialPage: currentPageIndex);
    isSeenTutorial = LocalReposotiry.isSeenHomeTutorial();
    initAd();
  }

  void pageChange(int page) async {
    currentPageIndex = page;

    pageController.jumpToPage(currentPageIndex);
    update();
    await LocalReposotiry.updateUserJlptLevel(page);
  }

  void goToJlptStudy(String index) {
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

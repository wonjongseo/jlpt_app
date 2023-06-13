import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/admob/banner_ad/banner_ad_controller.dart';
import '../../../controller/ad_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../repository/local_repository.dart';
import '../../jlpt/jlpt_book_step/jlpt_book_step_screen.dart';
import 'home_tutorial_service.dart';

class HomeController extends GetxController {

  late PageController pageController;

  late AdController? adController;
  late BannerAdController? bannerAdController;
  UserController userController = Get.find<UserController>();

  late int currentPageIndex;
  late bool isSeenTutorial;

  HomeTutorialService? homeTutorialService = null;

  @override
  void onInit() {
    super.onInit();
    currentPageIndex = LocalReposotiry.getUserJlptLevel();
    pageController = PageController(initialPage: currentPageIndex);
    isSeenTutorial = LocalReposotiry.isSeenHomeTutorial();
  }

  void pageChange(int page) async {
    currentPageIndex = page;

    pageController.jumpToPage(currentPageIndex);
    update();
    await LocalReposotiry.updateUserJlptLevel(page);
  }



  void goToJlptStudy(String index) {
    Get.to(
      () => JlptBookStepScreen(
        level: index,
        isJlpt: true,
      ),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void goToKangiScreen(String level) {
    Get.to(
      () => JlptBookStepScreen(
        level: level,
        isJlpt: false,
      ),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }
}
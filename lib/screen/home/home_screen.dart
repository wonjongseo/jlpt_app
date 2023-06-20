import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/grammar/grammar_step_screen.dart';
import 'package:japanese_voca/screen/home/components/welcome_widget.dart';
import 'package:japanese_voca/screen/home/services/home_controller.dart';
import 'package:japanese_voca/screen/home/services/home_tutorial_service.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_sceen.dart';
import 'package:japanese_voca/screen/user/controller/user_controller.dart';
import 'package:japanese_voca/screen/home/components/users_word_button.dart';

import '../../common/admob/banner_ad/banner_ad_contrainer.dart';
import '../../common/admob/banner_ad/banner_ad_controller.dart';
import '../../common/widget/part_of_information.dart';
import '../../config/colors.dart';
import '../my_voca/controller/my_voca_controller.dart';

const String HOME_PATH = '/home2';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());

    return Column(
      children: [
        Expanded(
          child: Scaffold(
            body: _body(context, homeController),
            bottomNavigationBar: _bottomNavigationBar(),
          ),
        ),
        GetBuilder<BannerAdController>(
          builder: (controller) {
            return BannerContainer(bannerAd: controller.homepageBanner);
          },
        )
      ],
    );
  }

  SafeArea _body(BuildContext context, HomeController homeController) {
    if (!homeController.isSeenTutorial) {
      homeController.homeTutorialService = HomeTutorialService();
      homeController.homeTutorialService?.initTutorial();
      homeController.homeTutorialService?.showTutorial(context);
    }

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: WelcomeWidget(
                isUserPremieum: homeController.userController.isUserPremieum(),
                settingKey: homeController.homeTutorialService?.settingKey),
          ),
          Expanded(
            flex: 9,
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              controller: homeController.pageController,
              itemBuilder: (context, index) {
                const edgeInsets = EdgeInsets.symmetric(horizontal: 20 * 0.7);
                return GetBuilder<UserController>(
                  builder: (userController) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PartOfInformation(
                            goToSutdy: () => homeController
                                .goToJlptStudy((index + 1).toString()),
                            text: 'JLPT 단어',
                            currentProgressCount: userController
                                .user.currentJlptWordScroes[index],
                            totalProgressCount:
                                userController.user.jlptWordScroes[index],
                            edgeInsets: edgeInsets,
                            homeTutorialService:
                                homeController.homeTutorialService,
                          ),
                          if (index < 3)
                            PartOfInformation(
                              goToSutdy: () => Get.to(() => GrammarStepSceen(
                                  level: (index + 1).toString())),
                              text: 'JLPT 문법',
                              currentProgressCount: userController
                                  .user.currentGrammarScores[index],
                              totalProgressCount:
                                  userController.user.grammarScores[index],
                              edgeInsets: edgeInsets,
                            ),
                          PartOfInformation(
                            goToSutdy: () => homeController
                                .goToKangiScreen((index + 1).toString()),
                            text: 'JLPT 한자',
                            currentProgressCount:
                                userController.user.currentKangiScores[index],
                            totalProgressCount:
                                userController.user.kangiScores[index],
                            edgeInsets: edgeInsets,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                    child: FadeInLeft(
                      child: UserWordButton(
                        textKey: homeController.homeTutorialService?.myVocaKey,
                        text: '나만의 단어장',
                        onTap: () {
                          Get.toNamed(
                            MY_VOCA_PATH,
                            arguments: {MY_VOCA_TYPE: MyVocaEnum.MY_WORD},
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: FadeInLeft(
                      child: UserWordButton(
                        textKey:
                            homeController.homeTutorialService?.wrongWordKey,
                        text: '자주 틀리는 단어',
                        onTap: () {
                          Get.toNamed(
                            MY_VOCA_PATH,
                            arguments: {
                              MY_VOCA_TYPE: MyVocaEnum.WRONG_WORD,
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return GetBuilder<HomeController>(builder: (homeController) {
      return BottomNavigationBar(
        currentIndex: homeController.currentPageIndex,
        onTap: homeController.pageChange,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: homeController.currentPageIndex == 0
                      ? AppColors.primaryColor
                      : AppColors.whiteGrey,
                ),
                child: Text(
                  key: homeController
                      .homeTutorialService?.bottomNavigationBarKey,
                  'N1',
                  style: const TextStyle(
                    color: AppColors.scaffoldBackground,
                  ),
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: homeController.currentPageIndex == 1
                        ? AppColors.primaryColor
                        : AppColors.whiteGrey),
                child: const Text(
                  'N2',
                  style: TextStyle(
                    color: AppColors.scaffoldBackground,
                  ),
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: homeController.currentPageIndex == 2
                        ? AppColors.primaryColor
                        : AppColors.whiteGrey),
                child: const Text(
                  'N3',
                  style: TextStyle(
                    color: AppColors.scaffoldBackground,
                  ),
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: homeController.currentPageIndex == 3
                          ? AppColors.primaryColor
                          : AppColors.whiteGrey),
                  child: const Text(
                    'N4',
                    style: TextStyle(
                      color: AppColors.scaffoldBackground,
                    ),
                  )),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: homeController.currentPageIndex == 4
                        ? AppColors.primaryColor
                        : AppColors.whiteGrey),
                child: const Text(
                  'N5',
                  style: TextStyle(
                    color: AppColors.scaffoldBackground,
                  ),
                ),
              ),
              label: ''),
        ],
      );
    });
  }
}

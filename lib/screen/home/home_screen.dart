import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/screen/grammar/grammar_step_screen.dart';
import 'package:japanese_voca/screen/home/components/welcome_widget.dart';
import 'package:japanese_voca/screen/home/services/home_tutorial_service.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_book_step/jlpt_book_step_screen.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_sceen.dart';
import 'package:japanese_voca/controller/user_controller.dart';
import 'package:japanese_voca/screen/home/services/users_word_button.dart';

import '../../controller/ad_controller.dart';
import '../../common/admob/banner_ad/banner_ad_contrainer.dart';
import '../../common/admob/banner_ad/banner_ad_controller.dart';
import '../../components/part_of_information.dart';
import '../../config/colors.dart';
import '../../controller/my_voca_controller.dart';

const String HOME_PATH2 = '/home2';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<String> jlptLevels = ['N1', 'N2', 'N3', 'N4', 'N5'];

class _HomeScreenState extends State<HomeScreen> {
  late PageController pageController;

  late AdController? adController;
  late BannerAdController? bannerAdController;
  UserController userController = Get.find<UserController>();

  late int currentPageIndex;
  late bool isSeenTutorial;

  HomeTutorialService? homeTutorialService = null;

  @override
  void initState() {
    super.initState();

    currentPageIndex = LocalReposotiry.getUserJlptLevel();
    pageController = PageController(initialPage: currentPageIndex);
    isSeenTutorial = LocalReposotiry.isSeenHomeTutorial();
    if (!isSeenTutorial) {
      homeTutorialService = HomeTutorialService();
      homeTutorialService?.initTutorial();
      homeTutorialService?.showTutorial(context);
    }

    if (!userController.user.isPremieum) {
      adController = Get.find<AdController>();
      bannerAdController = Get.find<BannerAdController>();
      if (!bannerAdController!.loadingHomepageBanner) {
        bannerAdController!.loadingHomepageBanner = true;
        bannerAdController!.createHomepageBanner();
      }
    }
  }

  void pageChange(int page) async {
    currentPageIndex = page;

    pageController.jumpToPage(currentPageIndex);
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Scaffold(
            body: _body(context),
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

  SafeArea _body(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: WelcomeWidget(settingKey: homeTutorialService?.settingKey),
          ),
          Expanded(
            flex: 9,
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              controller: pageController,
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
                            goToSutdy: () {
                              goToJlptStudy((index + 1).toString());
                            },
                            text: 'JLPT 단어',
                            currentProgressCount: userController
                                .user.currentJlptWordScroes[index],
                            totalProgressCount:
                                userController.user.jlptWordScroes[index],
                            edgeInsets: edgeInsets,
                            homeTutorialService: homeTutorialService,
                          ),
                          if (index < 3)
                            PartOfInformation(
                              goToSutdy: () {
                                Get.to(() => GrammarStepSceen(
                                    level: (index + 1).toString()));
                              },
                              text: 'JLPT 문법',
                              currentProgressCount: userController
                                  .user.currentGrammarScores[index],
                              totalProgressCount:
                                  userController.user.grammarScores[index],
                              edgeInsets: edgeInsets,
                            ),
                          PartOfInformation(
                            goToSutdy: () {
                              goToKangiScreen((index + 1).toString());
                            },
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
                        textKey: homeTutorialService?.myVocaKey,
                        text: '나만의 단어장',
                        totalCount: 15,
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
                        textKey: homeTutorialService?.wrongWordKey,
                        text: '자주 틀리는 문제',
                        totalCount: 12,
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

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentPageIndex,
      onTap: pageChange,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      items: [
        BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPageIndex == 0
                    ? AppColors.primaryColor
                    : AppColors.whiteGrey,
              ),
              child: Text(
                key: homeTutorialService?.bottomNavigationBarKey,
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
                  color: currentPageIndex == 1
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
                  color: currentPageIndex == 2
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
                    color: currentPageIndex == 3
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
                  color: currentPageIndex == 4
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
  }
}

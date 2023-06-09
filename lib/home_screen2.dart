import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/screen/grammar/grammar_step_screen.dart';
import 'package:japanese_voca/screen/home/components/welcome_widget.dart';
import 'package:japanese_voca/screen/home/services/home_tutorial_service.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_book_step/jlpt_book_step_screen.dart';
import 'package:japanese_voca/screen/my_voca/home_my_voca_screen.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_sceen.dart';
import 'package:japanese_voca/user_controller2.dart';

import 'ad_controller.dart';
import 'common/admob/banner_ad/banner_ad_contrainer.dart';
import 'common/admob/banner_ad/banner_ad_controller.dart';
import 'common/excel.dart';
import 'components/part_of_information.dart';
import 'config/colors.dart';

const String HOME_PATH2 = '/home2';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

List<String> jlptLevels = ['N1', 'N2', 'N3', 'N4', 'N5'];

class _HomeScreen2State extends State<HomeScreen2> {
  late PageController pageController;
  AdController adController = Get.find<AdController>();
  late int currentPageIndex;

  late bool isSeenTutorial;
  late HomeTutorialService? homeTutorialService = null;
  BannerAdController adUnitController = Get.find<BannerAdController>();

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
    if (!adUnitController.loadingHomepageBanner) {
      adUnitController.loadingHomepageBanner = true;
      adUnitController.createHomepageBanner();
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
            flex: 1,
            child: WelcomeWidget(settingKey: homeTutorialService?.settingKey),
          ),
          Expanded(
            flex: 4,
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              controller: pageController,
              itemBuilder: (context, index) {
                const edgeInsets = EdgeInsets.symmetric(horizontal: 20 * 0.7);
                return GetBuilder<UserController2>(builder: (userController2) {
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
                          currentProgressCount:
                              userController2.user.currentJlptWordScroes[index],
                          totalProgressCount:
                              userController2.user.jlptWordScroes[index],
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
                            currentProgressCount: userController2
                                .user.currentGrammarScores[index],
                            totalProgressCount:
                                userController2.user.grammarScores[index],
                            edgeInsets: edgeInsets,
                          ),
                        PartOfInformation(
                          goToSutdy: () {
                            goToKangiScreen((index + 1).toString());
                          },
                          text: 'JLPT 한자',
                          currentProgressCount:
                              userController2.user.currentKangiScores[index],
                          totalProgressCount:
                              userController2.user.kangiScores[index],
                          edgeInsets: edgeInsets,
                        ),
                      ],
                    ),
                  );
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FadeInLeft(
                        child: SizedBox(
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextButton(
                            onPressed: () => Get.toNamed(MY_VOCA_PATH),
                            child: Text(
                              key: homeTutorialService?.myVocaKey,
                              '나만의 단어장',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                      FadeInLeft(
                        child: SizedBox(
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextButton(
                            onPressed: () async {
                              bool? result = await Get.dialog<bool>(
                                AlertDialog(
                                  title: const Text(
                                    'Excel 데이터 형식',
                                    style: TextStyle(
                                      color: AppColors.scaffoldBackground,
                                    ),
                                  ),
                                  content: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ExcelInfoText(
                                        number: '1. ',
                                        text1: '첫번째 열',
                                        text2: '일본어',
                                      ),
                                      ExcelInfoText(
                                        number: '2. ',
                                        text1: '두번째 열',
                                        text2: '읽는 법',
                                      ),
                                      ExcelInfoText(
                                        number: '3. ',
                                        text1: '세번째 열',
                                        text2: '뜻',
                                      ),
                                      Text.rich(
                                        style: TextStyle(
                                            color:
                                                AppColors.scaffoldBackground),
                                        TextSpan(
                                          text: '4. ',
                                          children: [
                                            TextSpan(
                                                text: '빈 행',
                                                style: TextStyle(
                                                    color: Colors.red)),
                                            TextSpan(text: '이 '),
                                            TextSpan(
                                                text: '없도록',
                                                style: TextStyle(
                                                    color: Colors.red)),
                                            TextSpan(text: ' 입력 해 주세요.'),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  actions: [
                                    if (GetPlatform.isWeb)
                                      const TextButton(
                                          onPressed: downloadExcelData,
                                          child: Text(
                                            'Excel 샘플 파일 다운로드',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                    TextButton(
                                        onPressed: () {
                                          Get.back(result: true);
                                        },
                                        child: const Text(
                                          '파일 첨부하기',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                              );
                              if (result != null) {
                                // AD
                                adController.showIntersistialAd();
                                await postExcelData();
                              }
                            },
                            child: Text(
                              'Excel 단어 저장하기',
                              key: homeTutorialService?.excelMyVocaKey,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
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
                        : AppColors.whiteGrey),
                child: Text(
                  key: homeTutorialService?.bottomNavigationBarKey,
                  'N1',
                  style: const TextStyle(
                    color: AppColors.scaffoldBackground,
                  ),
                )),
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
                )),
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
                )),
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
                )),
            label: ''),
      ],
    );
  }
}

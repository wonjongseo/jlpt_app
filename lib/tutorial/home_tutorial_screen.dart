import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/features/how_to_user/screen/how_to_use_screen.dart';
import 'package:japanese_voca/features/score/screens/veryGoodScreen.dart';
import 'package:japanese_voca/features/search/widgets/search_widget.dart';
import 'package:japanese_voca/features/home/widgets/home_screen_body.dart';
import 'package:japanese_voca/features/home/widgets/study_category_navigator.dart';
import 'package:japanese_voca/features/home/widgets/welcome_widget.dart';
import 'package:japanese_voca/features/home/services/home_controller.dart';
import 'package:japanese_voca/features/search/widgets/searched_word_card.dart';
import 'package:japanese_voca/features/setting/screens/setting_screen.dart';
import 'package:japanese_voca/features/setting/services/setting_controller.dart';
import 'package:japanese_voca/notification/notification.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/tutorial/home_tutorial.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

import '../../../common/admob/banner_ad/global_banner_admob.dart';
import '../../../config/colors.dart';
import '../../../config/theme.dart';

const String HOME_TUTORIAL_PATH = '/home_tutorial';

StreamController<String> streamController = StreamController.broadcast();

class HomeTutorialScreen extends StatefulWidget {
  const HomeTutorialScreen({super.key});

  @override
  State<HomeTutorialScreen> createState() => _HomeTutorialScreenState();
}

class _HomeTutorialScreenState extends State<HomeTutorialScreen> {
  KindOfStudy kindOfStudy = KindOfStudy.JLPT;

  bool isShowTutorial = false;
  HomeTutorialService homeTutorialService = HomeTutorialService();
  int selectedCategoryIndex = 0;
  UserController userController = Get.find<UserController>();

  Future setting() async {
    await initNotification();
    await settingFunctions();
  }

  initNotification() async {
    Future.delayed(const Duration(seconds: 3),
        await FlutterLocalNotification.requestNotificationPermission());
    await FlutterLocalNotification.showNotification();

    // AppReviewRequest.checkReviewRequest();
  }

  SettingController settingController = Get.find<SettingController>();

  Future settingFunctions() async {
    bool isSeen = LocalReposotiry.isSeenHomeTutorial();

    if (!isSeen) {
      bool isKeyBoardActive = await Get.dialog(
        AlertDialog(
          title: Text(
            '주관식 문제를 활성화 하시겠습니까?',
            style: TextStyle(
              fontSize: Responsive.height16,
            ),
          ),
          content: const Text(
            '테스트 중에는 읽는 법을 직접 입력하는 기능이 있습니다. 해당 기능을 활성화 하시겠습니까?',
          ),
          actions: [
            TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text(
                  '네',
                )),
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text(
                '아니요',
              ),
            ),
          ],
        ),
      );
      if (isKeyBoardActive) {
        if (!settingController.isTestKeyBoard) {
          settingController.flipTestKeyBoard();
        }
      } else {
        if (settingController.isTestKeyBoard) {
          settingController.flipTestKeyBoard();
        }
      }

      Get.closeAllSnackbars();
      Get.snackbar(
        '초기 설정이 완료 되었습니다.',
        '해당 설정들은 설정 페이지에서 재설정 할 수 있습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.whiteGrey.withOpacity(0.5),
        duration: const Duration(seconds: 4),
        animationDuration: const Duration(seconds: 2),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // initNotification();
    setting();
    selectedCategoryIndex = 0;
    homeTutorialService.pageController =
        PageController(initialPage: selectedCategoryIndex);
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
    homeTutorialService.pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: homeController.scaffoldKey,
      endDrawer: _endDrawer(),
      body: _body(context, homeController),
      bottomNavigationBar: const GlobalBannerAdmob(),
      floatingActionButton: FloatingActionButton.small(onPressed: () {
        Get.to(() => VeryGoodScreen());
      }),
    );
  }

  Drawer _endDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: const Icon(Icons.message),
              title: TextButton(
                onPressed: () {
                  Get.back();
                  Get.to(() => const HowToUseScreen());
                },
                child: Text(
                  '앱 설명 보기',
                  style: TextStyle(
                    fontFamily: AppFonts.nanumGothic,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.width14,
                    color: AppColors.scaffoldBackground,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: TextButton(
                onPressed: () {
                  Get.back();
                  Get.toNamed(SETTING_PATH, arguments: {
                    'isSettingPage': true,
                  });
                },
                child: Text(
                  '설정 페이지',
                  style: TextStyle(
                    fontFamily: AppFonts.nanumGothic,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.width14,
                    color: AppColors.scaffoldBackground,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.remove),
              title: TextButton(
                onPressed: () {
                  Get.back();
                  Get.toNamed(SETTING_PATH, arguments: {
                    'isSettingPage': false,
                  });
                },
                child: Text(
                  '데이터 초기화',
                  style: TextStyle(
                    fontFamily: AppFonts.nanumGothic,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.width14,
                    color: AppColors.scaffoldBackground,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPageChanged(int index) {
    selectedCategoryIndex = index;
    setState(() {});
  }

  Widget _body(BuildContext context, HomeController homeController) {
    if (!isShowTutorial) {
      homeTutorialService.initTutorial();
      homeTutorialService.showTutorial(context);
      isShowTutorial = true;
    }

    return SafeArea(
        child: Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            key: homeTutorialService.settingKey,
            onPressed: () => homeController.openDrawer(),
            icon: Icon(Icons.settings, size: Responsive.height10 * 2.2),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const WelcomeWidget(),
                const Spacer(flex: 1),
                // const NewSearchWidget()
                Stack(
                  children: [
                    Card(
                      child: Form(
                        child: TextFormField(
                          key: homeTutorialService.searchKey,
                          keyboardType: TextInputType.text,
                          controller: userController.textEditingController,
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                            userController.sendQuery();
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: ' 단어 검색...',
                            hintStyle: TextStyle(
                              fontSize: Responsive.height14,
                            ),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      right: 10,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          color: userController.isSearchReq
                              ? Colors.grey.shade300
                              : AppColors.mainBordColor,
                          child: InkWell(
                            onTap: () async {
                              if (userController.isSearchReq) return;
                              if (userController
                                      .textEditingController.text.isEmpty ||
                                  userController.textEditingController.text ==
                                      '') {
                                return;
                              }
                              await userController.sendQuery();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(Responsive.height10 / 2),
                              child: Icon(
                                Icons.search,
                                size: Responsive.height30,
                                color: userController.isSearchReq
                                    ? Colors.grey.shade100
                                    : Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Spacer(flex: 1),
                // StudyCategoryNavigator(
                //   onTap: (index) {
                //     homeTutorialService.pageController.animateToPage(
                //       index,
                //       duration: const Duration(milliseconds: 300),
                //       curve: Curves.ease,
                //     );
                //   },
                //   currentPageIndex: selectedCategoryIndex,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    KindOfStudy.values.length,
                    (index) {
                      late GlobalKey key;
                      if (index == 0) {
                        key = homeTutorialService.basicVocaKey;
                      } else if (index == 1) {
                        key = homeTutorialService.jlptVocaKey;
                      } else {
                        key = homeTutorialService.myVocaKey;
                      }
                      return TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size(
                            Responsive.width10 * 10,
                            Responsive.height10 * 3,
                          ),
                        ),
                        onPressed: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            border: index == selectedCategoryIndex
                                ? Border(
                                    bottom: BorderSide(
                                      width: Responsive.width10 * 0.3,
                                      color: Colors.cyan.shade600,
                                    ),
                                  )
                                : null,
                          ),
                          child: Text(
                            key: key,
                            '${KindOfStudy.values[index].value} 단어장',
                            style: index == selectedCategoryIndex
                                ? TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyan.shade600,
                                    fontSize: Responsive.width17,
                                  )
                                : TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: Responsive.width15,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                )
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     TextButton(
                //         style: TextButton.styleFrom(
                //           minimumSize: Size(
                //             Responsive.width10 * 10,
                //             Responsive.height10 * 3,
                //           ),
                //         ),
                //         onPressed: () {},
                //         child: Container(
                //           decoration: BoxDecoration(
                //               border: Border(
                //             bottom: BorderSide(
                //               width: Responsive.width10 * 0.3,
                //               color: Colors.cyan.shade600,
                //             ),
                //           )),
                //           child: Text(
                //             key: homeTutorialService.basicVocaKey,
                //             '${KindOfStudy.values[0].value} 단어장',
                //             style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               color: Colors.cyan.shade600,
                //               fontSize: Responsive.width17,
                //             ),
                //           ),
                //         )),
                //     TextButton(
                //         style: TextButton.styleFrom(
                //           minimumSize: Size(
                //             Responsive.width10 * 10,
                //             Responsive.height10 * 3,
                //           ),
                //         ),
                //         onPressed: () {},
                //         child: Container(
                //           decoration: BoxDecoration(
                //             border: null,
                //           ),
                //           child: Text(
                //             key: homeTutorialService.jlptVocaKey,
                //             '${KindOfStudy.values[1].value} 단어장',
                //             style: TextStyle(
                //               color: Colors.grey.shade600,
                //               fontSize: Responsive.width15,
                //             ),
                //           ),
                //         )),
                //     TextButton(
                //         style: TextButton.styleFrom(
                //           minimumSize: Size(
                //             Responsive.width10 * 10,
                //             Responsive.height10 * 3,
                //           ),
                //         ),
                //         onPressed: () {},
                //         child: Container(
                //           decoration: BoxDecoration(
                //             border: null,
                //           ),
                //           child: Text(
                //             key: homeTutorialService.myVocaKey,
                //             '${KindOfStudy.values[2].value} 단어장',
                //             style: TextStyle(
                //               color: Colors.grey.shade600,
                //               fontSize: Responsive.width15,
                //             ),
                //           ),
                //         ))
                //   ],
                // ),
                ,
                const Spacer(flex: 1),
                Expanded(
                  flex: 25,
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: homeTutorialService.pageController,
                    itemCount: 3,
                    onPageChanged: onPageChanged,
                    itemBuilder: (context, index) {
                      return HomeScreenBody(index: selectedCategoryIndex);
                    },
                  ),
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/features/home/services/home_controller.dart';
import 'package:japanese_voca/features/home/widgets/home_screen_body.dart';
import 'package:japanese_voca/features/home/widgets/study_category_navigator.dart';
import 'package:japanese_voca/features/home/widgets/welcome_widget.dart';
import 'package:japanese_voca/features/score/screens/veryGoodScreen.dart';
import 'package:japanese_voca/features/search/widgets/search_widget.dart';
import 'package:japanese_voca/features/setting/services/setting_controller.dart';
import 'package:japanese_voca/notification/notification.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

import '../../../config/colors.dart';
import '../../../config/theme.dart';
import '../../how_to_user/screen/how_to_use_screen.dart';
import '../../setting/screens/setting_screen.dart';

const String HOME_PATH = '/home';

StreamController<String> streamController = StreamController.broadcast();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  KindOfStudy kindOfStudy = KindOfStudy.JLPT;
  late PageController pageController;
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
    // TODO 살리기
    // bool isNeedUpdateAllData = LocalReposotiry.getIsNeedUpdateAllData();

    // if (isNeedUpdateAllData) {
    //   bool? a = await Get.dialog(
    //     barrierDismissible: false,
    //     AlertDialog(
    //       content: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         crossAxisAlignment: CrossAxisAlignment.end,
    //         children: [
    //           RichText(
    //             text: TextSpan(
    //               text: '데이터를 초기화 하시겠습니까?\n\n',
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.black,
    //                 fontSize: Responsive.height20,
    //                 fontFamily: AppFonts.japaneseFont,
    //               ),
    //               children: [
    //                 TextSpan(
    //                   text: '일본어・한자・문법의 데이터가\n 대량 수정 및 추가 되었습니다.\n\n',
    //                   children: const [
    //                     TextSpan(text: '수정・추가된 데이터로 학습하려면 종각앱의 데이터를 '),
    //                     TextSpan(
    //                       text: '1회',
    //                       style: TextStyle(
    //                           color: Colors.red, fontWeight: FontWeight.bold),
    //                     ),
    //                     TextSpan(
    //                         text: ' 초기화할 필요가 있습니다.\n\n데이터를 초기화하시겠습니까? (권장)')
    //                   ],
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.w100,
    //                     fontSize: Responsive.height16,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           SizedBox(height: Responsive.height10),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               TextButton(
    //                   onPressed: () {
    //                     return Get.back(result: true);
    //                   },
    //                   child: Text(
    //                     '네',
    //                     style: TextStyle(
    //                       color: AppColors.mainBordColor,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   )),
    //               SizedBox(width: Responsive.width10),
    //               TextButton(
    //                 onPressed: () {
    //                   return Get.back(result: false);
    //                 },
    //                 child: Text(
    //                   '아니요',
    //                   style: TextStyle(
    //                     color: AppColors.mainBordColor,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    //   if (a!) {
    //     // LocalReposotiry.putAllDataUpdate(true);
    //     settingController.allDataDelete();
    //   } else {
    //     bool secondQuestion = await Get.dialog(
    //         barrierDismissible: false,
    //         AlertDialog(
    //           content: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               RichText(
    //                 text: TextSpan(
    //                   text: '정말 초기화를 안하시게습니까?\n\n',
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.black,
    //                     fontSize: Responsive.height20,
    //                     fontFamily: AppFonts.japaneseFont,
    //                   ),
    //                   children: [
    //                     TextSpan(
    //                       text:
    //                           '초기화를 하면 더 정학하고 많은 예시로 학습할 수 있습니다.\n\n그래도 초기화를 안하시겠습니까?',
    //                       style: TextStyle(
    //                         fontWeight: FontWeight.w100,
    //                         fontSize: Responsive.height16,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               SizedBox(height: Responsive.height10),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.end,
    //                 children: [
    //                   TextButton(
    //                       onPressed: () {
    //                         return Get.back(result: true);
    //                       },
    //                       child: Text(
    //                         '초기화 할게요',
    //                         style: TextStyle(
    //                           color: AppColors.mainBordColor,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       )),
    //                   SizedBox(width: Responsive.width10),
    //                   TextButton(
    //                     onPressed: () {
    //                       return Get.back(result: false);
    //                     },
    //                     child: Text(
    //                       '그래도 안해요',
    //                       style: TextStyle(
    //                         color: AppColors.mainBordColor,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ));

    //     if (secondQuestion) {
    //       settingController.allDataDelete();
    //     } else {
    //       // LocalReposotiry.putAllDataUpdate(false);
    //     }
    //   }

    //   LocalReposotiry.putIsNeedUpdateAllData(false);
    // }
  }

  @override
  void initState() {
    Get.put(TtsController());
    super.initState();
    FlutterLocalNotification.init();
    // initNotification();
    setting();
    selectedCategoryIndex = LocalReposotiry.getBasicOrJlptOrMy();
    pageController = PageController(initialPage: selectedCategoryIndex);
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());

    return StreamBuilder<String>(
      stream: streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == 'HELLOWOLRD') {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                Get.to(() => const NotificaionScreen());
              },
            );
          }
        }

        return Scaffold(
          resizeToAvoidBottomInset: false,
          key: homeController.scaffoldKey,
          endDrawer: _endDrawer(),
          body: _body(context, homeController),
          bottomNavigationBar: const GlobalBannerAdmob(),
        );
      },
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
    selectedCategoryIndex = LocalReposotiry.putBasicOrJlptOrMy(index);
    setState(() {});
  }

  Widget _body(BuildContext context, HomeController homeController) {
    return SafeArea(
        child: Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
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
                const NewSearchWidget(),
                const Spacer(flex: 1),
                StudyCategoryNavigator(
                  onTap: (index) {
                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  currentPageIndex: selectedCategoryIndex,
                ),
                const Spacer(flex: 1),
                Expanded(
                  flex: 25,
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
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

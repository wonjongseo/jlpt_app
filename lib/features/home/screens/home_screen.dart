import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';

import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/commonDialog.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/custom_snack_bar.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/string.dart';
import 'package:japanese_voca/features/home/services/home_controller.dart';
import 'package:japanese_voca/features/home/widgets/home_screen_body.dart';
import 'package:japanese_voca/features/home/widgets/study_category_navigator.dart';
import 'package:japanese_voca/features/home/widgets/welcome_widget.dart';
import 'package:japanese_voca/features/search/widgets/search_widget.dart';
import 'package:japanese_voca/features/setting/services/setting_controller.dart';
import 'package:japanese_voca/notification/notification.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/appReviewRequest.dart';
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

    await setAppReviewRequest();
  }

  Future<void> setAppReviewRequest() async {
    AppReviewRequest.checkReviewRequest();
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
      bool isKeyBoardActive =
          await CommonDialog.askSetSubjectQuestionOfJlptTestDialog();

      if (isKeyBoardActive) {
        if (!settingController.isTestKeyBoard) {
          settingController.flipTestKeyBoard();
        }
      } else {
        if (settingController.isTestKeyBoard) {
          settingController.flipTestKeyBoard();
        }
      }

      showSnackBar(
        AppString.finishSettingMgs.tr,
        duration: const Duration(seconds: 4),
      );
    }
    // TODO 살리기
    bool isNeedUpdateAllData = LocalReposotiry.getIsNeedUpdateAllData();

    // await CommonDialog.askToDeleteAllDataForUpdateDatas();
    if (isNeedUpdateAllData) {
      bool a = await CommonDialog.askToDeleteAllDataForUpdateDatas();
      if (a) {
        // LocalReposotiry.putAllDataUpdate(true);
        settingController.allDataDelete();
      } else {
        bool secondQuestion = await CommonDialog.askToDeleteAllDataOneMore();

        if (secondQuestion) {
          settingController.allDataDelete();
        } else {
          // LocalReposotiry.putAllDataUpdate(false);
        }
      }

      LocalReposotiry.putIsNeedUpdateAllData(false);
    }
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(
              flex: 2,
            ),
            Column(
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
                      AppString.setting.tr,
                      style: TextStyle(
                        fontFamily: AppFonts.nanumGothic,
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.width14,
                        color: AppColors.scaffoldBackground,
                      ),
                    ),
                  ),
                ),
                // if (!kReleaseMode)
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
                      AppString.initDatas.tr,
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
            const Spacer(
              flex: 2,
            ),
            ListTile(
              leading: const Icon(Icons.mail),
              subtitle: AutoSizeText(
                AppString.tipOffMessage.tr,
                style: TextStyle(
                  fontFamily: AppFonts.nanumGothic,
                  fontSize: Responsive.width14,
                  color: AppColors.scaffoldBackground,
                ),
                maxLines: 1,
              ),
              title: TextButton(
                onPressed: () async {
                  // Get.back();

//                   String body = """

// ⭐️ [희망 기능 제보]

// ==========================

// ⭐️ [버그・오류 제보]

// 🔸 버그・오류 페이지 :
//    예) 일본어 학습장 페이지 또는 나만의 단어장 페이지

// 🔸 버그・오류 내용 :
//    예) 나만의 단어장에서 단어 추가를 하면 에러 발생

// ==========================

// ▪️이미지를 함께 첨부해주시면 버그・오류를 수정하는데 큰 도움이 됩니다!!▪️
//                   """;
                  final Email email = Email(
                    body: AppString.reportMsgContect.tr,
                    subject:
                        '[${AppString.appName.tr}] ${AppString.fnOrErorreport.tr}',
                    recipients: ['visionwill3322@gmail.com'],
                    isHTML: false,
                  );
                  try {
                    await FlutterEmailSender.send(email);
                  } catch (e) {
                    bool result = await CommonDialog.errorNoEnrolledEmail();
                    if (result) {
                      copyWord('visionwill3322@gmail.com');
                    }
                  }
                },
                child: Text(
                  AppString.fnOrErorreport.tr,
                  style: TextStyle(
                    fontFamily: AppFonts.nanumGothic,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.width14,
                    color: AppColors.scaffoldBackground,
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1),
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

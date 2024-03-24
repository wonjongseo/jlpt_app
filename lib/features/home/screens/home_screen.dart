import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/1.new_app/new_study/components/search_widget.dart';
import 'package:japanese_voca/features/home/widgets/home_screen_body.dart';
import 'package:japanese_voca/features/home/widgets/study_category_navigator.dart';
import 'package:japanese_voca/features/home/widgets/welcome_widget.dart';
import 'package:japanese_voca/features/home/services/home_controller.dart';

import '../../../common/admob/banner_ad/global_banner_admob.dart';
import '../../../config/colors.dart';
import '../../../config/theme.dart';
import '../../how_to_user/screen/how_to_use_screen.dart';
import '../../setting/screens/setting_screen.dart';

const String HOME_PATH = '/home2';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  KindOfStudy kindOfStudy = KindOfStudy.JLPT;
  late PageController pageController;
  int selectedCategoryIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
        key: homeController.scaffoldKey,
        endDrawer: _endDrawer(),
        body: _body(context, homeController),
        bottomNavigationBar: const GlobalBannerAdmob());
  }

  Drawer _endDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text(
              '모두 일본어 공부 화이팅 !',
              style: TextStyle(
                color: AppColors.scaffoldBackground,
                fontFamily: AppFonts.nanumGothic,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: TextButton(
              onPressed: () {
                Get.back();
                Get.to(() => const HowToUseScreen());
              },
              child: const Text(
                '앱 설명 보기',
                style: TextStyle(
                  fontFamily: AppFonts.nanumGothic,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
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
              child: const Text(
                '설정 페이지',
                style: TextStyle(
                  fontFamily: AppFonts.nanumGothic,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
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
              child: const Text(
                '데이터 초기화',
                style: TextStyle(
                  fontFamily: AppFonts.nanumGothic,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.scaffoldBackground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPageChanged(int index) {
    selectedCategoryIndex = index;
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
            icon: const Icon(Icons.settings),
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
                Expanded(
                  flex: 25,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: 3,
                    onPageChanged: onPageChanged,
                    itemBuilder: (context, index) {
                      // return Text(index.toString());
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

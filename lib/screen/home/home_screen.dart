import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:japanese_voca/ad_controller.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_contrainer.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/screen/home/components/welcome_widget.dart';
import 'package:japanese_voca/screen/kangi/home_kangi_screen.dart';
import 'package:japanese_voca/screen/home/services/home_tutorial_service.dart';
import 'package:japanese_voca/screen/jlpt/home_jlpt_level_sceen.dart';
import 'package:japanese_voca/screen/home/grammar_level_screen.dart';
import '../../common/admob/banner_ad/banner_ad_controller.dart';
import '../my_voca/home_my_voca_screen.dart';

// ignore: constant_identifier_names
const String HOME_PATH = '/home';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  late bool isSeenTutorial;
  // ignore: avoid_init_to_null
  late HomeTutorialService? homeTutorialService = null;
  AdController adController = Get.find<AdController>();
  BannerAdController adUnitController = Get.find<BannerAdController>();
  @override
  initState() {
    super.initState();

    isSeenTutorial = LocalReposotiry.isSeenHomeTutorial();

    if (!isSeenTutorial) {
      homeTutorialService = HomeTutorialService();
      homeTutorialService?.initTutorial();
      homeTutorialService?.showTutorial(context);
    }
  }

  List<Widget> items = [
    Container(), // HomeJlptLevelSceen
    const HomeGrammarScreen(),
    const HomeHangulScreen(),
    const HomeMyVocaSceen(),
  ];

  void changePage(int page) {
    currentPage = page;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!adUnitController.loadingHomepageBanner) {
      adUnitController.loadingHomepageBanner = true;
      adUnitController.createHomepageBanner();
    }
    return Column(
      children: [
        Expanded(
          child: Scaffold(
            extendBody: true,
            bottomNavigationBar: _bottomNavigationBar(),
            body: _body(),
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

  SafeArea _body() {
    return SafeArea(
      child: Column(
        children: [
          WelcomeWidget(settingKey: homeTutorialService?.settingKey),
          currentPage == 0
              ? HomeJlptLevelSceen(
                  jlptN1Key: homeTutorialService?.jlptN1Key,
                  isSeenHomeTutorial: isSeenTutorial,
                )
              : items[currentPage],
        ],
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentPage,
      type: BottomNavigationBarType.fixed,
      onTap: changePage,
      items: [
        const BottomNavigationBarItem(
            icon: Text(
              '단어',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Text(
              key: homeTutorialService?.grammarKey,
              '문법',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Text(
              key: homeTutorialService?.kangiKey,
              '한자',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Text(
              key: homeTutorialService?.myVocaKey,
              'MY',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            label: ''),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:japanese_voca/ad_controller.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/screen/home/components/welcome_widget.dart';
import 'package:japanese_voca/screen/kangi/home_kangi_screen.dart';
import 'package:japanese_voca/screen/home/services/home_tutorial_service.dart';
import 'package:japanese_voca/screen/jlpt/home_jlpt_level_sceen.dart';
import 'package:japanese_voca/screen/home/grammar_level_screen.dart';
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

  AdController adUnitController = Get.find<AdController>();
  @override
  initState() {
    super.initState();
    adUnitController.createHomepageBanner();

    isSeenTutorial = LocalReposotiry.isSeenHomeTutorial();
    if (!isSeenTutorial) {
      homeTutorialService = HomeTutorialService();
      homeTutorialService?.initTutorial();
      homeTutorialService?.showTutorial(context);
    }
  }

  List<Widget> items = [
    Container(),
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
    if (!adUnitController.loadingBanner) {
      adUnitController.loadingBanner = true;
      adUnitController.createHomepageBanner();
    }
    return GetBuilder<AdController>(
      builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: Scaffold(
                extendBody: true,
                bottomNavigationBar: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BottomNavigationBar(
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
                    ),
                  ],
                ),
                body: SafeArea(
                  // 앱 설명
                  child: Column(
                    children: [
                      WelcomeWidget(
                          settingKey: homeTutorialService?.settingKey),
                      currentPage == 0
                          ? HomeJlptLevelSceen(
                              jlptN1Key: homeTutorialService?.jlptN1Key,
                              isSeenHomeTutorial: isSeenTutorial)
                          : items[currentPage],
                    ],
                  ),
                ),
              ),
            ),
            if (adUnitController.homepageBanner != null)
              SizedBox(
                // color: Colors.green,
                width: adUnitController.homepageBanner!.size.width.toDouble(),
                height: adUnitController.homepageBanner!.size.height.toDouble(),
                child: AdWidget(
                  ad: adUnitController.homepageBanner!,
                ),
              ),
          ],
        );
      },
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/1.new_app/new_study/components/search_widget.dart';
import 'package:japanese_voca/1.new_app/new_study_category/new_study_category_screen.dart';
import 'package:japanese_voca/features/grammar_step/screens/grammar_step_screen.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/screens/book_step_screen.dart';
import 'package:japanese_voca/features/my_voca/screens/my_voca_sceen.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';
import 'package:japanese_voca/features/home/services/home_controller.dart';
import 'package:japanese_voca/features/home/services/home_tutorial_service.dart';
import 'package:japanese_voca/features/home/widgets/users_word_button.dart';
import 'package:japanese_voca/features/home/widgets/welcome_widget.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';

import '../../../common/admob/banner_ad/global_banner_admob.dart';
import '../../../common/widget/part_of_information.dart';
import '../../../config/colors.dart';
import '../../../config/theme.dart';
import '../../how_to_user/screen/how_to_use_screen.dart';
import '../../setting/screens/setting_screen.dart';

const String HOME_PATH = '/home2';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
        ),
        backgroundColor: Colors.grey.shade100,
        key: homeController.scaffoldKey,
        endDrawer: _endDrawer(),
        body: _body2(context, homeController),
        bottomNavigationBar: const GlobalBannerAdmob());
  }

  Drawer _endDrawer() {
    return Drawer(
      // backgroundColor: Colors.transparent,
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

  Widget _bottomNavigationBar2() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BottomNavigationBar(
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          // iconSize: ,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          onTap: (value) {
            print('value : ${value}');
          },
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.book),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '',
            ),
          ],
        ),
        const GlobalBannerAdmob()
      ],
    );
  }

  Widget _body2(BuildContext context, HomeController homeController) {
    TextEditingController textEditingController = TextEditingController();
    return SafeArea(
        child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Hi, Everyone',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'What would you like to train today?\nSearch below.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                )
              ],
            ),
            const SizedBox(height: 40),
            const NewSearchWidget(),
            const SizedBox(height: 60),
            Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'STDUYING',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GetBuilder<UserController>(builder: (userController) {
                    return Row(
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (index) => WWW(
                              // Studying Card
                              title: 'N${index + 1}',
                              onTap: () =>
                                  Get.to(() => SubHomeScreen(index: index)),
                              body: Column(
                                children: [
                                  CategoryAndProgress(
                                    caregory: '단어',
                                    curCnt: userController
                                        .user.currentJlptWordScroes[index],
                                    totlaCnt: userController
                                        .user.jlptWordScroes[index],
                                  ),
                                  if (index < 3)
                                    CategoryAndProgress(
                                      caregory: '문법',
                                      curCnt: userController
                                          .user.currentGrammarScores[index],
                                      totlaCnt: userController
                                          .user.grammarScores[index],
                                    ),
                                  CategoryAndProgress(
                                    caregory: '한자',
                                    curCnt: userController
                                        .user.currentKangiScores[index],
                                    totlaCnt:
                                        userController.user.kangiScores[index],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            WWW(
                                onTap: () {
                                  Get.toNamed(
                                    MY_VOCA_PATH,
                                    arguments: {
                                      MY_VOCA_TYPE: MyVocaEnum.MY_WORD
                                    },
                                  );
                                },
                                title: 'MY Words',
                                titleSize: 23,
                                body: Text(
                                    'SAVED ${userController.user.countMyWords}')),
                            WWW(
                              onTap: () {
                                Get.toNamed(
                                  MY_VOCA_PATH,
                                  arguments: {
                                    MY_VOCA_TYPE: MyVocaEnum.WRONG_WORD,
                                  },
                                );
                              },
                              title: 'Wrong Words',
                              titleSize: 23,
                              body: Text(
                                  'WRONG ${userController.user.yokumatigaeruMyWords}'),
                            )
                          ],
                        )
                      ],
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  SafeArea _body(BuildContext context, HomeController homeController) {
    if (!homeController.isSeenTutorial) {
      homeController.homeTutorialService = HomeTutorialService();
      homeController.homeTutorialService?.initTutorial();
      homeController.homeTutorialService?.showTutorial(context);
      homeController.isSeenTutorial = true;
    }

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: WelcomeWidget(
              isUserPremieum: homeController.userController.isUserPremieum(),
              settingKey: homeController.homeTutorialService?.settingKey,
              scaffoldKey: homeController.scaffoldKey,
            ),
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
                            onPressed: () => homeController
                                .goToJlptStudy((index + 1).toString()),
                            text: 'JLPT 단어',
                            curCnt: userController
                                .user.currentJlptWordScroes[index],
                            totalCnt: userController.user.jlptWordScroes[index],
                            edgeInsets: edgeInsets,
                            homeTutorialService:
                                homeController.homeTutorialService,
                          ),
                          if (index < 3)
                            PartOfInformation(
                              onPressed: () => Get.to(() => GrammarStepSceen(
                                  level: (index + 1).toString())),
                              text: 'JLPT 문법',
                              curCnt: userController
                                  .user.currentGrammarScores[index],
                              totalCnt:
                                  userController.user.grammarScores[index],
                              edgeInsets: edgeInsets,
                            ),
                          PartOfInformation(
                            onPressed: () => homeController
                                .goToKangiScreen((index + 1).toString()),
                            text: 'JLPT 한자',
                            curCnt:
                                userController.user.currentKangiScores[index],
                            totalCnt: userController.user.kangiScores[index],
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
              child: GetBuilder<UserController>(builder: (userController) {
                return Column(
                  children: [
                    Expanded(
                      child: FadeInLeft(
                        child: UserWordButton(
                          textKey:
                              homeController.homeTutorialService?.myVocaKey,
                          text: '나만의 단어장',
                          savedWordCount: userController.user.countMyWords,
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
                          savedWordCount:
                              userController.user.yokumatigaeruMyWords,
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
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GetBuilder<HomeController>(builder: (homeController) {
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
              // BottomNavigationBarItem(
              //     icon: Container(
              //       padding: const EdgeInsets.all(14),
              //       decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: homeController.currentPageIndex == 4
              //               ? AppColors.primaryColor
              //               : AppColors.whiteGrey),
              //       child: const Text(
              //         '왕초보',
              //         style: TextStyle(
              //           color: AppColors.scaffoldBackground,
              //         ),
              //       ),
              //     ),
              //     label: ''),
            ],
          );
        }),
        const GlobalBannerAdmob()
      ],
    );
  }
}

class WWW extends StatelessWidget {
  // Studying Card
  const WWW({
    super.key,
    required this.onTap,
    required this.title,
    required this.body,
    this.titleSize = 30,
  });
  final VoidCallback onTap;
  final String title;
  final Widget body;

  final double titleSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          child: Container(
            width: 220,
            height: 250,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 16, right: 12, left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: titleSize,
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                  body
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryAndProgress extends StatelessWidget {
  final String caregory;
  final int curCnt;
  final int totlaCnt;
  const CategoryAndProgress({
    super.key,
    required this.caregory,
    required this.curCnt,
    required this.totlaCnt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            caregory,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(width: 10),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: curCnt.toString(),
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const TextSpan(text: ' / '),
                TextSpan(
                  text: totlaCnt.toString(),
                ),
              ],
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SubHomeScreen extends StatefulWidget {
  const SubHomeScreen({super.key, required this.index});
  final int index;
  @override
  State<SubHomeScreen> createState() => _SubHomeScreenState();
}

class _SubHomeScreenState extends State<SubHomeScreen> {
  late PageController pageController;
  HomeController homeController = Get.find<HomeController>();
  int selectedCategoryIndex = 0;
  onPageChanged(int newPage) {
    selectedCategoryIndex = newPage;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedCategoryIndex);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  Widget getBodys(CategoryEnum categoryEnum) {
    String level = (widget.index + 1).toString();
    switch (categoryEnum) {
      case CategoryEnum.Japaneses:
        Get.put(JlptStepController(level: level));
        return BookStepScreen(level: level, isJlpt: true);
      case CategoryEnum.Grammars:
        if (widget.index >= 3) {
          return const Center(
            child: Text('Not Yet...'),
          );
        }
        return GrammarStepSceen(level: level);
      case CategoryEnum.Kangis:
        return BookStepScreen(
          level: level,
          isJlpt: false,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JLPT N${widget.index + 1}',
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.grey.shade100,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const NewSearchWidget(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: List.generate(
                      CategoryEnum.values.length,
                      (index) => TextButton(
                        onPressed: () {
                          pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: selectedCategoryIndex == index
                                ? Border(
                                    bottom: BorderSide(
                                      width: 3,
                                      color: Colors.cyan.shade700,
                                    ),
                                  )
                                : null,
                          ),
                          child: Text(
                            'All ${CategoryEnum.values[index].name}',
                            style: TextStyle(
                              color: selectedCategoryIndex == index
                                  ? Colors.black
                                  : Colors.grey.shade700,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: CategoryEnum.values.length,
                    controller: pageController,
                    onPageChanged: onPageChanged,
                    itemBuilder: (context, index) {
                      return getBodys(CategoryEnum.values[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }
}

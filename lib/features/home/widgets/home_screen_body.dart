import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:japanese_voca/features/basic/hiragana/models/hiragana.dart';
import 'package:japanese_voca/features/basic/hiragana/screens/hiragana_screen.dart';
import 'package:japanese_voca/features/jlpt_home/screens/jlpt_home_screen.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:kanji_drawing_animation/kanji_drawing_animation.dart';

import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/home/screens/home_screen.dart';
import 'package:japanese_voca/features/home/widgets/level_category_card.dart';
import 'package:japanese_voca/features/home/widgets/study_category_and_progress.dart';
import 'package:japanese_voca/features/my_voca/screens/my_voca_sceen.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

enum KindOfStudy { BASIC, JLPT, MY }

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key, required this.index});

  final int index;

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> bodys = const [
    BasicCard(),
    JLPTCards(),
    MyCards(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      return bodys[widget.index];
    });
  }
}

class JLPTCards extends StatefulWidget {
  const JLPTCards({super.key});

  @override
  State<JLPTCards> createState() => _JLPTCardsState();
}

class _JLPTCardsState extends State<JLPTCards> {
  late PageController pageController;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentIndex = LocalReposotiry.getBasicOrJlptOrMyDetail(KindOfStudy.JLPT);
    pageController =
        PageController(initialPage: _currentIndex, viewportFraction: 0.75);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();

    return PageView.builder(
      controller: pageController,
      itemCount: 5,
      padEnds: false,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        var scale = _currentIndex == index ? 1.0 : 0.8;

        return TweenAnimationBuilder(
          tween: Tween(begin: scale, end: scale),
          duration: const Duration(milliseconds: 350),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: LevelCategoryCard(
                titleSize: Responsive.height10 * 3,
                title: 'N${index + 1}',
                onTap: () {
                  Get.to(() => JlptHomeScreen(index: index));
                  return;
                  if (index == _currentIndex) {
                    Get.to(() => JlptHomeScreen(index: index));
                  } else if (index > _currentIndex) {
                    pageController.animateToPage(_currentIndex + 1,
                        duration: const Duration(microseconds: 1000),
                        curve: Curves.easeInOut);
                  } else {
                    pageController.animateToPage(_currentIndex - 1,
                        duration: const Duration(microseconds: 1000),
                        curve: Curves.easeInOut);
                  }
                },
                body: Column(
                  children: [
                    StudyCategoryAndProgress(
                      caregory: '단어',
                      curCnt: userController.user.currentJlptWordScroes[index],
                      totalCnt: userController.user.jlptWordScroes[index],
                    ),
                    if (index < 3)
                      StudyCategoryAndProgress(
                        caregory: '문법',
                        curCnt: userController.user.currentGrammarScores[index],
                        totalCnt: userController.user.grammarScores[index],
                      ),
                    StudyCategoryAndProgress(
                      caregory: '한자',
                      curCnt: userController.user.currentKangiScores[index],
                      totalCnt: userController.user.kangiScores[index],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void onPageChanged(v) {
    _currentIndex =
        LocalReposotiry.putBasicOrJlptOrMyDetail(KindOfStudy.JLPT, v);
    setState(() {});
  }
}

class MyCards extends StatefulWidget {
  const MyCards({
    super.key,
  });

  @override
  State<MyCards> createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  late PageController pageController;
  int _currentIndex = 0;
  UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    _currentIndex = LocalReposotiry.getBasicOrJlptOrMyDetail(KindOfStudy.MY);
    pageController =
        PageController(initialPage: _currentIndex, viewportFraction: 0.75);

    bodys = [
      LevelCategoryCard(
          onTap: () {
            Get.toNamed(
              MY_VOCA_PATH,
              arguments: {MY_VOCA_TYPE: MyVocaEnum.MY_WORD},
            );
          },
          title: 'MY Words',
          titleSize: Responsive.height10 * 2.3,
          body: Text('SAVED ${userController.user.countMyWords}')),
      LevelCategoryCard(
        onTap: () {
          Get.toNamed(
            MY_VOCA_PATH,
            arguments: {
              MY_VOCA_TYPE: MyVocaEnum.WRONG_WORD,
            },
          );
        },
        title: 'Wrong Words',
        titleSize: Responsive.height10 * 2.3,
        body: Text('WRONG ${userController.user.yokumatigaeruMyWords}'),
      )
    ];
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  List<Widget> bodys = [];
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: bodys.length,
      padEnds: false,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        var scale = _currentIndex == index ? 1.0 : 0.8;

        return TweenAnimationBuilder(
          tween: Tween(begin: scale, end: scale),
          duration: const Duration(milliseconds: 350),
          builder: (context, value, child) {
            return Transform.scale(scale: value, child: bodys[index]);
          },
        );
      },
    );
  }

  void onPageChanged(v) {
    _currentIndex = LocalReposotiry.putBasicOrJlptOrMyDetail(KindOfStudy.MY, v);
    setState(() {});
  }
}

class BasicCard extends StatefulWidget {
  const BasicCard({super.key});

  @override
  State<BasicCard> createState() => _BasicCardState();
}

class _BasicCardState extends State<BasicCard> {
  late PageController pageController;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentIndex = LocalReposotiry.getBasicOrJlptOrMyDetail(KindOfStudy.BASIC);
    pageController =
        PageController(initialPage: _currentIndex, viewportFraction: 0.75);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(v) {
    _currentIndex =
        LocalReposotiry.putBasicOrJlptOrMyDetail(KindOfStudy.BASIC, v);
    setState(() {});
  }

  List<Widget> bodys = [
    LevelCategoryCard(
        onTap: () {
          Get.to(() => const HiraganaScreen(category: 'hiragana'));
        },
        title: 'Hiragana',
        titleSize: Responsive.height10 * 2.3,
        body: const Text('Let\'s study Hiragana!')),
    LevelCategoryCard(
      onTap: () {
        Get.to(() => const HiraganaScreen(category: 'katakana'));
      },
      title: 'Katakana',
      titleSize: Responsive.height10 * 2.3,
      body: const Text('Let\'s study Katakana!'),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: bodys.length,
      padEnds: false,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        var scale = _currentIndex == index ? 1.0 : 0.8;

        return TweenAnimationBuilder(
          tween: Tween(begin: scale, end: scale),
          duration: const Duration(milliseconds: 350),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: bodys[index],
            );
          },
        );
      },
    );
  }
}

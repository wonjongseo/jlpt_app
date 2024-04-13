import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/animated_circular_progressIndicator.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/basic/hiragana/screens/hiragana_screen.dart';
import 'package:japanese_voca/features/jlpt_home/screens/jlpt_home_screen.dart';
import 'package:japanese_voca/repository/local_repository.dart';

import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/features/home/widgets/level_category_card.dart';
import 'package:japanese_voca/features/home/widgets/study_category_and_progress.dart';
import 'package:japanese_voca/features/my_voca/screens/my_voca_sceen.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

enum KindOfStudy { BASIC, JLPT, MY }

extension KindOfStudyExtension on KindOfStudy {
  String get value {
    switch (this) {
      case KindOfStudy.BASIC:
        return '왕초보';
      case KindOfStudy.JLPT:
        return 'JLPT';
      case KindOfStudy.MY:
        return '나만의';
    }
  }
}

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
  int _currentIndex = 0;

  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    _currentIndex = LocalReposotiry.getBasicOrJlptOrMyDetail(KindOfStudy.JLPT);
  }

  @override
  void dispose() {
    LocalReposotiry.putBasicOrJlptOrMyDetail(KindOfStudy.JLPT, _currentIndex);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();

    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        disableCenter: true,
        viewportFraction: 0.75,
        enableInfiniteScroll: false,
        initialPage: _currentIndex,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          _currentIndex = index;
        },
        scrollDirection: Axis.horizontal,
      ),
      items: List.generate(5, (index) {
        return LevelCategoryCard(
          titleSize: Responsive.height10 * 3,
          title: 'N${index + 1}',
          onTap: () {
            LocalReposotiry.putBasicOrJlptOrMyDetail(
                KindOfStudy.JLPT, _currentIndex);
            Get.to(() => JlptHomeScreen(index: index));
            return;
          },
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
          foot: Text(
            'JLPT N${index + 1} 종합 단어장',
            style: TextStyle(
              fontFamily: 'GMarket',
              fontWeight: FontWeight.w500,
              fontSize: Responsive.width17,
            ),
          ),
        );
      }),
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
  CarouselController carouselController = CarouselController();
  int _currentIndex = 0;
  // UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    _currentIndex = LocalReposotiry.getBasicOrJlptOrMyDetail(KindOfStudy.MY);

    bodys = [];
  }

  @override
  void dispose() {
    super.dispose();
    _currentIndex =
        LocalReposotiry.putBasicOrJlptOrMyDetail(KindOfStudy.MY, _currentIndex);
  }

  List<Widget> bodys = [];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      return CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            disableCenter: true,
            viewportFraction: 0.75,
            enableInfiniteScroll: false,
            initialPage: _currentIndex,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              _currentIndex = LocalReposotiry.putBasicOrJlptOrMyDetail(
                  KindOfStudy.MY, index);
            },
            scrollDirection: Axis.horizontal,
          ),
          items: [
            LevelCategoryCard(
              onTap: () {
                LocalReposotiry.putBasicOrJlptOrMyDetail(KindOfStudy.MY, 0);
                Get.toNamed(
                  MY_VOCA_PATH,
                  arguments: {
                    MY_VOCA_TYPE: MyVocaEnum.YOKUMATIGAERU_WORD,
                  },
                );
              },
              title: '나만의 단어장 1',
              extraInfo: RichText(
                text: TextSpan(
                  text: '저장된 단어: ',
                  children: [
                    TextSpan(
                      text: "${userController.user.yokumatigaeruMyWords}",
                      style: TextStyle(
                        color: AppColors.mainBordColor,
                      ),
                    ),
                    const TextSpan(text: "개")
                  ],
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: "GMarket"),
                ),
              ),
              titleSize: Responsive.height10 * 2.3,
              foot: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '종각 앱에서 저장한 단어들을\n학습하는 단어장',
                  style: TextStyle(
                    fontFamily: "GMarket",
                    fontSize: Responsive.width15,
                  ),
                ),
              ),
            ),
            LevelCategoryCard(
                onTap: () {
                  LocalReposotiry.putBasicOrJlptOrMyDetail(KindOfStudy.MY, 1);
                  Get.toNamed(
                    MY_VOCA_PATH,
                    arguments: {MY_VOCA_TYPE: MyVocaEnum.MANUAL_SAVED_WORD},
                  );
                },
                title: '나만의 단어장 2',
                titleSize: Responsive.height10 * 2.3,
                extraInfo: RichText(
                  text: TextSpan(
                    text: '저장된 단어: ',
                    children: [
                      TextSpan(
                        text: "${userController.user.manualSavedMyWords}",
                        style: TextStyle(
                          color: AppColors.mainBordColor,
                        ),
                      ),
                      const TextSpan(text: "개")
                    ],
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: "GMarket"),
                  ),
                ),
                foot: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '사용자가 직접 저장한 단어들을\n학습하는 단어장',
                    style: TextStyle(
                      fontFamily: "GMarket",
                      fontSize: Responsive.width15,
                    ),
                  ),
                )),
          ]);
    });
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
  CarouselController carouselController = CarouselController();
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentIndex = LocalReposotiry.getBasicOrJlptOrMyDetail(KindOfStudy.BASIC);
  }

  @override
  void dispose() {
    super.dispose();
    LocalReposotiry.putBasicOrJlptOrMyDetail(KindOfStudy.BASIC, _currentIndex);
  }

  void onPageChanged(v) {
    _currentIndex =
        LocalReposotiry.putBasicOrJlptOrMyDetail(KindOfStudy.BASIC, v);
    setState(() {});
  }

  List<Widget> bodys = [
    LevelCategoryCard(
      onTap: () {
        LocalReposotiry.putBasicOrJlptOrMyDetail(KindOfStudy.BASIC, 0);
        Get.to(() => const HiraganaScreen(category: 'hiragana'));
      },
      title: '히라가나 단어장',
      titleSize: Responsive.height10 * 2.3,
      foot: Text(
        '왕초보를 위한 히라가나 단어장',
        style: TextStyle(fontSize: Responsive.width16),
      ),
    ),
    LevelCategoryCard(
      onTap: () {
        LocalReposotiry.putBasicOrJlptOrMyDetail(KindOfStudy.BASIC, 1);
        Get.to(() => const HiraganaScreen(category: 'katakana'));
      },
      title: '카타카나 단어장',
      titleSize: Responsive.height10 * 2.3,
      foot: Text(
        '왕초보를 위한 카타카나 단어장',
        style: TextStyle(fontSize: Responsive.width16),
      ),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        disableCenter: true,
        viewportFraction: 0.75,
        enableInfiniteScroll: false,
        initialPage: _currentIndex,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          _currentIndex = LocalReposotiry.putBasicOrJlptOrMyDetail(
              KindOfStudy.BASIC, index);
        },
        scrollDirection: Axis.horizontal,
      ),
      items: List.generate(bodys.length, (index) {
        return bodys[index];
      }),
    );
  }
}

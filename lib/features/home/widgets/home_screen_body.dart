import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:japanese_voca/features/basic/hiragana/models/hiragana.dart';
import 'package:japanese_voca/features/basic/hiragana/screens/hiragana_screen.dart';
import 'package:japanese_voca/features/jlpt_home/screens/jlpt_home_screen.dart';
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
  const HomeScreenBody({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  List<Widget> bodys = const [
    BasicCard(),
    JLPTCards(),
    MyCards(),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GetBuilder<UserController>(builder: (userController) {
        return bodys[widget.index];
      }),
    );
  }
}

class JLPTCards extends StatelessWidget {
  const JLPTCards({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    return Row(
      children: List.generate(
        5,
        (index) => LevelCategoryCard(
          titleSize: Responsive.height10 * 3,
          title: 'N${index + 1}',
          onTap: () => Get.to(() => JlptHomeScreen(index: index)),
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
      ),
    );
  }
}

class MyCards extends StatelessWidget {
  const MyCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    return Row(
      children: [
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
      ],
    );
  }
}

class BasicCard extends StatelessWidget {
  const BasicCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LevelCategoryCard(
            onTap: () {
              Get.to(() => HiraganaScreen(hiraAndkatakana: hiraganas));
            },
            title: 'Hiragana',
            titleSize: Responsive.height10 * 2.3,
            body: const Text('Let\'s study Hiragana!')),
        LevelCategoryCard(
          onTap: () {
            Get.to(() => HiraganaScreen(hiraAndkatakana: katakana));
          },
          title: 'Katakana',
          titleSize: Responsive.height10 * 2.3,
          body: Text(''),
        )
      ],
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_book_step/jlpt_book_step_screen.dart';

import '../home/components/home_navigator_button.dart';

class HomeJlptLevelSceen extends StatefulWidget {
  const HomeJlptLevelSceen({
    super.key,
    required this.jlptN1Key,
    required this.isSeenHomeTutorial,
  });

  final GlobalKey? jlptN1Key;
  final bool isSeenHomeTutorial;
  @override
  State<HomeJlptLevelSceen> createState() => _HomeJlptLevelSceenState();
}

class _HomeJlptLevelSceenState extends State<HomeJlptLevelSceen> {
  void goTo(String index) {
    Get.to(
      () => JlptBookStepScreen(
        level: index,
        isJlpt: true,
      ),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.isSeenHomeTutorial) ...[
            FadeInLeft(
              child: HomeNaviatorButton(
                  jlptN1Key: widget.jlptN1Key,
                  text: 'N1 단어',
                  wordsCount: '3,221',
                  onTap: () => goTo('1')),
            ),
            FadeInLeft(
              delay: const Duration(milliseconds: 300),
              child: HomeNaviatorButton(
                wordsCount: '2,626',
                text: 'N2 단어',
                onTap: () => goTo('2'),
              ),
            ),
            FadeInLeft(
              delay: const Duration(milliseconds: 500),
              child: HomeNaviatorButton(
                wordsCount: '1,538',
                text: 'N3 단어',
                onTap: () => goTo('3'),
              ),
            ),
            FadeInLeft(
              delay: const Duration(milliseconds: 700),
              child: HomeNaviatorButton(
                wordsCount: '1,034',
                text: 'N4 단어',
                onTap: () => goTo('4'),
              ),
            ),
            FadeInLeft(
              delay: const Duration(milliseconds: 900),
              child: HomeNaviatorButton(
                wordsCount: '741',
                text: 'N5 단어',
                onTap: () => goTo('5'),
              ),
            ),
          ] else ...[
            HomeNaviatorButton(
                jlptN1Key: widget.jlptN1Key,
                text: 'N1 단어',
                wordsCount: '3,221',
                onTap: () => goTo('1')),
            HomeNaviatorButton(
              wordsCount: '2,626',
              text: 'N2 단어',
              onTap: () => goTo('2'),
            ),
            HomeNaviatorButton(
              wordsCount: '1,538',
              text: 'N3 단어',
              onTap: () => goTo('3'),
            ),
            HomeNaviatorButton(
              wordsCount: '1,034',
              text: 'N4 단어',
              onTap: () => goTo('4'),
            ),
            HomeNaviatorButton(
              wordsCount: '741',
              text: 'N5 단어',
              onTap: () => goTo('5'),
            ),
          ]
        ],
      ),
    );
  }
}
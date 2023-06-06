import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_book_step/jlpt_book_step_screen.dart';

import '../../user_controller2.dart';
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
      child: GetBuilder<UserController2>(builder: (userController2) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.isSeenHomeTutorial) ...[
              FadeInLeft(
                child: HomeNaviatorButton(
                    jlptN1Key: widget.jlptN1Key,
                    text: 'N1 단어',
                    totalProgressCount: userController2.user.jlptWordScroes[0],
                    currentProgressCount:
                        userController2.user.currentKangiScores[0],
                    onTap: () => goTo('1')),
              ),
              FadeInLeft(
                delay: const Duration(milliseconds: 300),
                child: HomeNaviatorButton(
                  totalProgressCount: userController2.user.jlptWordScroes[1],
                  currentProgressCount:
                      userController2.user.currentKangiScores[1],
                  text: 'N2 단어',
                  onTap: () => goTo('2'),
                ),
              ),
              FadeInLeft(
                delay: const Duration(milliseconds: 500),
                child: HomeNaviatorButton(
                  totalProgressCount: userController2.user.jlptWordScroes[2],
                  currentProgressCount: 1538,
                  // userController2.user.currentKangiScores[2],
                  text: 'N3 단어',
                  onTap: () => goTo('3'),
                ),
              ),
              FadeInLeft(
                delay: const Duration(milliseconds: 700),
                child: HomeNaviatorButton(
                  totalProgressCount: userController2.user.jlptWordScroes[3],
                  currentProgressCount:
                      userController2.user.currentKangiScores[3],
                  text: 'N4 단어',
                  onTap: () => goTo('4'),
                ),
              ),
              FadeInLeft(
                delay: const Duration(milliseconds: 900),
                child: HomeNaviatorButton(
                  totalProgressCount: userController2.user.jlptWordScroes[4],
                  currentProgressCount:
                      userController2.user.currentKangiScores[4],
                  text: 'N5 단어',
                  onTap: () => goTo('5'),
                ),
              ),
            ] else ...[
              HomeNaviatorButton(
                  jlptN1Key: widget.jlptN1Key,
                  text: 'N1 단어',
                  totalProgressCount: userController2.user.jlptWordScroes[0],
                  currentProgressCount:
                      userController2.user.currentKangiScores[0],
                  onTap: () => goTo('1')),
              HomeNaviatorButton(
                totalProgressCount: userController2.user.jlptWordScroes[1],
                text: 'N2 단어',
                onTap: () => goTo('2'),
                currentProgressCount:
                    userController2.user.currentKangiScores[1],
              ),
              HomeNaviatorButton(
                totalProgressCount: userController2.user.jlptWordScroes[2],
                text: 'N3 단어',
                onTap: () => goTo('3'),
                currentProgressCount: 1538,
                // userController2.user.currentKangiScores[2],
              ),
              HomeNaviatorButton(
                totalProgressCount: userController2.user.jlptWordScroes[3],
                text: 'N4 단어',
                onTap: () => goTo('4'),
                currentProgressCount:
                    userController2.user.currentKangiScores[3],
              ),
              HomeNaviatorButton(
                totalProgressCount: userController2.user.jlptWordScroes[4],
                text: 'N5 단어',
                onTap: () => goTo('5'),
                currentProgressCount:
                    userController2.user.currentKangiScores[4],
              ),
            ]
          ],
        );
      }),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_book_step/jlpt_book_step_screen.dart';
import 'package:japanese_voca/user_controller2.dart';

import '../home/components/home_navigator_button.dart';

class HomeHangulScreen extends StatefulWidget {
  const HomeHangulScreen({super.key});

  @override
  State<HomeHangulScreen> createState() => _HomeHangulScreenState();
}

class _HomeHangulScreenState extends State<HomeHangulScreen> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void goTo(String level) {
    Get.to(
      () => JlptBookStepScreen(
        level: level,
        isJlpt: false,
      ),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  int previousIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<UserController2>(builder: (userController2) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInLeft(
              child: HomeNaviatorButton(
                totalProgressCount: userController2.user.kangiScores[0],
                currentProgressCount:
                    userController2.user.currentKangiScores[0],
                text: 'N1급 한자',
                onTap: () => goTo('1'),
              ),
            ),
            FadeInLeft(
              delay: const Duration(milliseconds: 300),
              child: HomeNaviatorButton(
                totalProgressCount: userController2.user.kangiScores[1],
                currentProgressCount:
                    userController2.user.currentKangiScores[1],
                text: 'N2급 한자',
                onTap: () => goTo('2'),
              ),
            ),
            FadeInLeft(
              delay: const Duration(milliseconds: 500),
              child: HomeNaviatorButton(
                totalProgressCount: userController2.user.kangiScores[2],
                currentProgressCount:
                    userController2.user.currentKangiScores[2],
                text: 'N3급 한자',
                onTap: () => goTo('3'),
              ),
            ),
            FadeInLeft(
              delay: const Duration(milliseconds: 700),
              child: HomeNaviatorButton(
                totalProgressCount: userController2.user.kangiScores[3],
                currentProgressCount:
                    userController2.user.currentKangiScores[3],
                text: 'N4급 한자',
                onTap: () => goTo('4'),
              ),
            ),
            FadeInLeft(
              delay: const Duration(milliseconds: 900),
              child: HomeNaviatorButton(
                totalProgressCount: userController2.user.kangiScores[4],
                currentProgressCount:
                    userController2.user.currentKangiScores[4],
                text: 'N5급 한자',
                onTap: () => goTo('5'),
              ),
            ),
          ],
        );
      }),
    );
  }
}

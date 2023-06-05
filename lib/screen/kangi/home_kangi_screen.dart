import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_book_step/jlpt_book_step_screen.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInLeft(
            child: HomeNaviatorButton(
                text: 'N1급 한자', wordsCount: '948', onTap: () => goTo('1')),
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 300),
            child: HomeNaviatorButton(
                wordsCount: '693', text: 'N2급 한자', onTap: () => goTo('2')),
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 500),
            child: HomeNaviatorButton(
                wordsCount: '185', text: 'N3급 한자', onTap: () => goTo('3')),
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 700),
            child: HomeNaviatorButton(
                wordsCount: '37', text: 'N4급 한자', onTap: () => goTo('4')),
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 900),
            child: HomeNaviatorButton(
                wordsCount: '82', text: 'N5급 한자', onTap: () => goTo('5')),
          ),
        ],
      ),
    );
  }
}

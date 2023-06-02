import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/data/kangis_data.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_book_step/jlpt_book_step_screen.dart';

import 'components/hangul_navigation_button.dart';
import 'components/kangi_navigator.dart';

class HomeHangulScreen extends StatefulWidget {
  const HomeHangulScreen({super.key});

  @override
  State<HomeHangulScreen> createState() => _HomeHangulScreenState();
}

class _HomeHangulScreenState extends State<HomeHangulScreen> {
  late PageController pageController;
  late ScrollController scrollController;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void onPageChange(int value) {
    _currentPage = value;

    setState(() {});
  }

  void goTo(String hangul) {
    Get.to(
      () => JlptBookStepScreen(
        level: hangul,
        isJlpt: false,
      ),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  navigateScroll() {
    scrollController.animateTo(300,
        duration: const Duration(milliseconds: 150), curve: Curves.linear);
  }

  int previousIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: onPageChange,
              itemCount: hanguls.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return FadeInLeft(
                    child: HangulNaviationButton(
                      hangul: hanguls[index],
                      totlaHangulCount: hangulsLength[index],
                      onTap: () => goTo(hanguls[index]),
                    ),
                  );
                }
                if (6 == index && 6 > previousIndex) {
                  navigateScroll();
                }
                previousIndex = index;
                return HangulNaviationButton(
                  hangul: hanguls[index],
                  totlaHangulCount: hangulsLength[index],
                  onTap: () => goTo(hanguls[index]),
                );
              },
            ),
          ),
          const Spacer(),
          KangiNavigator(
            pageController: pageController,
            currentPage: _currentPage,
            scrollController: scrollController,
            navigateScroll: navigateScroll,
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

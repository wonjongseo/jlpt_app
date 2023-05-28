import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_book_step/jlpt_book_step_screen.dart';

import '../grammar/grammar_step_screen.dart';
import 'components/home_navigator_button.dart';

List<String> hanguls = [
  '가',
  '나',
  '다',
  '라',
  '마',
  '바',
  '사',
  '아',
  '자',
  '차',
  '카',
  '타',
  '파',
  '하'
];

class KangiHangulScreen extends StatefulWidget {
  const KangiHangulScreen({super.key});

  @override
  State<KangiHangulScreen> createState() => _KangiHangulScreenState();
}

class _KangiHangulScreenState extends State<KangiHangulScreen> {
  late PageController pageController;
  // Kangi
  int _currentPage = 0;
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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Expanded(
            // height: 150,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: onPageChange,
              itemCount: hanguls.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return FadeInLeft(
                    child: HangulButton(
                      hangul: hanguls[index],
                      onTap: () => goTo(hanguls[index]),
                    ),
                  );
                }
                return HangulButton(
                  hangul: hanguls[index],
                  onTap: () => goTo(hanguls[index]),
                );
              },
            ),
          ),
          const Spacer(),
          HangulNavigator(
            pageController: pageController,
            currentPage: _currentPage,
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

class HangulNavigator extends StatefulWidget {
  const HangulNavigator({
    super.key,
    required this.pageController,
    required int currentPage,
  }) : _currentPage = currentPage;

  final PageController pageController;
  final int _currentPage;

  @override
  State<HangulNavigator> createState() => _HangulNavigatorState();
}

class _HangulNavigatorState extends State<HangulNavigator> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  int previousIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(hanguls.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: InkWell(
                  onTap: () {
                    if (6 == index && 6 > previousIndex) {
                      scrollController.animateTo(300,
                          duration: const Duration(milliseconds: 150),
                          curve: Curves.linear);
                    }
                    widget.pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    previousIndex = index;
                  },
                  child: Icon(
                    Icons.circle,
                    size: 22,
                    color: index == widget._currentPage
                        ? AppColors.whiteGrey
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class HangulButton extends StatelessWidget {
  const HangulButton({
    super.key,
    required this.hangul,
    required this.onTap,
  });
  final String hangul;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        hangul,
        style: const TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteGrey,
            shadows: [
              Shadow(
                offset: Offset(1, 1),
                color: Colors.black,
                blurRadius: 20,
              ),
            ]),
      ),
    );
  }
}

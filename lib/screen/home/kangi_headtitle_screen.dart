import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/data/kangis_data.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_book_step/jlpt_book_step_screen.dart';

class KangiHangulScreen extends StatefulWidget {
  const KangiHangulScreen({super.key});

  @override
  State<KangiHangulScreen> createState() => _KangiHangulScreenState();
}

class _KangiHangulScreenState extends State<KangiHangulScreen> {
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
                    child: HangulButton(
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
                return HangulButton(
                  hangul: hanguls[index],
                  totlaHangulCount: hangulsLength[index],
                  onTap: () => goTo(hanguls[index]),
                );
              },
            ),
          ),
          const Spacer(),
          HangulNavigator(
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

class HangulNavigator extends StatefulWidget {
  const HangulNavigator({
    super.key,
    required this.pageController,
    required this.currentPage,
    required this.scrollController,
    required this.navigateScroll,
  });

  final PageController pageController;
  final int currentPage;
  final ScrollController scrollController;
  final Function() navigateScroll;

  @override
  State<HangulNavigator> createState() => _HangulNavigatorState();
}

class _HangulNavigatorState extends State<HangulNavigator> {
  int previousIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: SingleChildScrollView(
        controller: widget.scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(hanguls.length, (index) {
              return InkWell(
                onTap: () {
                  if (6 == index && 6 > previousIndex) {
                    widget.navigateScroll();
                  }
                  widget.pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  previousIndex = index;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.circle,
                    size: 22,
                    color: index == widget.currentPage
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
    required this.totlaHangulCount,
  });
  final String hangul;
  final Function() onTap;
  final int totlaHangulCount;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
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
              ],
            ),
          ),
          Text(
            '단어 ${totlaHangulCount.toString()} 개',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}

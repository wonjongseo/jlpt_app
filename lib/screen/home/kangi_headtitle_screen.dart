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
    print('hangul: ${hangul}');

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
          // SizedBox(
          //   height: 50,
          // ),
          const Spacer(),
          SizedBox(
            height: 150,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: onPageChange,
              itemCount: hanguls.length,
              itemBuilder: (context, index) {
                return HangulButton(
                  hangul: hanguls[index],
                  onTap: () => goTo(hanguls[index]),
                );
              },
            ),
          ),
          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(hanguls.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    onTap: () {
                      pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 50),
                      decoration: BoxDecoration(
                        color:
                            index == _currentPage ? Colors.black : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      width: 12,
                      height: 12,
                    ),
                  ),
                );
              }),
            ],
          ),

          const SizedBox(
            height: 60,
          ),
        ],
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
        style: TextStyle(
            fontFamily: 'ScoreStd',
            fontSize: 80,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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

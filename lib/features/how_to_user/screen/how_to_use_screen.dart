import 'package:flutter/material.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/how_to_user/widgets/app_page_image.dart';
import 'package:japanese_voca/features/how_to_user/widgets/engineer_said.dart';
import 'package:japanese_voca/features/how_to_user/widgets/score_page_description.dart';
import 'package:japanese_voca/features/how_to_user/widgets/study_page_description.dart';
import 'package:japanese_voca/features/how_to_user/widgets/test_page_description.dart';
import 'package:japanese_voca/features/how_to_user/widgets/usually_wrong_word_page_description.dart';

class HowToUseScreen extends StatefulWidget {
  const HowToUseScreen({super.key});

  @override
  State<HowToUseScreen> createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> {
  late PageController pageController;
  int currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPageIndex);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int newPageIndex) {
    currentPageIndex = newPageIndex;
    setState(() {});
  }

  List<Widget> pages = const [
    EngineerSaid(),
    AppPageImage(imageName: '학습페이지.png'),
    StudyPageDescription(),
    AppPageImage(imageName: '시험페이지.png'),
    TestPageDescription(),
    ScorePageDescription(),
    AppPageImage(imageName: '자주 틀리는 문제 페이지.png'),
    UsuallyWrongWordPageDescription(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const GlobalBannerAdmob(),
      appBar: AppBar(
        title: const Text('JLPT 종각 사용법'),
      ),
      body: Container(
        color: AppColors.whiteGrey,
        padding: EdgeInsets.symmetric(
          vertical: Responsive.height10 / 1,
          horizontal: Responsive.width10,
        ),
        margin: EdgeInsets.symmetric(
          vertical: Responsive.height10,
          horizontal: Responsive.width10,
        ),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: pages.length,
                  controller: pageController,
                  onPageChanged: onPageChanged,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
              ),
              SizedBox(height: Responsive.height10),
              if (currentPageIndex == 0)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: () {
                        currentPageIndex++;
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear);
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.black,
                      ),
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              Row(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentPageIndex != 0)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          onPressed: () {
                            currentPageIndex--;
                            pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear);
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.black,
                          ),
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  if (currentPageIndex != 0 &&
                      currentPageIndex != pages.length - 1)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          onPressed: () {
                            currentPageIndex++;
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear);
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.black,
                          ),
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

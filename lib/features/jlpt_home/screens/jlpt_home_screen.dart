import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/enums.dart';
import 'package:japanese_voca/config/string.dart';
import 'package:japanese_voca/features/home/widgets/home_screen_body.dart';
import 'package:japanese_voca/features/search/widgets/search_widget.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/screens/book_step_screen.dart';
import 'package:japanese_voca/features/home/services/home_controller.dart';
import 'package:japanese_voca/repository/local_repository.dart';

import '../../../common/admob/banner_ad/global_banner_admob.dart';

// ignore: constant_identifier_names

class JlptHomeScreen extends StatefulWidget {
  const JlptHomeScreen({super.key, required this.levelIndex});
  final int levelIndex;
  @override
  State<JlptHomeScreen> createState() => _JlptHomeScreenState();
}

class _JlptHomeScreenState extends State<JlptHomeScreen> {
  late PageController pageController;
  HomeController homeController = Get.find<HomeController>();
  TtsController ttsController = Get.find<TtsController>();
  String name = '';
  int selectedCategoryIndex = 0;
  onPageChanged(int newPage) {
    selectedCategoryIndex = newPage;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    LocalReposotiry.putBasicOrJlptOrMyDetail(
        KindOfStudy.JLPT, widget.levelIndex);
    selectedCategoryIndex =
        LocalReposotiry.getJlptOrKangiOrGrammar('${widget.levelIndex + 1}');
    pageController = PageController(initialPage: selectedCategoryIndex);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  Widget getBodys(JlptCategoryEnum categoryEnum) {
    String level = (widget.levelIndex + 1).toString();

    switch (categoryEnum) {
      case JlptCategoryEnum.Japaneses:
        return BookStepScreen(
          level: level,
          categoryEnum: JlptCategoryEnum.Japaneses,
        );
      case JlptCategoryEnum.Grammars:
        return BookStepScreen(
          level: level,
          categoryEnum: JlptCategoryEnum.Grammars,
        );
      case JlptCategoryEnum.Kangis:
        return BookStepScreen(
          level: level,
          categoryEnum: JlptCategoryEnum.Kangis,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(
          'JLPT N${widget.levelIndex + 1}',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: Responsive.height10 * 2,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.width20),
            child: Column(
              children: [
                SizedBox(height: Responsive.height10 * 2),
                const NewSearchWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Responsive.height10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      JlptCategoryEnum.values.length,
                      (index) => TextButton(
                        style: TextButton.styleFrom(
                            // padding: EdgeInsets.zero,
                            ),
                        onPressed: () {
                          LocalReposotiry.putJlptOrKangiOrGrammar(
                              '${widget.levelIndex + 1}', index);
                          pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: selectedCategoryIndex == index
                                ? Border(
                                    bottom: BorderSide(
                                      width: Responsive.width10 * 0.3,
                                      color: Colors.cyan.shade600,
                                    ),
                                  )
                                : null,
                          ),
                          child: Text(
                            '${JlptCategoryEnum.values[index].id} ${AppString.book.tr}',
                            style: index == selectedCategoryIndex
                                ? TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyan.shade600,
                                    fontSize: Responsive.width14,
                                  )
                                : TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: Responsive.width12,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 6,
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: JlptCategoryEnum.values.length,
                    controller: pageController,
                    onPageChanged: onPageChanged,
                    itemBuilder: (context, index) {
                      return getBodys(JlptCategoryEnum.values[index]);
                    },
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }
}

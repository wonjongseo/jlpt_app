import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/features/grammar_step/services/grammar_controller.dart';
import 'package:japanese_voca/features/search/widgets/search_widget.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/features/grammar_step/screens/grammar_step_screen.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/screens/book_step_screen.dart';
import 'package:japanese_voca/features/home/services/home_controller.dart';

import '../../../common/admob/banner_ad/global_banner_admob.dart';

enum CategoryEnum { Japaneses, Kangis, Grammars }

class JlptHomeScreen extends StatefulWidget {
  const JlptHomeScreen({super.key, required this.index});
  final int index;
  @override
  State<JlptHomeScreen> createState() => _JlptHomeScreenState();
}

class _JlptHomeScreenState extends State<JlptHomeScreen> {
  late PageController pageController;
  HomeController homeController = Get.find<HomeController>();
  TtsController ttsController = Get.put(TtsController());
  int selectedCategoryIndex = 0;
  onPageChanged(int newPage) {
    print('nasdas');
    selectedCategoryIndex = newPage;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedCategoryIndex);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  Widget getBodys(CategoryEnum categoryEnum) {
    String level = (widget.index + 1).toString();

    switch (categoryEnum) {
      case CategoryEnum.Japaneses:
        return BookStepScreen(
            level: level, categoryEnum: CategoryEnum.Japaneses);
      case CategoryEnum.Grammars:
        if (widget.index >= 3) {
          return const Center(
            child: Text('Not Yet...'),
          );
        }
        return BookStepScreen(
          level: level,
          categoryEnum: CategoryEnum.Grammars,
        );
      case CategoryEnum.Kangis:
        return BookStepScreen(
          level: level,
          categoryEnum: CategoryEnum.Kangis,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JLPT N${widget.index + 1}',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: Responsive.height10 * 2,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: Responsive.height10 * 2),
                const NewSearchWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Responsive.height10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      CategoryEnum.values.length,
                      (index) => TextButton(
                        onPressed: () {
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
                                        width: 3, color: Colors.cyan.shade700),
                                  )
                                : null,
                          ),
                          child: Text(
                            'All ${CategoryEnum.values[index].name}',
                            style: TextStyle(
                              fontSize: Responsive.width14,
                              color: selectedCategoryIndex == index
                                  ? Colors.black
                                  : Colors.grey.shade700,
                              fontWeight: FontWeight.w700,
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
                    itemCount: CategoryEnum.values.length,
                    controller: pageController,
                    onPageChanged: onPageChanged,
                    itemBuilder: (context, index) {
                      return getBodys(CategoryEnum.values[index]);
                    },
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }
}

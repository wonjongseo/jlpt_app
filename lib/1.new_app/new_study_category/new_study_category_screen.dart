import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:japanese_voca/1.new_app/new_study/components/search_widget.dart';
import 'package:japanese_voca/1.new_app/new_study_category/components/new_all_grammars_body.dart';
import 'package:japanese_voca/1.new_app/new_study_category/components/new_all_japaneses_body.dart';
import 'package:japanese_voca/features/grammar_step/services/grammar_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/kangi/controller/kangi_step_controller.dart';
import 'package:japanese_voca/model/word.dart';

enum CategoryEnum { Japaneses, Kangis, Grammars }

class NewStudyCategoryScreen extends StatefulWidget {
  const NewStudyCategoryScreen({super.key, required this.level});

  final int level;

  @override
  State<NewStudyCategoryScreen> createState() => _NewStudyCategoryScreenState();
}

class _NewStudyCategoryScreenState extends State<NewStudyCategoryScreen> {
  late PageController pageController;
  late JlptStepController jlptWordController;
  late KangiStepController kangiController;

  int selectedCategoryIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedCategoryIndex);
    jlptWordController =
        Get.put(JlptStepController(level: widget.level.toString()));
    kangiController =
        Get.put(KangiStepController(level: widget.level.toString()));
  }

  onPageChanged(int newPage) {
    selectedCategoryIndex = newPage;
    setState(() {});
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Widget getBodys(CategoryEnum category) {
    switch (category) {
      case CategoryEnum.Japaneses:
        return NewAllJapaneseBody(level: widget.level);
      case CategoryEnum.Grammars:
        Get.put(GrammarController(level: widget.level.toString()));
        return const NewAllGrammarsBody();
      case CategoryEnum.Kangis:
        return Container();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JLPT N${widget.level}',
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.grey.shade200,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const NewSearchWidget(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
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
                                      width: 3,
                                      color: Colors.cyan.shade700,
                                    ),
                                  )
                                : null,
                          ),
                          child: Text(
                            'All ${CategoryEnum.values[index].name}',
                            style: TextStyle(
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
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: CategoryEnum.values.length,
                    controller: pageController,
                    onPageChanged: onPageChanged,
                    itemBuilder: (context, index) {
                      return getBodys(CategoryEnum.values[index]);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable


/**
 itemBuilder: (context, index) {
                      if (index == 0) {
                        print('object');
                        return ListView.separated(
                          itemCount: jlptWordController.headTitleCount,
                          separatorBuilder: (context, index) {
                            // if (index % AppConstant.PER_COUNT_NATIVE_ND == 2) {
                            //   return NativeAdWidget();
                            // }
                            return Container();
                          },
                          itemBuilder: (context, index) {
                            String chapter = '챕터${index + 1}';

                            return FadeInLeft(
                              delay: Duration(milliseconds: 200 * index),
                              child: NewChapterCard(
                                chapterNumber: index + 1,
                                onTap: () {
                                  Get.toNamed(JLPT_CALENDAR_STEP_PATH,
                                      arguments: {
                                        'chapter': chapter,
                                        'isJlpt': true
                                      });
                                },
                              ),
                            );
                          },
                        );
                      }
                      // return bodys[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              30,
                              (index) => NewChapterCard(
                                chapterNumber: index + 1,
                                onTap: () {
                                  jlptWordController.setStep(index);
                                  Get.to(() => NewStudyWordListScreen());
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
 */
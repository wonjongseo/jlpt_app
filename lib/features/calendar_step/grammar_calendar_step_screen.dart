import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';

import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/size.dart';
import 'package:japanese_voca/features/calendar_step/widgets/c_toggle_btn.dart';
import 'package:japanese_voca/features/grammar_step/services/grammar_controller.dart';
import 'package:japanese_voca/features/grammar_step/widgets/grammar_study_screen.dart';
import 'package:japanese_voca/features/grammar_test/grammar_test_screen.dart';
import 'package:japanese_voca/features/jlpt_home/screens/jlpt_home_screen.dart';

import 'package:japanese_voca/user/controller/user_controller.dart';

const String JLPT_CALENDAR_STEP_PATH = '/jlpt-calendar-step';

// ignore: must_be_immutable
class GrammarCalendarStepScreen extends StatefulWidget {
  late CategoryEnum categoryEnum;

  GrammarCalendarStepScreen({super.key}) {
    categoryEnum = Get.arguments['categoryEnum'];
  }

  @override
  State<GrammarCalendarStepScreen> createState() =>
      _GrammarCalendarStepScreenState();
}

class _GrammarCalendarStepScreenState extends State<GrammarCalendarStepScreen> {
  int currChapNumber = 0;
  UserController userController = Get.find<UserController>();
  late PageController pageController;
  List<GlobalKey> gKeys = [];
  late GrammarController grammarController;

  late String level;
  late String chapter;
  late String category;
  @override
  void initState() {
    super.initState();
    chapter = Get.arguments['chapter'];

    category = '문법';
    grammarController = Get.find<GrammarController>();
    level = grammarController.level;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: _body(),
        bottomNavigationBar: const GlobalBannerAdmob(),
        floatingActionButton: _floatingActionButton());
  }

  _floatingActionButton() {
    return grammarController.getGrammarStep().grammars.length >= 4
        ? FloatingActionButton(
            onPressed: () => Get.toNamed(
              GRAMMAR_TEST_SCREEN,
              arguments: {
                'grammar': grammarController.getGrammarStep().grammars,
              },
            ),
            child: Text(
              '퀴즈',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.cyan.shade600,
              ),
            ),
          )
        : null;
  }

  SafeArea _body() {
    return SafeArea(
      child: GetBuilder<GrammarController>(
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                          controller.getGrammarStep().grammars.length,
                          (index) {
                            return GrammarStudyScreen(
                              index: index,
                              grammars: controller.getGrammarStep().grammars,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(appBarHeight),
      child: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(
          'JLPT N$level $category - $chapter',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Responsive.height16,
          ),
        ),
        actions: [_bottomSheet()],
      ),
    );
  }

  IconButton _bottomSheet() {
    return IconButton(
      onPressed: () {
        Get.bottomSheet(
          Container(
            color: Colors.white,
            child: GetBuilder<GrammarController>(builder: (controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 5,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  CToggleBtn(
                    label: '의미 가리기',
                    toggle: controller.toggleSeeMean,
                    value: controller.isSeeMean,
                  ),
                  const SizedBox(height: 40),
                ],
              );
            }),
          ),
        );
      },
      icon: const Icon(Icons.menu),
    );
  }
}

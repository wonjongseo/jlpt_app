import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/entity/jlpt_and_kangi/common/calendar_step_sceen.dart';
import 'package:japanese_voca/entity/jlpt_and_kangi/kangi/kangi_study/kangi_study_sceen.dart';
import 'package:japanese_voca/entity/my_voca/my_voca_sceen.dart';
import 'package:japanese_voca/entity/grammar/grammar_test/grammar_test_screen.dart';
import 'package:japanese_voca/entity/grammar/grammar_stury_screen.dart';
import 'package:japanese_voca/entity/jlpt_and_kangi/kangi/kangi_test/kangi_test_screen.dart';

import 'package:japanese_voca/entity/jlpt_and_kangi/jlpt/jlpt_test/jlpt_test_screen.dart';
import 'package:japanese_voca/entity/score/kangi_score_screen.dart';
import 'package:japanese_voca/entity/score/score_screen.dart';
import 'package:japanese_voca/entity/setting/setting_screen.dart';
import 'package:japanese_voca/entity/jlpt_and_kangi/jlpt/jlpt_study/jlpt_study_sceen.dart';

import 'entity/home/home_screen.dart';

class AppRoutes {
  static List<GetPage<dynamic>> getPages = [
    GetPage(
      name: GRAMMAR_TEST_SCREEN,
      page: () => const GrammarTestScreen(),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: HOME_PATH,
      page: () => const HomeScreen(),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: KANGI_SCORE_PATH,
      page: () => const KangiScoreScreen(),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: KANGI_STUDY_PATH,
      page: () => KangiStudySceen(),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: MY_VOCA_PATH,
      page: () => MyVocaPage(),
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: GRAMMER_STUDY_PATH,
      page: () => const GrammerStudyScreen(),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: JLPT_CALENDAR_STEP_PATH,
      page: () => CalendarStepSceen(),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: JLPT_STUDY_PATH,
      page: () => JlptStudyScreen(),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: JLPT_TEST_PATH,
      page: () => const JlptTestScreen(),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: KANGI_TEST_PATH,
      page: () => const KangiTestScreen(),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: SCORE_PATH,
      page: () => const ScoreScreen(),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: SETTING_PATH,
      page: () => const SettingScreen(),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
    ),
  ];
}

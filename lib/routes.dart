import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/kangi/kangi_study_sceen.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_sceen.dart';
import 'package:japanese_voca/screen/grammar/grammar_quiz_screen.dart';
import 'package:japanese_voca/screen/grammar/grammar_screen.dart';
import 'package:japanese_voca/screen/home/home_screen.dart';
import 'package:japanese_voca/screen/kangi/kangi_quiz/kangi_quiz_screen.dart';

import 'package:japanese_voca/screen/quiz/quiz_screen.dart';
import 'package:japanese_voca/screen/score/kangi_score_screen.dart';
import 'package:japanese_voca/screen/score/score_screen.dart';
import 'package:japanese_voca/screen/setting/setting_screen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/jlpt_study_sceen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_calendar_step/jlpt_calendar_step_sceen.dart';

class AppRoutes {
  static List<GetPage<dynamic>> getPages = [
    GetPage(
      name: GRAMMAR_QUIZ_SCREEN,
      page: () => const GrammarQuizScreen(),
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

    // GetPage(
    //   name: LISTEN_SCREEN_PATH,
    //   page: () => const ListenScreen(),
    //   transition: Transition.leftToRight,
    //   curve: Curves.easeInOut,
    // ),
    GetPage(
      name: KANGI_STUDY_PATH,
      page: () => KangiStudySceen(),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: MY_VOCA_PATH,
      page: () => MyVocaPage(),
      transition: Transition.circularReveal,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: GRAMMER_PATH,
      page: () => const GrammerScreen(),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: JLPT_CALENDAR_STEP_PATH,
      page: () => JlptCalendarStepSceen(),
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
      name: QUIZ_PATH,
      page: () => const QuizScreen(),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
    ),

    GetPage(
      name: KANGI_QUIZ_PATH,
      page: () => const KangiQuizScreen(),
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

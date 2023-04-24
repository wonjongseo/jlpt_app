import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/background.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/screen/grammar/grammar_quiz_screen.dart';
import 'package:japanese_voca/repository/grammar_step_repository.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:japanese_voca/repository/localRepository.dart';
import 'package:japanese_voca/screen/grammar/grammar_screen.dart';
import 'package:japanese_voca/screen/home/home_screen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_screen.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_screen.dart';
import 'package:japanese_voca/screen/quiz/quiz_screen.dart';
import 'package:japanese_voca/screen/score/score_screen.dart';
import 'package:japanese_voca/screen/setting/setting_screen.dart';
import 'package:japanese_voca/screen/word/word_study/word_study_sceen.dart';
import 'package:japanese_voca/screen/word/word_step/word_step_sceen.dart';

//  flutter packages pub run build_runner build

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Future<bool> loadData() async {
    await LocalReposotiry.init();

    if (await JlptStepRepositroy.isExistData() == false) {
      await JlptStepRepositroy.init('1');
      await JlptStepRepositroy.init('2');
      await JlptStepRepositroy.init('3');
      await JlptStepRepositroy.init('4');
      await JlptStepRepositroy.init('5');
    }

    if (await GrammarRepositroy.isExistData() == false) {
      await GrammarRepositroy.init('1');
      await GrammarRepositroy.init('2');
      await GrammarRepositroy.init('3');
    }

    if (await KangiStepRepositroy.isExistData() == false) {
      await KangiStepRepositroy.init();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadData(),
        builder: (context, snapshat) {
          if (snapshat.hasData == true) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: true,
              theme: Get.isDarkMode ? Themings.lightTheme : Themings.lightTheme,
              initialRoute: HOME_PATH,
              getPages: [
                GetPage(
                  name: GRAMMAR_QUIZ_SCREEN,
                  page: () => const GrammarQuizScreen(),
                ),
                GetPage(name: HOME_PATH, page: () => const HomeScreen()),
                GetPage(name: MY_VOCA_PATH, page: () => const MyVocaPage()),

                GetPage(name: GRAMMER_PATH, page: () => const GrammerScreen()),
                GetPage(
                    name: WORD_STEP_PATH,
                    page: () => WordStepSceen(level: '1')),

                GetPage(name: WORD_STUDY_PATH, page: () => WordStudyScreen()),
                GetPage(
                  name: JLPT_PATH,
                  page: () => const JlptScreen(level: '1'),
                ),
                GetPage(
                  name: QUIZ_PATH,
                  page: () => const QuizScreen(),
                ),
                GetPage(name: SCORE_PATH, page: () => const ScoreScreen()),
                GetPage(
                    name: SETTING_PATH,
                    page: () => const SettingScreen()), // GetPage(
              ],
            );
          } else if (snapshat.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshat.error}',
                style: const TextStyle(fontSize: 15),
              ),
            );
          } else {
            return MaterialApp(
              home: Scaffold(
                body: BackgroundWidget(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '데이터를 불러오는 중입니다.',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(height: 12),
                        TweenAnimationBuilder(
                          curve: Curves.fastOutSlowIn,
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: const Duration(seconds: 25),
                          builder: (context, value, child) {
                            return Column(
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: LinearProgressIndicator(
                                    backgroundColor: const Color(0xFF191923),
                                    value: value,
                                    color: const Color(0xFFFFC107),
                                  ),
                                ),
                                const SizedBox(height: 16 / 2),
                                Text('${(value * 100).toInt()}%')
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_sceen.dart';
import 'package:japanese_voca/screen/grammar/grammar_quiz_screen.dart';
import 'package:japanese_voca/repository/grammar_step_repository.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/screen/grammar/grammar_screen.dart';
import 'package:japanese_voca/screen/home/home_screen.dart';
import 'package:japanese_voca/screen/listen/listen_screen.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_screen_old.dart';
import 'package:japanese_voca/screen/quiz/quiz_screen.dart';
import 'package:japanese_voca/screen/score/score_screen.dart';
import 'package:japanese_voca/screen/setting/setting_screen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/jlpt_study_sceen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_calendar_step/jlpt_calendar_step_sceen.dart';
import 'config/colors.dart';

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

    if (await KangiStepRepositroy.isExistData() == false) {
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
            scrollBehavior: GetPlatform.isDesktop
                ? const MaterialScrollBehavior()
                    .copyWith(dragDevices: {PointerDeviceKind.mouse})
                : null,
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(
              useMaterial3: true,
            ).copyWith(
              textTheme:
                  ThemeData.light().textTheme.apply(fontFamily: 'CircularStd'),
              primaryTextTheme:
                  ThemeData.light().textTheme.apply(fontFamily: 'CircularStd'),
              scaffoldBackgroundColor: AppColors.scaffoldBackground,
              appBarTheme: const AppBarTheme(
                color: Colors.transparent,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'CircularStd',
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            initialRoute: HOME_PATH,
            //     home: MyVocaPage(),
            getPages: [
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
                name: LISTEN_SCREEN_PATH,
                page: () => const ListenScreen(),
                transition: Transition.leftToRight,
                curve: Curves.easeInOut,
              ),
              GetPage(
                name: MY_VOCA_PATH,
                page: () => const MyVocaPage(),
                transition: Transition.leftToRight,
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
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '데이터를 불러오는 중입니다.',
                      style: Theme.of(context).textTheme.titleMedium,
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
          );
        }
      },
    );
  }
}

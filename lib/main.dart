import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/ad_controller.dart';
import 'package:japanese_voca/home_screen2.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_controller.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/controller/user_controller.dart';
import 'package:japanese_voca/model/user.dart';
import 'package:japanese_voca/repository/grammar_step_repository.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:japanese_voca/routes.dart';
import 'package:japanese_voca/user_controller2.dart';
import 'package:japanese_voca/user_repository2.dart';

import 'controller/setting_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Future<bool> loadData() async {
    List<int> jlptWordScroes = [];
    List<int> grammarScores = [];
    List<int> kangiScores = [];
    try {
      await LocalReposotiry.init();

      if (await JlptStepRepositroy.isExistData() == false) {
        jlptWordScroes.add(await JlptStepRepositroy.init('1'));
        jlptWordScroes.add(await JlptStepRepositroy.init('2'));
        jlptWordScroes.add(await JlptStepRepositroy.init('3'));
        jlptWordScroes.add(await JlptStepRepositroy.init('4'));
        jlptWordScroes.add(await JlptStepRepositroy.init('5'));
      } else {
        jlptWordScroes = [3221, 2626, 1538, 1034, 741];
      }

      if (await GrammarRepositroy.isExistData() == false) {
        grammarScores.add(await GrammarRepositroy.init('1'));
        grammarScores.add(await GrammarRepositroy.init('2'));
        grammarScores.add(await GrammarRepositroy.init('3'));
      } else {
        grammarScores = [237, 93, 106];
      }

      if (await KangiStepRepositroy.isExistData() == false) {
        kangiScores.add(await KangiStepRepositroy.init("1"));
        kangiScores.add(await KangiStepRepositroy.init("2"));
        kangiScores.add(await KangiStepRepositroy.init("3"));
        kangiScores.add(await KangiStepRepositroy.init("4"));
        kangiScores.add(await KangiStepRepositroy.init("5"));
        kangiScores.add(await KangiStepRepositroy.init("6"));
      } else {
        kangiScores = [948, 693, 185, 37, 82];
      }
      late User user;
      if (await UserRepository2.isExistData() == false) {
        List<int> currentJlptWordScroes =
            List.generate(jlptWordScroes.length, (index) => 0);
        List<int> currentGrammarScores =
            List.generate(grammarScores.length, (index) => 0);
        List<int> currentKangiScores =
            List.generate(kangiScores.length, (index) => 0);
        user = User(
          heartCount: 30,
          jlptWordScroes: jlptWordScroes,
          grammarScores: grammarScores,
          kangiScores: kangiScores,
          currentJlptWordScroes: currentJlptWordScroes,
          currentGrammarScores: currentGrammarScores,
          currentKangiScores: currentKangiScores,
        );
        user = await UserRepository2.init(user);
      }

      Get.put(UserController());
      Get.put(AdController());
      Get.put(BannerAdController());
      Get.put(SettingController());
      Get.put(UserController2());
    } catch (e) {
      rethrow;
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
            debugShowCheckedModeBanner: false,
            theme: AppThemings.dartTheme,
            initialRoute: HOME_PATH2,
            getPages: AppRoutes.getPages,
            scrollBehavior: GetPlatform.isDesktop
                ? const MaterialScrollBehavior().copyWith(
                    dragDevices: {PointerDeviceKind.mouse},
                  )
                : null,
            // home: HomeScreen2(),
          );
        } else if (snapshat.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      snapshat.error.toString(),
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await LocalReposotiry.init();
                            GrammarRepositroy.deleteAllGrammar();
                            JlptStepRepositroy.deleteAllWord();
                            KangiStepRepositroy.deleteAllKangiStep();
                          },
                          child: const Text('초기화'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
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
// flutter pub run build_runner build --delete-conflicting-outputs

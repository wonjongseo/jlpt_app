import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/controller/ad_controller.dart';
import 'package:japanese_voca/screen/app2.dart';
import 'package:japanese_voca/screen/home/home_screen.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_controller.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/model/user.dart';
import 'package:japanese_voca/screen/grammar/repository/grammar_step_repository.dart';
import 'package:japanese_voca/screen/jlpt_and_kangi/jlpt/repository/jlpt_step_repository.dart';
import 'package:japanese_voca/screen/jlpt_and_kangi/kangi/repository/kangis_step_repository.dart';
import 'package:japanese_voca/common/repository/local_repository.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:japanese_voca/routes.dart';
import 'package:japanese_voca/screen/user/controller/user_controller.dart';
import 'package:japanese_voca/screen/user/repository/user_repository.dart';

import 'screen/setting/services/setting_controller.dart';

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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(),
      builder: (context, snapshat) {
        if (snapshat.hasData == true) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppThemings.dartTheme,
            initialRoute: HOME_PATH,
            getPages: AppRoutes.getPages,
          );
        } else if (snapshat.hasError) {
          return errorMaterialApp(snapshat);
        } else {
          return loadingMaterialApp(context);
        }
      },
    );
  }

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
      if (await UserRepository.isExistData() == false) {
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

        user = await UserRepository.init(user);
      }
      Get.put(UserController());
      Get.put(AdController());
      Get.put(BannerAdController());
      Get.put(SettingController());
    } catch (e) {
      rethrow;
    }
    return true;
  }

  MaterialApp loadingMaterialApp(BuildContext context) {
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

  MaterialApp errorMaterialApp(AsyncSnapshot<bool> snapshat) {
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
  }
}
// flutter pub run build_runner build --delete-conflicting-outputs
// JLPT 종각 => flutter pub run change_app_package_name:main com.wonjongseo.jlpt_jonggack
// JLPT 종각 Plus => flutter pub run change_app_package_name:main com.wonjongseo.jlpt_jonggack_plus
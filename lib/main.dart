import 'dart:async';
import 'package:japanese_voca/data/grammar_datas.dart';
import 'package:japanese_voca/data/kangi_datas.dart';
import 'package:japanese_voca/data/word_datas.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/controller/ad_controller.dart';
import 'package:japanese_voca/features/home/screens/home_screen.dart';
import 'package:japanese_voca/common/admob/banner_ad/test_banner_ad_controller.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/model/user.dart';
import 'package:japanese_voca/repository/grammar_step_repository.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:japanese_voca/routes.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';
import 'package:japanese_voca/user/repository/user_repository.dart';

import 'features/setting/services/setting_controller.dart';

/*
 유료버전과 무료버전 업로드 시 .

STEP 1. 프로젝트 명 반드시 바꾸기!!

  JLPT 종각 => flutter pub run change_app_package_name:main com.wonjongseo.jlpt_jonggack
  JLPT 종각 Plus => flutter pub run change_app_package_name:main com.wonjongseo.jlpt_jonggack_plus

STEP 2. 앱 이름 바꾸기 
  JLPT 종각 <-> JLPT 종각 Plus

STEP 2-1. 번들 이름 바꾸기 P

  japanese_voca <-> japanese_voca_plus

OS Path- ios/Runner/Info.plist
 Android Path- android/app/src/main/AndroidManifest.xml

STEP 3.
  앱 아이콘 바꾸기

STEP 4. 
  User isPremieum = false <-> true

STEP 5. 
  버전 바꾸기
  

Android Command - flutter build appbundle
Hive - flutter pub run build_runner build --delete-conflicting-outputs
 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
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
            initialRoute: HOME_PATH,
            getPages: AppRoutes.getPages,
            theme: AppThemings.lightTheme,
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

      if (await JlptStepRepositroy.isExistData(1) == false) {
        jlptWordScroes.add(await JlptStepRepositroy.init('1'));
      } else {
        jlptWordScroes.add(jsonN1Words.length);
      }

      if (await JlptStepRepositroy.isExistData(2) == false) {
        jlptWordScroes.add(await JlptStepRepositroy.init('2'));
      } else {
        jlptWordScroes.add(jsonN2Words.length);
      }

      if (await JlptStepRepositroy.isExistData(3) == false) {
        jlptWordScroes.add(await JlptStepRepositroy.init('3'));
      } else {
        jlptWordScroes.add(jsonN3Words.length);
      }

      if (await JlptStepRepositroy.isExistData(4) == false) {
        jlptWordScroes.add(await JlptStepRepositroy.init('4'));
      } else {
        jlptWordScroes.add(jsonN4Words.length);
      }

      if (await JlptStepRepositroy.isExistData(5) == false) {
        jlptWordScroes.add(await JlptStepRepositroy.init('5'));
      } else {
        jlptWordScroes.add(jsonN5Words.length);
      }

      if (await GrammarRepositroy.isExistData(1) == false) {
        grammarScores.add(await GrammarRepositroy.init('1'));
      } else {
        grammarScores.add(jsonN1Grammars.length);
      }

      if (await GrammarRepositroy.isExistData(2) == false) {
        grammarScores.add(await GrammarRepositroy.init('2'));
      } else {
        grammarScores.add(jsonN2Grammars.length);
      }

      if (await GrammarRepositroy.isExistData(3) == false) {
        grammarScores.add(await GrammarRepositroy.init('3'));
      } else {
        grammarScores.add(jsonN3Grammars.length);
      }

      if (await KangiStepRepositroy.isExistData(1) == false) {
        kangiScores.add(await KangiStepRepositroy.init("1"));
      } else {
        kangiScores.add(jsonN1Kangis.length);
      }

      if (await KangiStepRepositroy.isExistData(2) == false) {
        kangiScores.add(await KangiStepRepositroy.init("2"));
      } else {
        kangiScores.add(jsonN2Kangis.length);
      }

      if (await KangiStepRepositroy.isExistData(3) == false) {
        kangiScores.add(await KangiStepRepositroy.init("3"));
      } else {
        kangiScores.add(jsonN3Kangis.length);
      }

      if (await KangiStepRepositroy.isExistData(4) == false) {
        kangiScores.add(await KangiStepRepositroy.init("4"));
      } else {
        kangiScores.add(jsonN4Kangis.length);
      }

      if (await KangiStepRepositroy.isExistData(5) == false) {
        kangiScores.add(await KangiStepRepositroy.init("5"));
      } else {
        kangiScores.add(jsonN5Kangis.length);
      }

      if (await KangiStepRepositroy.isExistData(6) == false) {
        kangiScores.add(await KangiStepRepositroy.init("6"));
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
      Get.put(TestBannerAdController());
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
    String errorMsg = snapshat.error.toString();
    if (errorMsg.contains('Connection refused')) {
      errorMsg = '서버와 연결이 불안정 합니다. 데이터 연결 혹은 와이파이 환경에서 다시 요청해주시기 바랍니다.';
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'JLPT종각 앱 이용 하기 앞서,',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(
                    '데이터를 저장하기 위해 1회 서버와 연결을 해야합니다.',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '데이터 연결 혹은 와이파이 환경에서 다시 요청해주시기 바랍니다.',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorMsg,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

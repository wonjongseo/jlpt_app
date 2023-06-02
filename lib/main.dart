import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/ad_controller.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/controller/user_controller.dart';
import 'package:japanese_voca/routes.dart';
import 'package:japanese_voca/repository/grammar_step_repository.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/screen/home/home_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
    try {
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
      Get.put(UserController());
    } catch (e) {
      throw e;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AdController());

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
            theme: AppThemings.basicTheme,
            initialRoute: HOME_PATH,
            getPages: AppRoutes.getPages,
          );
        } else if (snapshat.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Column(
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
                          child: Text(
                            '초기화',
                          ))
                    ],
                  )
                ],
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

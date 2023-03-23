import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/controller/word_controller.dart';
import 'package:japanese_voca/repository/localRepository.dart';
import 'package:japanese_voca/screen/home/home_screen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_screen.dart';
import 'package:japanese_voca/screen/word/n_word_screen.dart';
import 'package:japanese_voca/screen/word/n_word_study_sceen.dart';
import 'package:japanese_voca/screen/word/word_sceen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Future<bool> loadData() async {
    await LocalReposotiry.init();
    if (await LocalReposotiry.hasWordData() == false) {
      await LocalReposotiry.saveAllWord();
    }
    Get.put(WordController());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadData(),
        builder: (context, snapshat) {
          if (snapshat.hasData == false) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
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
                        duration: const Duration(seconds: 50),
                        // onEnd: goTo,
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              SizedBox(
                                width: 250,
                                child: LinearProgressIndicator(
                                  backgroundColor: Color(0xFF191923),
                                  value: value,
                                  color: Color(0xFFFFC107),
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
          } else if (snapshat.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshat.error}',
                style: TextStyle(fontSize: 15),
              ),
            );
          } else {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: Get.isDarkMode ? Themings.lightTheme : Themings.lightTheme,
              initialRoute: HOME_PATH,
              getPages: [
                GetPage(name: HOME_PATH, page: () => const HomeScreen()),
                GetPage(name: JLPT_PATH, page: () => JlptScreen(level: '1')),
                GetPage(name: N_WORD_PATH, page: () => NWordScreen()),

                //  GetPage(name: WORD_PATH, page: () => WordSceen()),
                // GetPage(name: '/a', page: () => NWordStudyScreen()),
              ],
            );
          }
        });
  }
}

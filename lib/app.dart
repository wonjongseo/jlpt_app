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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadData();
  }

  loadData() async {
    if (await LocalReposotiry.hasWordData() == false) {
      // List<List<Word>> wordObj = Word.jsonToObject();
      // LocalReposotiry localReposotiry = LocalReposotiry();
      await LocalReposotiry.saveAllWord();
      print('saveAllWord');

      // for (List<Word> words in wordObj) {
      //   for (Word word in words) {
      //     print(words);
      //     localReposotiry.saveWord(word);
      //   }
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
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
}

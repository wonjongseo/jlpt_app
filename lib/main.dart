import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/app.dart';
import 'package:japanese_voca/controller/word_controller.dart';
import 'package:japanese_voca/data_format.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/localRepository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalReposotiry.init();

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
  Get.put(WordController());

  runApp(const App());
}

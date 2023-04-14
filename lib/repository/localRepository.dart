import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:japanese_voca/jlpt_word_n1_data.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/model/grammar_step.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/translator_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/model/kangi_step.dart';

class LocalReposotiry {
  static Future<void> init() async {
    if (GetPlatform.isMobile) {
      await Hive.initFlutter();
    } else if (GetPlatform.isWindows) {
      Hive.init("C:/Users/kissco/Desktop/learning/jlpt_app/assets/hive");
    }

    Hive.registerAdapter(KangiAdapter());
    Hive.registerAdapter(KangiStepAdapter());

    Hive.registerAdapter(WordAdapter());
    Hive.registerAdapter(TranslatorWordAdapter());

    Hive.registerAdapter(MyWordAdapter());
    Hive.registerAdapter(JlptStepAdapter());
    Hive.registerAdapter(GrammarAdapter());
    Hive.registerAdapter(GrammarStepAdapter());

    Hive.registerAdapter(ExampleAdapter());

    await Hive.openBox('autoSaveKey');
    await Hive.openBox('questionMarkKey');

    await Hive.openBox(Kangi.boxKey);
    await Hive.openBox(KangiStep.boxKey);

    await Hive.openBox(Example.boxKey);
    await Hive.openBox(Grammar.boxKey);
    await Hive.openBox(GrammarStep.boxKey);
    await Hive.openBox(JlptStep.boxKey);
    await Hive.openBox<Word>(Word.boxKey);
    await Hive.openBox<MyWord>(MyWord.boxKey);
    await Hive.openBox<TranslatorWord>(TranslatorWord.boxKey);
  }

  static bool autoSaveOnOff() {
    final list = Hive.box('autoSaveKey');
    String key = 'autoSave';

    if (!list.containsKey(key)) {
      list.put(key, false);
      return false;
    }
    bool isAutoSave = list.get(key);
    list.put(key, !isAutoSave);
    return !isAutoSave;
  }

  static bool getAutoSave() {
    final list = Hive.box('autoSaveKey');
    String key = 'autoSave';
    return list.get(key, defaultValue: true);
  }

  static bool questionMarkOnOff() {
    final list = Hive.box('questionMarkKey');
    String key = 'questionMark';

    if (!list.containsKey(key)) {
      list.put(key, true);
      return true;
    }
    bool isAutoSave = list.get(key);
    list.put(key, !isAutoSave);
    return !isAutoSave;
  }

  static bool getquestionMark() {
    final list = Hive.box('questionMarkKey');
    String key = 'questionMark';
    return list.get(key, defaultValue: false);
  }

  Future<List<MyWord>> getAllMyWord() async {
    final list = Hive.box<MyWord>(MyWord.boxKey);

    List<MyWord> words =
        List.generate(list.length, (index) => list.getAt(index))
            .whereType<MyWord>()
            .toList();

    return words;
  }

  static bool saveMyWord(MyWord word) {
    final list = Hive.box<MyWord>(MyWord.boxKey);
    if (list.containsKey(word.word)) {
      return false;
    }
    list.put(word.word, word);
    return true;
  }

  static void deleteAllMyWord() {
    final list = Hive.box<MyWord>(MyWord.boxKey);
    list.deleteFromDisk();
    log('deleteAllMyWord success');
  }

  void deleteMyWord(MyWord word) {
    final list = Hive.box<MyWord>(MyWord.boxKey);

    list.delete(word.word);
  }

  void updateKnownMyVoca(MyWord word) {
    final list = Hive.box<MyWord>(MyWord.boxKey);
    word.isKnown = !word.isKnown;
    list.put(word.word, word);
  }

  Future<List<TranslatorWord>> getAllTranslatorWord() async {
    final list = Hive.box<TranslatorWord>(TranslatorWord.boxKey);
    List<TranslatorWord> words =
        List.generate(list.length, (index) => list.getAt(index))
            .whereType<TranslatorWord>()
            .toList();

    return words;
  }

  void saveTranslatorWord(TranslatorWord word) {
    final list = Hive.box<TranslatorWord>(TranslatorWord.boxKey);

    list.put(word.originalWord, word);
  }

  void deleteTranslatorWord(TranslatorWord word) {
    final list = Hive.box<TranslatorWord>(TranslatorWord.boxKey);

    list.delete(word.originalWord);
  }
}

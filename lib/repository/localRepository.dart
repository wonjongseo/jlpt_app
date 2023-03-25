import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:japanese_voca/data_format.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/translator_word.dart';
import 'package:japanese_voca/model/word.dart';

class LocalReposotiry {
  static Future<void> init() async {
    if (GetPlatform.isMobile) {
      await Hive.initFlutter();
    } else if (GetPlatform.isWeb) {
      Hive.init("C:/Users/kissco/Desktop/learning/japanese_voca/assets/hive");
    }

    Hive.registerAdapter(WordAdapter());
    Hive.registerAdapter(MyWordAdapter());
    Hive.registerAdapter(TranslatorWordAdapter());
    Hive.registerAdapter(JlptStepAdapter());

    // await Hive.openBox('stepBox');

    // await Hive.openBox<List<Word>>('wordsList');
    await Hive.openBox(JlptStep.boxKey);
    await Hive.openBox<Word>(Word.boxKey);
    await Hive.openBox<MyWord>(MyWord.boxKey);
    await Hive.openBox<TranslatorWord>(TranslatorWord.boxKey);
  }

  static void deleteAllWord() {
    final list = Hive.box(JlptStep.boxKey);
    list.deleteFromDisk();
    print('deleteAllWord success');
  }

  List<List<Word>> getWord() {
    final list = Hive.box<List<Word>>('wordsList');

    List<List<Word>> temp_words =
        List.generate(list.length, (index) => list.getAt(index))
            .whereType<List<Word>>()
            .toList();

    return temp_words;
  }

  Future<List<Word>> getWordByHeaderText(String headText) async {
    final list = Hive.box<Word>(Word.boxKey);

    List<Word> temp_words =
        List.generate(list.length, (index) => list.getAt(index))
            .whereType<Word>()
            .toList();

    List<Word> words = [];

    for (Word word in temp_words) {
      if (word.headTitle == headText) {
        print(word);
        words.add(word);
      }
    }
    return words;
  }

  Future<List<MyWord>> getAllMyWord() async {
    final list = Hive.box<MyWord>(MyWord.boxKey);
    List<MyWord> words =
        List.generate(list.length, (index) => list.getAt(index))
            .whereType<MyWord>()
            .toList();

    return words;
  }

  static void saveMyWord(MyWord word) {
    final list = Hive.box<MyWord>(MyWord.boxKey);

    list.put(word.word, word);
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

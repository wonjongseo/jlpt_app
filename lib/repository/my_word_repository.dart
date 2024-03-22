import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:japanese_voca/model/my_word.dart';

class MyWordRepository {
  Future<List<MyWord>> getAllMyWord(bool isManuelSave) async {
    final list = Hive.box<MyWord>(MyWord.boxKey);

    List<MyWord> words = List.generate(list.length, (index) {
      return list.getAt(index);
    }).whereType<MyWord>().where((element) {
      return element.isManuelSave == isManuelSave;
    }).toList();

    words.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

    return words;
  }

  static bool savedInMyWordInLocal(MyWord word) {
    final list = Hive.box<MyWord>(MyWord.boxKey);
    return list.containsKey(word.word);
  }

  static bool saveMyWord(MyWord word) {
    final list = Hive.box<MyWord>(MyWord.boxKey);
    if (savedInMyWordInLocal(word)) {
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

  static void deleteMyWord(MyWord word) {
    final list = Hive.box<MyWord>(MyWord.boxKey);

    list.delete(word.word);
  }

  void updateKnownMyVoca(String word, bool isTrue) {
    final list = Hive.box<MyWord>(MyWord.boxKey);
    MyWord myWord = list.get(word) as MyWord;
    myWord.isKnown = isTrue;
    list.put(word, myWord);
  }
}

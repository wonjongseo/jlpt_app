import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:japanese_voca/model/my_word.dart';

class MyWordRepository {
  Future<List<MyWord>> getAllMyWord() async {
    final list = Hive.box<MyWord>(MyWord.boxKey);

    List<MyWord> words =
        List.generate(list.length, (index) => list.getAt(index))
            .whereType<MyWord>()
            .toList();

    words.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

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
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/hive_type.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';

part 'my_word.g.dart';

@HiveType(typeId: MyWordTypeId)
class MyWord {
  static String boxKey = 'my_word';
  @HiveField(0)
  late String word;
  @HiveField(1)
  late String mean;
  @HiveField(3)
  late String? yomikata = '';

  @HiveField(2)
  bool isKnown = false;

  @HiveField(4)
  late DateTime? createdAt;

  @HiveField(5)
  bool? isManuelSave = false;

  @HiveField(6)
  late List<Example>? examples;

  MyWord(
      {required this.word,
      required this.mean,
      required this.yomikata,
      this.isManuelSave = false,
      this.examples}) {
    createdAt = DateTime.now();
  }

  @override
  String toString() {
    return "MyWord{word: $word, mean: $mean, yomikata: $yomikata, isKnown: $isKnown, createdAt: $createdAt, isManuelSave: $isManuelSave}";
  }

  MyWord.fromMap(Map<String, dynamic> map) {
    word = map['word'] ?? '';
    mean = map['mean'] ?? '';
    createdAt = map['createdAt'] ?? '';

    yomikata = map['yomikata'] ?? '';
    isKnown = false;
    examples = [];
  }
  static MyWord kangiToMyWord(Kangi kangi) {
    MyWord newMyWord = MyWord(
        word: kangi.japan,
        mean: kangi.korea,
        yomikata: '${kangi.undoc} / ${kangi.hundoc}');

    newMyWord.createdAt = DateTime.now();

    return newMyWord;
  }

  static MyWord wordToMyWord(Word word) {
    MyWord newMyWord = MyWord(
        word: word.word,
        mean: word.mean,
        yomikata: word.yomikata,
        examples: word.examples);

    newMyWord.createdAt = DateTime.now();

    return newMyWord;
  }

  static bool saveToMyVoca(Word word) {
    MyWord newMyWord = wordToMyWord(word);
    if (MyWordRepository.savedInMyWordInLocal(newMyWord)) {
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          '${word.word} 가 이미 저장되어 있습니다.',
          '단어장에서 확인하실 수 있습니다.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white.withOpacity(0.5),
          duration: const Duration(milliseconds: 1000),
          animationDuration: const Duration(milliseconds: 1000),
        );
      }
      return false;
    } else {
      MyWordRepository.saveMyWord(newMyWord);
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          '${word.word} 저장되었습니다.',
          '단어장에서 확인하실 수 있습니다.',
          backgroundColor: Colors.white.withOpacity(0.5),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(milliseconds: 1000),
          animationDuration: const Duration(milliseconds: 1000),
        );
      }
    }
    return true;
  }

  String createdAtString() {
    return createdAt.toString().substring(0, 16);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';

part 'my_word.g.dart';

@HiveType(typeId: 1)
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

  MyWord({
    required this.word,
    required this.mean,
    required this.yomikata,
  });

  @override
  String toString() {
    return "MyWord{word: $word, mean: $mean, yomikata: $yomikata, isKnown: $isKnown, createdAt: $createdAt}";
  }

  MyWord.fromMap(Map<String, dynamic> map) {
    word = map['word'] ?? '';
    mean = map['mean'] ?? '';
    createdAt = map['createdAt'] ?? '';

    yomikata = map['yomikata'] ?? '';
    isKnown = false;
  }

  static void saveToMyVoca(Word word, {isManualSave = false}) {
    if (!isManualSave) {
      if (!LocalReposotiry.getAutoSave()) {
        return;
      }
    }

    MyWord newMyWord = MyWord(
      word: word.word,
      mean: word.mean,
      yomikata: word.yomikata,
    );
    // DateTime now = DateTime.utc(2023, 5, 27);
    newMyWord.createdAt = DateTime.now();
    // newMyWord.createdAt = now;
    if (!MyWordRepository.saveMyWord(newMyWord)) {
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
    }
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

  String createdAtString() {
    return createdAt.toString().substring(0, 16);
  }
}

// ignore: file_names

import 'package:hive/hive.dart';

part 'my_word.g.dart';

@HiveType(typeId: 1)
class MyWord {
  static String boxKey = 'my_word';
  @HiveField(0)
  final String word;
  @HiveField(1)
  final String mean;
  @HiveField(2)
  bool isKnown = false;

  MyWord({required this.word, required this.mean});

  @override
  String toString() {
    return "MyWord{word: $word, mean: $mean, isKnown: $isKnown}";
  }
}

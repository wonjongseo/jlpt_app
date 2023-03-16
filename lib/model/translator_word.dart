import 'package:hive/hive.dart';

part 'translator_word.g.dart';

@HiveType(typeId: 3)
class TranslatorWord {
  static String boxKey = 'translator_word';
  @HiveField(0)
  final String originalWord;
  @HiveField(1)
  final String target1Word;
  @HiveField(2)
  final String target2Word;
  @HiveField(3)
  final String originalLan;
  @HiveField(4)
  final String target1Lan;
  @HiveField(5)
  final String target2Lan;
  const TranslatorWord(
      {required this.originalLan,
      required this.target1Lan,
      required this.target2Lan,
      required this.originalWord,
      required this.target1Word,
      required this.target2Word});

  @override
  String toString() {
    return 'TranslatorWord(originalWord: $originalWord, target1Word: $target1Word, target2Word: $target2Word, originalLan: $originalLan, target1Lan: $target1Lan, target2Lan: $target2Lan )';
  }

  List<String> getEnglish() {
    if (originalLan == 'EN') {
      return [originalWord, target1Word, target2Word];
    } else if (target1Lan == 'EN') {
      return [target1Word, originalWord, target2Word];
    } else {
      return [target2Word, target1Word, originalWord];
    }
  }
}

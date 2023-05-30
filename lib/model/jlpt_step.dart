import 'package:hive/hive.dart';
import 'package:japanese_voca/model/word.dart';

part 'jlpt_step.g.dart';

@HiveType(typeId: 10)
class JlptStep extends HiveObject {
  static String boxKey = 'jlpt_step_key';
  @HiveField(0)
  final String headTitle;
  @HiveField(1)
  final int step;
  @HiveField(2)
  final List<Word> words;
  @HiveField(3)
  List<Word> unKnownWord = [];

  @HiveField(4)
  bool isFiendis = false;

  @HiveField(4)
  int scores;

  JlptStep(
      {required this.headTitle,
      required this.step,
      required this.words,
      required this.scores});

  @override
  String toString() {
    return 'JlptStep(headTitle: $headTitle, step: $step, words: $words , unKnownWord: $unKnownWord, scores: $scores)';
  }
}

import 'package:hive/hive.dart';
import 'package:japanese_voca/model/hive_type.dart';
import 'package:japanese_voca/model/kangi.dart';

import 'Question.dart';

part 'kangi_step.g.dart';

@HiveType(typeId: KangiStepTypeId)
class KangiStep extends HiveObject {
  static String boxKey = 'kangi_step_key';
  @HiveField(0)
  final String headTitle;
  @HiveField(1)
  final int step;
  @HiveField(2)
  List<Kangi> kangis;
  @HiveField(3)
  List<Kangi> unKnownKangis = [];
  @HiveField(4)
  int scores;

  @HiveField(5)
  bool? isFinished = false;

  @HiveField(6)
  List<Question>? wrongQuestion = [];

  KangiStep(
      {required this.headTitle,
      required this.step,
      required this.kangis,
      required this.scores});

  @override
  String toString() {
    return 'KangiStep(headTitle: $headTitle, step: $step, kangis: $kangis , unKnownKangis: $unKnownKangis, scores: $scores, isFiendis: $isFinished, wrongQuestion: ${wrongQuestion?.length})';
  }
}

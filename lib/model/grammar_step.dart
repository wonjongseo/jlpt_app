import 'package:hive/hive.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/model/hive_type.dart';

part 'grammar_step.g.dart';

@HiveType(typeId: GrammarStepTypeId)
class GrammarStep extends HiveObject {
  static String boxKey = 'grammar_step_key';

  @HiveField(0)
  final String level;

  @HiveField(1)
  final int step;

  @HiveField(2)
  List<Grammar> grammars;

  @HiveField(3)
  List<Grammar> unKnownGrammars = [];

  @HiveField(4)
  int scores = 0;
  @HiveField(5)
  bool? isFinished = false;

  GrammarStep(
      {required this.level, required this.step, required this.grammars});

  @override
  String toString() {
    return 'GrammarStep(step: $step, scores: $scores, grammars: $grammars, unKnownGrammars: $unKnownGrammars, isFinished: $isFinished)';
  }
}

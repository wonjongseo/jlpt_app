import 'package:hive/hive.dart';
import 'package:japanese_voca/data_format.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/model/grammar_step.dart';
import 'package:japanese_voca/model/word.dart';

class GrammarRepositroy {
  static int MINIMUM_STEP_COUNT = 15;

  static Future<bool> isExistData() async {
    final box = Hive.box(GrammarStep.boxKey);
    return box.isNotEmpty;
  }

  static void deleteAllGrammar() {
    final list = Hive.box(GrammarStep.boxKey);
    list.deleteFromDisk();
    print('deleteAllGrammarStep success');
  }

  static void init(String level) {
    print('GrammerRepositroy init');
    final box = Hive.box(GrammarStep.boxKey);

    List<Grammar> grammars = Grammar.jsonToObject();
    grammars.shuffle();
    print('words.length: ${grammars.length}');

    int stepCount = 0;
    for (int step = 0; step < grammars.length; step += MINIMUM_STEP_COUNT) {
      List<Grammar> currentGrammers = [];

      if (step + MINIMUM_STEP_COUNT > grammars.length) {
        currentGrammers = grammars.sublist(step);
      } else {
        currentGrammers = grammars.sublist(step, step + MINIMUM_STEP_COUNT);
      }

      GrammarStep tempGrammarStep =
          GrammarStep(level: level, step: stepCount, grammars: currentGrammers);

      String key = '$level-$stepCount';
      box.put(key, tempGrammarStep);
      stepCount++;
    }
    print('success add grammer step');

    box.put(level, stepCount);
  }

  List<GrammarStep> getGrammarStepByLevel(String level) {
    print('level: ${level}');

    final box = Hive.box(GrammarStep.boxKey);

    int LevelStepCount = box.get(level);
    print('LevelStepCount: ${LevelStepCount}');

    List<GrammarStep> grammarStepList = [];

    for (int step = 0; step < LevelStepCount; step++) {
      String key = '$level-$step';
      if (!box.containsKey(key)) {
        continue;
      }
      GrammarStep grammarStep = box.get(key);

      grammarStepList.add(grammarStep);
    }

    return grammarStepList;
  }

  void updateGrammerStep(GrammarStep newGrammarStep) {
    final box = Hive.box(GrammarStep.boxKey);

    String key = '${newGrammarStep.level}-${newGrammarStep.step}';
    print('key: ${key}');
    box.put(key, newGrammarStep);
  }
}

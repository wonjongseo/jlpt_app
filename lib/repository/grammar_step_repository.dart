import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/model/grammar_step.dart';

import '../common/app_constant.dart';

class GrammarRepositroy {
  static Future<bool> isExistData(int level) async {
    final box = Hive.box(GrammarStep.boxKey);

    int levelStepCount = await box.get('$level', defaultValue: 0);
    return levelStepCount != 0;
  }

  static void deleteAllGrammar() {
    log('deleteAllGrammarStep start');

    final list = Hive.box(GrammarStep.boxKey);
    list.deleteAll(list.keys);
    list.deleteFromDisk();
    log('deleteAllGrammarStep success');
  }

  static Future<int> init(String level) async {
    log('GrammerRepositroy $level init');
    final box = Hive.box(GrammarStep.boxKey);

    List<Grammar> grammars = await Grammar.jsonToObject(level);

    int stepCount = 0;
    for (int step = 0;
        step < grammars.length;
        step += AppConstant.MINIMUM_STEP_COUNT) {
      List<Grammar> currentGrammers = [];

      if (step + AppConstant.MINIMUM_STEP_COUNT > grammars.length) {
        currentGrammers = grammars.sublist(step);
      } else {
        currentGrammers =
            grammars.sublist(step, step + AppConstant.MINIMUM_STEP_COUNT);
      }

      GrammarStep tempGrammarStep =
          GrammarStep(level: level, step: stepCount, grammars: currentGrammers);

      String key = '$level-$stepCount';
      await box.put(key, tempGrammarStep);
      stepCount++;
    }
    await box.put(level, stepCount);

    return grammars.length;
  }

  List<GrammarStep> getGrammarStepByLevel(String level) {
    final box = Hive.box(GrammarStep.boxKey);

    int levelStepCount = box.get(level);

    List<GrammarStep> grammarStepList = [];

    for (int step = 0; step < levelStepCount; step++) {
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
    box.put(key, newGrammarStep);
  }
}

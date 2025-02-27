import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:japanese_voca/features/jlpt_home/screens/jlpt_home_screen.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/model/grammar_step.dart';
import 'package:japanese_voca/repository/local_repository.dart';

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

  static Future<int> init(String nLevel) async {
    log('GrammerRepositroy $nLevel init');
    final box = Hive.box(GrammarStep.boxKey);
    final grammarBox = Hive.box<Grammar>(Grammar.boxKey);
    List<Grammar> grammars = await Grammar.jsonToObject(nLevel);

    int stepCount = 0;

    for (Grammar grammar in grammars) {
      grammarBox.put(grammar.grammar, grammar);
    }
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

      GrammarStep tempGrammarStep = GrammarStep(
          level: nLevel, step: stepCount, grammars: currentGrammers);

      String key = '$nLevel-$stepCount';
      await box.put(key, tempGrammarStep);
      stepCount++;
    }
    await box.put(nLevel, stepCount);
    LocalReposotiry.putCurrentProgressing(
        '${CategoryEnum.Grammars.name}-$nLevel', 0);
    return grammars.length;
  }

  static Future<int> updateGrammarStepData(String nLevel) async {
    log('GrammerRepositroy $nLevel Update');
    final box = Hive.box(GrammarStep.boxKey);
    final grammarBox = Hive.box<Grammar>(Grammar.boxKey);
    List<Grammar> grammars = await Grammar.jsonToObject(nLevel);

    int stepCount = 0;

    for (Grammar grammar in grammars) {
      grammarBox.put(grammar.grammar, grammar);
    }
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
      String key = '$nLevel-$stepCount';
      GrammarStep? beforeGrammarStep = box.get(key);
      if (beforeGrammarStep == null) return 0;

      beforeGrammarStep.grammars = currentGrammers;

      await box.put(key, beforeGrammarStep);
      stepCount++;
    }
    await box.put(nLevel, stepCount);
    LocalReposotiry.putCurrentProgressing(
        '${CategoryEnum.Grammars.name}-$nLevel', 0);
    log('totalCount : ${grammars.length}');

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

  static Future<List<Grammar>> searchGrammars(String query) async {
    if (query.length == 1) {
      return [];
    }
    final grammarBox = Hive.box<Grammar>(Grammar.boxKey);

    List<Grammar> relatedGrammars = grammarBox.values.where((element) {
      if (element.grammar.contains(query) || element.means.contains(query)) {
        return true;
      }
      return false;
    }).toList();

    List<Grammar> grammars = grammarBox.values.where((element) {
      if (element.grammar == (query) || element.means == (query)) {
        return true;
      }
      return false;
    }).toList();
    if (grammars.isEmpty || grammars.isEmpty) {
      return relatedGrammars;
    } else {
      return grammars;
    }
  }
}

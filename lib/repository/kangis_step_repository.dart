import 'package:hive/hive.dart';

import 'package:japanese_voca/kangis_data.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/model/kangi_step.dart';

class KangiStepRepositroy {
  static int MINIMUM_STEP_COUNT = 15;

  static Future<bool> isExistData() async {
    final box = Hive.box(KangiStep.boxKey);
    return box.isNotEmpty;
  }

  static void deleteAllKangiStep() {
    final list = Hive.box(KangiStep.boxKey);
    list.deleteFromDisk();
    print('deleteAllKangiStep success');
  }

  static void deleteAllKangi() {
    final list = Hive.box(Kangi.boxKey);
    list.deleteFromDisk();
    print('deleteAllKangi success');
  }

  Kangi? getKangi(String key) {
    final box = Hive.box(Kangi.boxKey);

    if (!box.containsKey(key)) {
      return null;
    }
    return box.get(key);
  }

  static void saveKangi(Kangi kangi) {
    final box = Hive.box(Kangi.boxKey);
    print('Saved kangi.japan: ${kangi.japan}');

    box.put(kangi.japan, kangi);
  }

  static void init() {
    print('KangiStepRepositroy init');
    final box = Hive.box(KangiStep.boxKey);

    List<List<Kangi>> kangis = Kangi.jsonToObject();

    for (int headIndex = 0; headIndex < kangis.length; headIndex++) {
      String headTitle = hanguls[headIndex];

      int headTitleLength = kangis[headIndex].length;
      int lastHalfIndex = 0;
      int stepCount = 0;

      for (int step = 0; step < headTitleLength; step += MINIMUM_STEP_COUNT) {
        List<Kangi> currentKangis = [];

        if (step + MINIMUM_STEP_COUNT > headTitleLength) {
          currentKangis = kangis[headIndex].sublist(step);
        } else {
          currentKangis =
              kangis[headIndex].sublist(step, step + MINIMUM_STEP_COUNT);
        }

        for (int kangiIndex = 0;
            kangiIndex < currentKangis.length;
            kangiIndex++) {
          saveKangi(currentKangis[kangiIndex]);
        }
        currentKangis.shuffle();

        KangiStep tempKangiStep = KangiStep(
            headTitle: headTitle,
            step: stepCount,
            kangis: currentKangis,
            scores: 0);

        String key = '$headTitle-$stepCount';
        box.put(key, tempKangiStep);
        stepCount++;
      }
      box.put(headTitle, stepCount);
    }
  }

  List<KangiStep> getKangiStepByHeadTitle(String headTitle) {
    final box = Hive.box(KangiStep.boxKey);

    int headTitleStepCount = box.get(headTitle);
    List<KangiStep> kangiStepList = [];

    for (int step = 0; step < headTitleStepCount; step++) {
      String key = '$headTitle-$step';
      KangiStep kangiStep = box.get(key);
      kangiStepList.add(kangiStep);
    }

    return kangiStepList;
  }

  void updateKangiStep(KangiStep newJlptStep) {
    final box = Hive.box(KangiStep.boxKey);

    String key = '${newJlptStep.headTitle}-${newJlptStep.step}';
    box.put(key, newJlptStep);
  }
}
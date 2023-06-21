import 'dart:developer';

import 'package:hive/hive.dart';

import 'package:japanese_voca/model/kangi.dart';

import 'package:japanese_voca/model/kangi_step.dart';

import '../../../../common/app_constant.dart';

class KangiStepRepositroy {
  static Future<bool> isExistData() async {
    final box = Hive.box(KangiStep.boxKey);
    return box.isNotEmpty;
  }

  static void deleteAllKangiStep() {
    log('deleteAllKangiStep start');

    final list = Hive.box(KangiStep.boxKey);
    list.deleteAll(list.keys);
    list.deleteFromDisk();
    log('deleteAllKangiStep success');
  }

  static void deleteAllKangi() {
    final list = Hive.box(Kangi.boxKey);
    list.deleteFromDisk();
    log('deleteAllKangi success');
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

    box.put(kangi.japan, kangi);
  }

  static Future<int> init(String nLevel) async {
    log('KangiStepRepositroy $nLevel init');
    final box = Hive.box(KangiStep.boxKey);

    List<List<Kangi>> kangis = Kangi.jsonToObject(nLevel);
    int totalCount = 0;
    for (int i = 0; i < kangis.length; i++) {
      totalCount += kangis[i].length;
    }
    print('totalCount: ${totalCount}');

    box.put('$nLevel-step-count', kangis.length);

    for (int headIndex = 0; headIndex < kangis.length; headIndex++) {
      String headTitle = kangis[headIndex][0].headTitle;

      int headTitleLength = kangis[headIndex].length;
      int stepCount = 0;

      kangis[headIndex].shuffle();

      for (int step = 0;
          step < headTitleLength;
          step += AppConstant.MINIMUM_STEP_COUNT) {
        List<Kangi> currentKangis = [];

        if (step + AppConstant.MINIMUM_STEP_COUNT > headTitleLength) {
          currentKangis = kangis[headIndex].sublist(step);
        } else {
          currentKangis = kangis[headIndex]
              .sublist(step, step + AppConstant.MINIMUM_STEP_COUNT);
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

        String key = '$nLevel-$headTitle-$stepCount';
        await box.put(key, tempKangiStep);
        stepCount++;
      }
      await box.put('$nLevel-$headTitle', stepCount);
    }
    return totalCount;
  }

  List<KangiStep> getKangiStepByHeadTitle(String nLevel, String headTitle) {
    final box = Hive.box(KangiStep.boxKey);

    int headTitleStepCount = box.get('$nLevel-$headTitle');
    List<KangiStep> kangiStepList = [];

    for (int step = 0; step < headTitleStepCount; step++) {
      String key = '$nLevel-$headTitle-$step';
      KangiStep kangiStep = box.get(key);

      kangiStepList.add(kangiStep);
    }

    return kangiStepList;
  }

  int getCountByHangul(String nLevel) {
    final box = Hive.box(KangiStep.boxKey);

    int countByHangul = box.get('$nLevel-step-count', defaultValue: 0);

    return countByHangul;
  }

  void updateKangiStep(String nLevel, KangiStep newJlptStep) {
    final box = Hive.box(KangiStep.boxKey);

    String key = '$nLevel-${newJlptStep.headTitle}-${newJlptStep.step}';
    box.put(key, newJlptStep);
  }
}

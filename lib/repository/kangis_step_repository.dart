import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:japanese_voca/features/jlpt_home/screens/jlpt_home_screen.dart';

import 'package:japanese_voca/model/kangi.dart';

import 'package:japanese_voca/model/kangi_step.dart';
import 'package:japanese_voca/repository/local_repository.dart';

import '../common/app_constant.dart';

class KangiRepositroy {
  static Future<Kangi?> searchKangi(String query) async {
    final kangiBox = Hive.box<Kangi>(Kangi.boxKey);
    Kangi? kangi = await kangiBox.get(query);

    return kangi;
  }

  static Future<List<Kangi>> searchkangis(String query) async {
    final kangiBox = Hive.box<Kangi>(Kangi.boxKey);
    List<Kangi> relatedKangis = kangiBox.values.where((element) {
      if (element.korea.contains(query) || element.japan.contains(query)) {
        return true;
      }
      return false;
    }).toList();

    List<Kangi> kangis = kangiBox.values.where((element) {
      if (element.korea == (query) || element.japan == (query)) {
        return true;
      }
      return false;
    }).toList();
    if (kangis.isEmpty || kangis.isEmpty) {
      return relatedKangis;
    } else {
      return kangis;
    }
  }
}

class KangiStepRepositroy {
  static Future<bool> isExistData(int nLevel) async {
    final box = Hive.box(KangiStep.boxKey);

    int countByHangul = box.get('$nLevel-step-count', defaultValue: 0);

    return countByHangul != 0;
  }

  static void deleteAllKangiStep() {
    log('deleteAllKangiStep start');

    final list = Hive.box(KangiStep.boxKey);
    list.deleteAll(list.keys);
    list.deleteFromDisk();
    log('deleteAllKangiStep success');
  }

  static void deleteAllKangi() {
    final list = Hive.box<Kangi>(Kangi.boxKey);
    list.deleteFromDisk();
    log('deleteAllKangi success');
  }

  Kangi? getKangi(String key) {
    final box = Hive.box<Kangi>(Kangi.boxKey);

    if (!box.containsKey(key)) {
      return null;
    }
    return box.get(key);
  }

  static void saveKangi(Kangi kangi) {
    final box = Hive.box<Kangi>(Kangi.boxKey);

    box.put(kangi.japan, kangi);
  }

  static Future<int> init(String nLevel) async {
    log('KangiStepRepositroy $nLevel init');
    final box = Hive.box(KangiStep.boxKey);

    List<List<Kangi>> kangis = await Kangi.jsonToObject(nLevel);
    int totalCount = 0;
    for (int i = 0; i < kangis.length; i++) {
      totalCount += kangis[i].length;
    }

    box.put('$nLevel-step-count', kangis.length); // 2-step-count

    for (int headIndex = 0; headIndex < kangis.length; headIndex++) {
      String headTitle = kangis[headIndex][0].headTitle;

      int headTitleLength = kangis[headIndex].length;
      int stepCount = 0;

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

        KangiStep tempKangiStep = KangiStep(
            headTitle: headTitle,
            step: stepCount,
            kangis: currentKangis,
            scores: 0);

        String key = '$nLevel-$headTitle-$stepCount'; // "2-챕터1-0"
        LocalReposotiry.putCurrentProgressing(
          '${CategoryEnum.Kangis.name}-$nLevel-$headTitle', // "Kangis-2-챕터1"
          0,
        );
        await box.put(key, tempKangiStep);
        stepCount++;
      }
      await box.put('$nLevel-$headTitle', stepCount);
    }
    LocalReposotiry.putCurrentProgressing(
        '${CategoryEnum.Kangis.name}-$nLevel', 0);
    return totalCount;
  }

  List<KangiStep> getKangiStepByHeadTitle(String nLevel, String headTitle) {
    final box = Hive.box(KangiStep.boxKey);

    int headTitleStepCount = box.get('$nLevel-$headTitle', defaultValue: 0);
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

  static Future<int> updateKangiStepData(String nLevel) async {
    log('KangiStepRepositroy $nLevel Update');

    final box = Hive.box(KangiStep.boxKey);
    List<List<Kangi>> kangis = await Kangi.jsonToObject(nLevel);

    int totalCount = 0;
    for (int i = 0; i < kangis.length; i++) {
      totalCount += kangis[i].length;
    }
    log('totalCount : ${totalCount}');

    box.put('$nLevel-step-count', kangis.length); // 2-step-count

    for (int headIndex = 0; headIndex < kangis.length; headIndex++) {
      String headTitle = kangis[headIndex][0].headTitle;

      int headTitleLength = kangis[headIndex].length;
      int stepCount = 0;

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

        String key = '$nLevel-$headTitle-$stepCount'; // "2-챕터1-0"

        KangiStep? beforeKangiStep = await box.get(key);
        if (beforeKangiStep == null) return 0;
        beforeKangiStep.kangis = currentKangis;

        LocalReposotiry.putCurrentProgressing(
          '${CategoryEnum.Kangis.name}-$nLevel-$headTitle', // "Kangis-2-챕터1"
          0,
        );
        await box.put(key, beforeKangiStep);
        stepCount++;
      }
      await box.put('$nLevel-$headTitle', stepCount);
    }
    LocalReposotiry.putCurrentProgressing(
        '${CategoryEnum.Kangis.name}-$nLevel', 0);
    return totalCount;
  }
}

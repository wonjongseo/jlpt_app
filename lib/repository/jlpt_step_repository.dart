import 'package:hive/hive.dart';
import 'package:japanese_voca/data_format.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/word.dart';

class JlptStepRepositroy {
  static int MINIMUM_STEP_COUNT = 15;

  static Future<bool> isExistData() async {
    final box = Hive.box(JlptStep.boxKey);
    return box.isNotEmpty;
  }

  static void deleteAllWord() {
    final list = Hive.box(JlptStep.boxKey);
    list.deleteFromDisk();
    print('deleteAllWord success');
  }

  static void init() {
    print('JlptStepRepositroy init');
    final box = Hive.box(JlptStep.boxKey);

    List<List<Word>> words = Word.jsonToObject();

    for (int headTitleIndex = 0;
        headTitleIndex < words.length;
        headTitleIndex++) {
      String headTitle = hiragas[headTitleIndex];

      int headTitleLength = words[headTitleIndex].length;
      int lastHalfIndex = 0;
      int stepCount = 0;

      for (int step = 0; step < headTitleLength; step += MINIMUM_STEP_COUNT) {
        List<Word> currentWords = [];
        // if (step > headTitleLength / 2) {
        //   if (step + MINIMUM_STEP_COUNT > headTitleLength) {
        //     currentWords = words[headTitleIndex].sublist(lastHalfIndex);
        //   } else {
        //     currentWords = words[headTitleIndex]
        //         .sublist(lastHalfIndex, step + MINIMUM_STEP_COUNT);
        //   }
        // } else {
        //   currentWords =
        //       words[headTitleIndex].sublist(0, step + MINIMUM_STEP_COUNT);

        //   lastHalfIndex = step + MINIMUM_STEP_COUNT;
        // }

        if (step + MINIMUM_STEP_COUNT > headTitleLength) {
          currentWords = words[headTitleIndex].sublist(step);
        } else {
          currentWords =
              words[headTitleIndex].sublist(step, step + MINIMUM_STEP_COUNT);
        }
        currentWords.shuffle();

        JlptStep tempJlptStep = JlptStep(
            headTitle: headTitle,
            step: stepCount,
            words: currentWords,
            scores: 0);

        String key = '$headTitle-$stepCount';
        box.put(key, tempJlptStep);
        stepCount++;
      }
      box.put(headTitle, stepCount);
    }
  }

  List<JlptStep> getJlptStepByHeadTitle(String headTitle) {
    final box = Hive.box(JlptStep.boxKey);

    int headTitleStepCount = box.get(headTitle);
    List<JlptStep> jlptStepList = [];

    for (int step = 0; step < headTitleStepCount; step++) {
      String key = '$headTitle-$step';
      JlptStep jlptStep = box.get(key);
      jlptStepList.add(jlptStep);
    }

    return jlptStepList;
  }

  void updateJlptStep(JlptStep newJlptStep) {
    final box = Hive.box(JlptStep.boxKey);

    String key = '${newJlptStep.headTitle}-${newJlptStep.step}';
    box.put(key, newJlptStep);
  }
}

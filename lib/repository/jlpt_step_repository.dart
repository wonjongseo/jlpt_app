import 'package:hive/hive.dart';
import 'package:japanese_voca/jlpt_word_n1_data.dart';
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

  static void init(String nLevel) {
    print('JlptStepRepositroy ${nLevel}N init');

    final box = Hive.box(JlptStep.boxKey);

    List<List<Word>> words = Word.jsonToObject(nLevel);

    box.put('$nLevel-step-count', words.length);

    print('words.length: ${words.length}');

    for (int hiraganaIndex = 0; hiraganaIndex < words.length; hiraganaIndex++) {
      String hiragana = words[hiraganaIndex][0].headTitle;

      int wordsLengthByHiragana = words[hiraganaIndex].length;
      int stepCount = 0;

      words[hiraganaIndex].shuffle();

      for (int step = 0;
          step < wordsLengthByHiragana;
          step += MINIMUM_STEP_COUNT) {
        List<Word> currentWords = [];

        if (step + MINIMUM_STEP_COUNT > wordsLengthByHiragana) {
          currentWords = words[hiraganaIndex].sublist(step);
        } else {
          currentWords =
              words[hiraganaIndex].sublist(step, step + MINIMUM_STEP_COUNT);
        }
        currentWords.shuffle();

        JlptStep tempJlptStep = JlptStep(
            headTitle: hiragana,
            step: stepCount,
            words: currentWords,
            scores: 0);

        String key = '$nLevel-$hiragana-$stepCount';
        box.put(key, tempJlptStep);
        stepCount++;
      }
      box.put('$nLevel-$hiragana', stepCount);
    }
  }

  List<JlptStep> getJlptStepByHeadTitle(String nLevel, String headTitle) {
    final box = Hive.box(JlptStep.boxKey);

    int headTitleStepCount = box.get('$nLevel-$headTitle');
    List<JlptStep> jlptStepList = [];

    for (int step = 0; step < headTitleStepCount; step++) {
      String key = '$nLevel-$headTitle-$step';
      JlptStep jlptStep = box.get(key);
      jlptStepList.add(jlptStep);
    }

    return jlptStepList;
  }

  int getJlptHeadTitleCount(String nLevel) {
    final box = Hive.box(JlptStep.boxKey);

    int jlptHeadTieleCount = box.get('$nLevel-step-count', defaultValue: 0);
    print('jlptHeadTieleCount: ${jlptHeadTieleCount}');

    return jlptHeadTieleCount;
  }

  void updateJlptStep(JlptStep newJlptStep) {
    final box = Hive.box(JlptStep.boxKey);

    String key = '${newJlptStep.headTitle}-${newJlptStep.step}';
    box.put(key, newJlptStep);
  }
}

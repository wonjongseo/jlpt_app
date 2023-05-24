import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/model/grammar_step.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word_step.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/model/kangi_step.dart';

class LocalReposotiry {
  static Future<void> init() async {
    if (GetPlatform.isMobile) {
      await Hive.initFlutter();
    } else if (GetPlatform.isWindows) {
      Hive.init("C:/Users/kissco/Desktop/learning/jlpt_app/assets/hive");
    }

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(KangiAdapter());
    }
    if (!Hive.isAdapterRegistered(14)) {
      Hive.registerAdapter(KangiStepAdapter());
    }

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(WordAdapter());
    }

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(MyWordAdapter());
    }

    if (!Hive.isAdapterRegistered(10)) {
      Hive.registerAdapter(JlptStepAdapter());
    }

    if (!Hive.isAdapterRegistered(11)) {
      Hive.registerAdapter(GrammarAdapter());
    }

    if (!Hive.isAdapterRegistered(12)) {
      Hive.registerAdapter(GrammarStepAdapter());
    }

    if (!Hive.isAdapterRegistered(13)) {
      Hive.registerAdapter(ExampleAdapter());
    }
    if (!Hive.isBoxOpen('homeTutorialKey')) {
      await Hive.openBox('homeTutorialKey');
    }

    if (!Hive.isBoxOpen('grammarTutorialKey')) {
      await Hive.openBox('grammarTutorialKey');
    }

    if (!Hive.isBoxOpen('wordStudyTutorialKey')) {
      await Hive.openBox('wordStudyTutorialKey');
    }

    if (!Hive.isBoxOpen('autoSaveKey')) {
      await Hive.openBox('autoSaveKey');
    }

    if (!Hive.isBoxOpen('questionMarkKey')) {
      await Hive.openBox('questionMarkKey');
    }
    if (!Hive.isBoxOpen(Kangi.boxKey)) {
      await Hive.openBox(Kangi.boxKey);
    }

    if (!Hive.isBoxOpen(KangiStep.boxKey)) {
      await Hive.openBox(KangiStep.boxKey);
    }

    if (!Hive.isBoxOpen(Example.boxKey)) {
      await Hive.openBox(Example.boxKey);
    }

    if (!Hive.isBoxOpen(Grammar.boxKey)) {
      await Hive.openBox(Grammar.boxKey);
    }

    if (!Hive.isBoxOpen(GrammarStep.boxKey)) {
      await Hive.openBox(GrammarStep.boxKey);
    }

    if (!Hive.isBoxOpen(JlptStep.boxKey)) {
      await Hive.openBox(JlptStep.boxKey);
    }

    if (!Hive.isBoxOpen(Word.boxKey)) {
      await Hive.openBox<Word>(Word.boxKey);
    }

    if (!Hive.isBoxOpen(MyWord.boxKey)) {
      await Hive.openBox<MyWord>(MyWord.boxKey);
    }
  }

  static bool isSeenHomeTutorial() {
    return false;
    final homeTutorialBox = Hive.box('homeTutorialKey');

    String key = 'homeTutorial';

    if (!homeTutorialBox.containsKey(key)) {
      homeTutorialBox.put(key, true);
      return false;
    }

    if (homeTutorialBox.get(key) == false) {
      homeTutorialBox.put(key, true);
      return false;
    }

    return true;
  }

  static bool isSeenWordStudyTutorialTutorial() {
    return false;
    final wordStudyTutorialBox = Hive.box('wordStudyTutorialKey');

    String key = 'wordStudyTutorialKey';

    if (!wordStudyTutorialBox.containsKey(key)) {
      wordStudyTutorialBox.put(key, true);
      return false;
    }

    if (wordStudyTutorialBox.get(key) == false) {
      wordStudyTutorialBox.put(key, true);
      return false;
    }

    return true;
  }

  //

  static bool isSeenGrammarTutorial() {
    return false;
    final grammarTutorialBox = Hive.box('grammarTutorialKey');

    String key = 'grammarTutorial';

    if (!grammarTutorialBox.containsKey(key)) {
      grammarTutorialBox.put(key, true);
      return false;
    }

    if (grammarTutorialBox.get(key) == false) {
      grammarTutorialBox.put(key, true);
      return false;
    }

    return true;
  }

  static bool autoSaveOnOff() {
    final list = Hive.box('autoSaveKey');
    String key = 'autoSave';

    if (!list.containsKey(key)) {
      list.put(key, false);
      return false;
    }
    bool isAutoSave = list.get(key);

    list.put(key, !isAutoSave);
    return !isAutoSave;
  }

  static bool getAutoSave() {
    final list = Hive.box('autoSaveKey');
    String key = 'autoSave';
    return list.get(key, defaultValue: true);
  }

  static bool questionMarkOnOff() {
    final list = Hive.box('questionMarkKey');
    String key = 'questionMark';

    if (!list.containsKey(key)) {
      list.put(key, true);
      return true;
    }
    bool isAutoSave = list.get(key);

    list.put(key, !isAutoSave);

    return !isAutoSave;
  }

  static bool getquestionMark() {
    final list = Hive.box('questionMarkKey');
    String key = 'questionMark';
    return list.get(key, defaultValue: false);
  }
}

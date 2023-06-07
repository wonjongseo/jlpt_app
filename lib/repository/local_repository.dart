import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:japanese_voca/controller/user_controller.dart';
import 'package:japanese_voca/model/Question.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/model/grammar_step.dart';
import 'package:japanese_voca/model/hive_type.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/user.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/model/kangi_step.dart';

class LocalReposotiry {
  static Future<void> init() async {
    if (GetPlatform.isMobile) {
      await Hive.initFlutter();
    } else if (GetPlatform.isWindows) {
      Hive.init("C:/Users/kissco/Desktop/learning/jlpt_app/assets/hive");
    }

    if (!Hive.isAdapterRegistered(UserTypeId)) {
      Hive.registerAdapter(UserAdapter());
    }

    if (!Hive.isAdapterRegistered(KangiTypeId)) {
      Hive.registerAdapter(KangiAdapter());
    }
    if (!Hive.isAdapterRegistered(KangiStepTypeId)) {
      Hive.registerAdapter(KangiStepAdapter());
    }

    if (!Hive.isAdapterRegistered(WordTypeId)) {
      Hive.registerAdapter(WordAdapter());
    }

    if (!Hive.isAdapterRegistered(MyWordTypeId)) {
      Hive.registerAdapter(MyWordAdapter());
    }

    if (!Hive.isAdapterRegistered(JlptStepTypeId)) {
      Hive.registerAdapter(JlptStepAdapter());
    }

    if (!Hive.isAdapterRegistered(GrammarTypeId)) {
      Hive.registerAdapter(GrammarAdapter());
    }

    if (!Hive.isAdapterRegistered(GrammarStepTypeId)) {
      Hive.registerAdapter(GrammarStepAdapter());
    }

    if (!Hive.isAdapterRegistered(ExampleTypeId)) {
      Hive.registerAdapter(ExampleAdapter());
    }

    if (!Hive.isAdapterRegistered(QuestionTypeId)) {
      Hive.registerAdapter(QuestionAdapter());
    }

    if (!Hive.isBoxOpen(UserRepository.boxKey)) {
      log("await Hive.openBox(UserRepository.boxKey)");
      await Hive.openBox(UserRepository.boxKey);
    }
    if (!Hive.isBoxOpen('homeTutorialKey')) {
      log("await Hive.openBox('homeTutorialKey')");
      await Hive.openBox('homeTutorialKey');
    }

    if (!Hive.isBoxOpen('grammarTutorialKey')) {
      log("await Hive.openBox('grammarTutorialKey')");
      await Hive.openBox('grammarTutorialKey');
    }

    if (!Hive.isBoxOpen('wordStudyTutorialKey')) {
      log("await Hive.openBox('wordStudyTutorialKey')");
      await Hive.openBox('wordStudyTutorialKey');
    }

    if (!Hive.isBoxOpen('myWordTutorialKey')) {
      log("await Hive.openBox('myWordTutorialKey')");
      await Hive.openBox('myWordTutorialKey');
    }

    if (!Hive.isBoxOpen('autoSaveKey')) {
      log("await Hive.openBox('autoSaveKey')");
      await Hive.openBox('autoSaveKey');
    }

    if (!Hive.isBoxOpen('questionMarkKey')) {
      log("await Hive.openBox('questionMarkKey')");
      await Hive.openBox('questionMarkKey');
    }

    if (!Hive.isBoxOpen('textKeyBoardKey')) {
      log("await Hive.openBox('textKeyBoardKey')");
      await Hive.openBox('textKeyBoardKey');
    }

    if (!Hive.isBoxOpen('userJlptLevelKey')) {
      log("await Hive.openBox('userJlptLevelKey')");
      await Hive.openBox('userJlptLevelKey');
    }

    if (!Hive.isBoxOpen(User.boxKey)) {
      log("await Hive.openBox(User.boxKey)");
      await Hive.openBox(User.boxKey);
    }

    if (!Hive.isBoxOpen(Kangi.boxKey)) {
      log("await Hive.openBox(Kangi.boxKey)");
      await Hive.openBox(Kangi.boxKey);
    }

    if (!Hive.isBoxOpen(JlptStep.boxKey)) {
      log("await Hive.openBox(JlptStep.boxKey)");
      await Hive.openBox(JlptStep.boxKey);
    }

    if (!Hive.isBoxOpen(Example.boxKey)) {
      log("await Hive.openBox(Example.boxKey)");
      await Hive.openBox(Example.boxKey);
    }

    if (!Hive.isBoxOpen(Grammar.boxKey)) {
      log("await Hive.openBox(Grammar.boxKey)");
      await Hive.openBox(Grammar.boxKey);
    }

    if (!Hive.isBoxOpen(GrammarStep.boxKey)) {
      log("await Hive.openBox(GrammarStep.boxKey)");
      await Hive.openBox(GrammarStep.boxKey);
    }

    if (!Hive.isBoxOpen(KangiStep.boxKey)) {
      log("await Hive.openBox(KangiStep.boxKey)");
      await Hive.openBox(KangiStep.boxKey);
    }

    if (!Hive.isBoxOpen(Word.boxKey)) {
      log("await Hive.openBox<Word>(Word.boxKey)");
      await Hive.openBox<Word>(Word.boxKey);
    }

    if (!Hive.isBoxOpen(MyWord.boxKey)) {
      log("await Hive.openBox<MyWord>(MyWord.boxKey)");
      await Hive.openBox<MyWord>(MyWord.boxKey);
    }
  }

  static bool isSeenHomeTutorial({bool isRestart = false}) {
    // return false;
    final homeTutorialBox = Hive.box('homeTutorialKey');
    String key = 'homeTutorial';

    if (isRestart) {
      homeTutorialBox.put(key, false);
      return false;
    }

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

  static bool isSeenWordStudyTutorialTutorial({bool isRestart = false}) {
    final wordStudyTutorialBox = Hive.box('wordStudyTutorialKey');
    String key = 'wordStudyTutorialKey';

    if (isRestart) {
      wordStudyTutorialBox.put(key, false);
      return false;
    }

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

  static bool isSeenMyWordTutorial({bool isRestart = false}) {
    // return false;
    final myWordTutorialBox = Hive.box('myWordTutorialKey');

    String key = 'myWordTutorial';
    if (isRestart) {
      myWordTutorialBox.put(key, false);
      return false;
    }
    if (!myWordTutorialBox.containsKey(key)) {
      myWordTutorialBox.put(key, true);
      return false;
    }

    if (myWordTutorialBox.get(key) == false) {
      myWordTutorialBox.put(key, true);
      return false;
    }

    return true;
  }

  static bool isSeenGrammarTutorial({bool isRestart = false}) {
    // return false;
    final grammarTutorialBox = Hive.box('grammarTutorialKey');

    String key = 'grammarTutorial';
    if (isRestart) {
      grammarTutorialBox.put(key, false);
      return false;
    }

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

  static bool testKeyBoardOnfOFF() {
    final list = Hive.box('textKeyBoardKey');
    String key = 'textKeyBoard';

    if (!list.containsKey(key)) {
      list.put(key, false);
      return false;
    }
    bool isTextKeyBoard = list.get(key);

    list.put(key, !isTextKeyBoard);
    return !isTextKeyBoard;
  }

  static bool getTestKeyBoard() {
    final list = Hive.box('textKeyBoardKey');
    String key = 'textKeyBoard';
    return list.get(key, defaultValue: true);
  }

  static int getUserJlptLevel() {
    final list = Hive.box('userJlptLevelKey');
    String key = 'userJlptLevel';
    int level = list.get(key, defaultValue: 0);
    print('level: ${level}');

    return level;
  }

  static Future<void> updateUserJlptLevel(int level) async {
    final list = Hive.box('userJlptLevelKey');
    String key = 'userJlptLevel';

    await list.put(key, level);
  }
}

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/commonDialog.dart';
import 'package:japanese_voca/features/grammar_step/services/grammar_controller.dart';
import 'package:japanese_voca/model/Question.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/model/word.dart';

import '../../../common/admob/controller/ad_controller.dart';
import '../../../user/controller/user_controller.dart';
import '../grammar_test_screen.dart';

class GrammarTestController extends GetxController {
  late ScrollController scrollController;

  List<Question> questions = [];

  List<Map<int, List<Word>>> map = List.empty(growable: true);

  // [제출] 버튼 누르면 true
  bool isSubmitted = false;
  bool isTestAgain = false;
  late GrammarController grammarController;

  // 틀린 문제
  late List<int> wrongQIndList;
  // 선택된 인덱스
  late List<int> checkedQNumIndList;

  UserController userController = Get.find<UserController>();

  late AdController? adController;

  @override
  void onClose() {
    if (isSubmitted) {
      saveScore();
    }
    super.onClose();
  }

  void submit(double score) async {
    if (checkedQNumIndList.isNotEmpty) {
      String remainQuestions =
          checkedQNumIndList.map((e) => '${e + 1}').toString();

      if (!await CommonDialog.confirmToSubmitGrammarTest(remainQuestions)) {
        return;
      }
    }

    isSubmitted = true;
    scrollController.jumpTo(0);
    update();
  }

  void againTest() {
    saveScore();
    Get.offNamed(
      GRAMMAR_TEST_SCREEN,
      preventDuplicates: false,
      arguments: {
        'grammar': Get.arguments['grammar'],
        'isTestAgain': true,
      },
    );
  }

  void saveScore() {
    grammarController.updateScore(
      questions.length - wrongQIndList.length,
      isRetry: isTestAgain,
    );
  }

  void init(dynamic arguments) {
    adController = Get.find<AdController>();
    scrollController = ScrollController();
    startGrammarTest(arguments['grammar']);
    if (arguments['isTestAgain'] != null) {
      isTestAgain = true;
    }

    wrongQIndList = List.generate(questions.length, (index) => index);
    checkedQNumIndList = List.generate(questions.length, (index) => index);
  }

  void clickButton(int questionIndex, int selectedAnswerIndex) {
    Question question = questions[questionIndex];
    int correctAns = question.answer;

    if (correctAns == selectedAnswerIndex) {
      wrongQIndList.remove(questionIndex);
    } else {
      if (!wrongQIndList.contains(questionIndex)) {
        wrongQIndList.add(questionIndex);
      }
    }
    checkedQNumIndList.remove(questionIndex);

    update();
  }

  double getCurrentProgressValue() {
    double currentProgressValue =
        ((questions.length - checkedQNumIndList.length).toDouble() /
                questions.length.toDouble()) *
            100;

    return currentProgressValue;
  }

  double getScore() {
    double score = ((questions.length - wrongQIndList.length).toDouble() /
            questions.length.toDouble()) *
        100;

    return score;
  }

  void startGrammarTest(List<Grammar> grammars) {
    Random random = Random();
    grammarController = Get.find<GrammarController>();

    List<Word> words = [];

    for (int i = 0; i < grammars.length; i++) {
      List<Example> examples = grammars[i].examples;

      int randomExampleIndex = random.nextInt(examples.length);
      String word = examples[randomExampleIndex].word;

      word = word.replaceAll('<span class=\"bold\">', '');
      word = word.replaceAll('</span>', '');

      String answer = examples[randomExampleIndex].answer!;

      if (word.contains('<span class=\"bold\">') && word.contains('</span>')) {
        String pattern = '<span class="bold">';
        bool result = containsMoreThanOnce(word, pattern);
        if (result) {
          word = word.replaceAll(answer, '_____');
        } else {
          word = word.replaceAll(answer, '_____');
          List<String> tt = word.split('<span class=\"bold\">');
          word = "${tt[0]}_____${tt[1].split('</span>')[1]}";
        }
      } else {
        word = word.replaceAll(answer, '_____');
      }

      String yomikata = examples[randomExampleIndex].mean;

      Word tempWord = Word(
        word: word,
        mean: answer,
        yomikata: yomikata,
        headTitle: grammars[i].level,
      );

      words.add(tempWord);
    }

    map = Question.generateQustion(words);
    setQuestions();
  }

  bool containsMoreThanOnce(String str, String pattern) {
    RegExp regExp = RegExp(pattern);
    Iterable<RegExpMatch> matches = regExp.allMatches(str);
    return matches.length >= 2;
  }

  void setQuestions() {
    for (var vocas in map) {
      for (var e in vocas.entries) {
        List<Word> optionsVoca = e.value;
        Word questionVoca = optionsVoca[e.key];

        Question question = Question(
          question: questionVoca,
          answer: e.key,
          options: optionsVoca,
        );

        questions.add(question);
      }
    }
    for (int i = 0; i < questions.length; i++) {
      print('${i + 1} ${questions[i].answer + 1}');
    }
  }
}

import 'dart:math';

import 'package:get/get.dart';
import 'package:japanese_voca/controller/grammar_controller.dart';
import 'package:japanese_voca/model/Question.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/model/word.dart';

class GrammarQuestionController extends GetxController {
  List<Question> questions = [];

  bool isKorean = true;

  List<Map<int, List<Word>>> map = List.empty(growable: true);

  bool isGrammer = false;
  late GrammarController grammarController;

  void startGrammarQuiz(List<Grammar> grammars) {
    isGrammer = true;
    Random random = Random();
    grammarController = Get.find<GrammarController>();

    List<Word> words = [];

    for (int i = 0; i < grammars.length; i++) {
      List<Example> examples = grammars[i].examples;

      int randomExampleIndex = random.nextInt(examples.length);
      String word = examples[randomExampleIndex].word;
      String answer = examples[randomExampleIndex].answer;

      word = word.replaceAll(answer, '_____');

      String yomikata = examples[randomExampleIndex].mean;

      Word tempWord = Word(
        id: -1,
        word: word,
        mean: answer,
        yomikata: yomikata,
        headTitle: grammars[i].level,
      );

      words.add(tempWord);
    }

    map = Question.generateQustion(words);
    setQuestions(isKorean);
  }

  void setQuestions(bool isKorean) {
    this.isKorean = isKorean;
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
  }
}
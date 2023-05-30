import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/controller/grammar_controller.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/controller/jlpt_word_controller.dart';
import 'package:japanese_voca/model/Question.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/screen/score/score_screen.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController _animationController;
  late Animation _animation;
  late PageController _pageController;
  List<Map<int, List<Word>>> map = List.empty(growable: true);
  late JlptWordController jlptWordController;
  late GrammarController grammarController;

  bool _isWrong = false;
  List<Question> questions = [];
  List<Question> wrongQuestions = [];

  bool isKorean = true;
  int step = 0;
  bool _isAnswered = false;
  int _correctAns = 0;
  late int _selectedAns;
  RxInt _questionNumber = 1.obs;
  int _numOfCorrectAns = 0;
  String _text = 'skip';
  Color _color = Colors.white;
  int day = 0;
  bool isGrammer = false;
  bool isKangi = false;
  bool _isEnd = false;

  void toContinue() {
    _pageController.dispose();
    _pageController = PageController();
    _questionNumber = 1.obs;
    _isWrong = false;
    questions = wrongQuestions;
    questions.shuffle();
    wrongQuestions = [];
    _isAnswered = false;
    _correctAns = 0;
    _selectedAns = 0;
    _numOfCorrectAns = 0;
    isKorean = true;
    _text = 'skip';
    _color = Colors.white;
    update();
  }

  PageController get pageController => _pageController;
  Animation get animation => _animation;
  String get text => _text;
  bool get isAnswered => _isAnswered;
  int get correctAns => _correctAns;
  int get selectedAns => _selectedAns;
  RxInt get questionNumber => _questionNumber;
  int get numOfCorrectAns => _numOfCorrectAns;
  Color get color => _color;
  bool get isWrong => _isWrong;
  bool get isEnd => _isEnd;

  void startJlptQuiz(List<Word> words, bool isKorean) {
    jlptWordController = Get.find<JlptWordController>();
    map = Question.generateQustion(words);
    setQuestions(isKorean);
  }

  void startKangiQuiz(List<Kangi> kangis, bool isKorean) {
    isKangi = true;

    List<Word> words = [];

    for (int i = 0; i < kangis.length; i++) {
      words.add(kangis[i].kangiToWord());
    }

    map = Question.generateQustion(words);
    setQuestions(isKorean);
  }

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
          headTitle: grammars[i].level);

      words.add(tempWord);
    }

    map = Question.generateQustion(words);
    setQuestions(isKorean);
  }

  @override
  void onInit() {
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });

    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    _animationController.dispose();
    _pageController.dispose();
    super.onClose();
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

  void checkAnsForGrammar(Question question, int selectedIndex) {
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) {
      _numOfCorrectAns++;
    } else {
      if (!wrongQuestions.contains(questions[_questionNumber.value - 1])) {
        wrongQuestions.add(questions[_questionNumber.value - 1]);
      }
    }
  }

  void checkAns(Question question, int selectedIndex) {
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (isGrammer) {
      _correctAns = question.answer;
      _selectedAns = selectedIndex;

      if (_correctAns == _selectedAns) {
        _numOfCorrectAns++;
      } else {
        if (!wrongQuestions.contains(questions[_questionNumber.value - 1])) {
          wrongQuestions.add(questions[_questionNumber.value - 1]);
        }
      }
    } else {
      _isAnswered = true;
      _animationController.stop();
      update();
      if (_correctAns == _selectedAns) {
        _text = 'skip';
        _numOfCorrectAns++;
        if (isGrammer) {
          _color = Colors.blue;
          _text = 'next';
        }
        if (!isGrammer) {
          Future.delayed(const Duration(milliseconds: 800), () {
            nextQuestion();
          });
        }
      } else {
        if (!wrongQuestions.contains(questions[_questionNumber.value - 1])) {
          wrongQuestions.add(questions[_questionNumber.value - 1]);
        }
        _isWrong = true;
        _color = Colors.pink;
        _text = 'next';
        if (!isGrammer) {
          Future.delayed(const Duration(milliseconds: 1200), () {
            nextQuestion();
          });
        }
      }
    }
  }

  void nextQuestion() {
    if (_questionNumber.value != questions.length) {
      _isWrong = false;
      _text = 'skip';
      _color = Colors.white;
      _isAnswered = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);

      _animationController.reset();
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      if (questions.length == numOfCorrectAns || wrongQuestions.length < 4) {
        _isEnd = true;
      }

      if (isGrammer) {
        grammarController.updateScore(_numOfCorrectAns);
      } else {
        jlptWordController.updateScore(_numOfCorrectAns);
      }
      Get.toNamed(SCORE_PATH);
    }
  }

  void skipQuestion() {
    _isAnswered = true;
    _animationController.stop();
    if (!wrongQuestions.contains(questions[_questionNumber.value - 1])) {
      wrongQuestions.add(questions[_questionNumber.value - 1]);
    }
    _isWrong = true;
    _color = Colors.pink;
    _text = 'next';
    nextQuestion();
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

  String get scoreResult => '$numOfCorrectAns / ${questions.length}';

  String wrongMean(int index) {
    return '${wrongQuestions[index].options[wrongQuestions[index].answer].mean}\n${wrongQuestions[index].options[wrongQuestions[index].answer].yomikata}';
  }

  String wrongWord(int index) {
    return wrongQuestions[index].question.word;
  }
}

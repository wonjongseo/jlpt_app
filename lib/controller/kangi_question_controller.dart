import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/controller/kangi_controller.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/Question.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/screen/score/score_screen.dart';

class KangiQuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController _animationController;
  late Animation _animation;
  late PageController _pageController;
  List<Map<int, List<Word>>> map = List.empty(growable: true);

  late KangiController kangiController;
  bool _isWrong = false;
  List<Question> questions = [];
  List<Question> wrongQuestions = [];

  int step = 0;
  bool _isAnswered = false;
  int _correctAns = 0;
  late int _selectedAns;
  RxInt _questionNumber = 1.obs;
  int _numOfCorrectAns = 0;
  String _text = 'skip';
  Color _color = Colors.white;
  int day = 0;
  bool isKangi = false;

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
  // bool get isEnd => _isEnd;

  void startKangiQuiz(List<Kangi> kangis) {
    kangiController = Get.find<KangiController>();
    isKangi = true;

    List<Word> words = [];

    for (int i = 0; i < kangis.length; i++) {
      words.add(kangis[i].kangiToWord());
    }

    map = Question.generateQustion(words);
    setQuestions();
  }

  @override
  void onInit() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
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
  }

  void checkAns(Question question, int selectedIndex) {
    _correctAns = question.answer;
    _selectedAns = selectedIndex;
    _isAnswered = true;
    _animationController.stop();

    update();

    if (_correctAns == _selectedAns) {
      _text = 'skip';
      _numOfCorrectAns++;
      _color = Colors.blue;
      _text = 'next';
      Future.delayed(const Duration(milliseconds: 800), () {
        nextQuestion();
      });
    } else {
      if (!wrongQuestions.contains(questions[_questionNumber.value - 1])) {
        wrongQuestions.add(questions[_questionNumber.value - 1]);
      }
      _isWrong = true;
      _color = Colors.pink;
      _text = 'next';
      Future.delayed(const Duration(milliseconds: 1200), () {
        nextQuestion();
      });
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

  void nextQuestion() {
    // 테스트 문제가 남아 있으면.
    if (_questionNumber.value != questions.length) {
      _isWrong = false;
      _text = 'skip';
      _color = Colors.white;
      _isAnswered = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);

      _animationController.reset();
      _animationController.forward().whenComplete(nextQuestion);
    }
    // 테스트를 다 풀 었으면
    else {
      kangiController.updateScore(_numOfCorrectAns);

      Get.toNamed(SCORE_PATH);
    }
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/model/Question.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/screen/score_screen.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController _animationController;
  late Animation _animation;
  late PageController _pageController;
  List<Map<int, List<Word>>> map = List.empty(growable: true);

  // late VocabularyController vocabularyController;

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
  Color _color = Colors.black;
  int day = 0;
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
    for (var vocas in map) {
      for (var e in vocas.entries) {
        List<Word> optionsVoca = e.value;
        Word questionVoca = optionsVoca[e.key];

        Question question = Question(
          question: questionVoca,
          answer: e.key,
          options: isKorean
              ? optionsVoca.map((e) => e.mean).toList()
              : optionsVoca.map((e) => e.yomikata).toList(),
        );

        questions.add(question);
      }
    }
  }

  void checkAns(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;
    _animationController.stop();
    update();

    if (_correctAns == _selectedAns) {
      // if (!(day == -1 || step == -1)) {
      //   vocabularyController.updateScore(day, step);
      // }
      _text = 'skip';
      _numOfCorrectAns++;
      Future.delayed(const Duration(milliseconds: 500), () {
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

  void nextQuestion() {
    if (_questionNumber.value != questions.length) {
      _isWrong = false;
      _text = 'skip';
      _color = Colors.black;
      _isAnswered = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);

      _animationController.reset();
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      if (questions.length == numOfCorrectAns || wrongQuestions.length < 4) {
        _isEnd = true;
      }

      if (_numOfCorrectAns == questions.length) {
        List<String> keys =
            List.generate(questions.length, (index) => index.toString());
        // _knownVocaRepositry.deleteKnownVoca(keys);
      }

      Get.to(const ScoreScreen(), arguments: {'day': day});
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
}

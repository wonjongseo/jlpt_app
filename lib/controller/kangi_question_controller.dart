import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/ad_controller.dart';
import 'package:japanese_voca/controller/kangi_controller.dart';
import 'package:japanese_voca/controller/user_controller.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/Question.dart';
import 'package:japanese_voca/model/word.dart';

import '../screen/score/kangi_score_screen.dart';

class KangiQuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  late Animation animation;
  late PageController pageController;
  List<Map<int, List<Word>>> map = List.empty(growable: true);
  AdController adController = Get.find<AdController>();
  UserController userController = Get.find<UserController>();

  late KangiController kangiController;

  // 틀릴 경우
  bool isWrong = false;

  List<Question> questions = [];
  List<Question> wrongQuestions = [];

  int step = 0;
  bool isAnswered1 = false;
  bool isAnswered2 = false;
  bool isAnswered3 = false;

  // 정답 인덱스 -> 인덱스 말고 문자열이 같은지 비교할 거임
  String correctAns = '';
  String correctAns2 = '';
  String correctAns3 = '';
  // 선택된 문제 인덱스 -> 인덱스 말고 문자열이 같은지 비교할 거임.
  late String selectedAns;
  late String selectedAns2;
  late String selectedAns3;

  // 현재 인덱스
  RxInt questionNumber = 1.obs;

  // 맞춘 정답
  int numOfCorrectAns = 0;
  String text = 'skip';
  Color color = Colors.white;
  int day = 0;
  bool isKangi = false;

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
    animationController =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addListener(() {
        update();
      });

    animationController.forward().whenComplete(nextQuestion);
    pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    pageController.dispose();
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

  void checkAns(Question question, String selectedIndex, String type) {
    if (type == 'hangul') {
      correctAns = question.question.mean;
      selectedAns = selectedIndex;
      isAnswered1 = true;
    } else if (type == 'undoc') {
      correctAns2 = question.question.yomikata.split('@')[0];
      selectedAns2 = selectedIndex;
      isAnswered2 = true;
    } else if (type == 'hundoc') {
      correctAns3 = question.question.yomikata.split('@')[1];
      selectedAns3 = selectedIndex;
      isAnswered3 = true;
    }
    if (!(isAnswered1 && isAnswered2 && isAnswered3)) {
      print('object2');
      return;
    } else {
      animationController.stop();
      update();

      if (correctAns == selectedAns &&
          correctAns2 == selectedAns2 &&
          correctAns3 == selectedAns3) {
        text = 'skip';
        numOfCorrectAns++;
        color = Colors.blue;
        text = 'next';
        Future.delayed(const Duration(milliseconds: 800), () {
          nextQuestion();
        });
      } else {
        if (!wrongQuestions.contains(questions[questionNumber.value - 1])) {
          wrongQuestions.add(questions[questionNumber.value - 1]);
        }
        isWrong = true;
        color = Colors.pink;
        text = 'next';
        Future.delayed(const Duration(milliseconds: 1200), () {
          nextQuestion();
        });
      }
    }
  }

  void skipQuestion() {
    isAnswered1 = true;
    isAnswered2 = true;
    isAnswered3 = true;
    animationController.stop();
    if (!wrongQuestions.contains(questions[questionNumber.value - 1])) {
      wrongQuestions.add(questions[questionNumber.value - 1]);
    }
    isWrong = true;
    color = Colors.pink;
    text = 'next';
    nextQuestion();
  }

  void nextQuestion() {
    // 테스트 문제가 남아 있으면.
    if (questionNumber.value != questions.length) {
      isWrong = false;
      text = 'skip';
      color = Colors.white;
      isAnswered1 = false;
      isAnswered2 = false;
      isAnswered3 = false;

      pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);

      animationController.reset();
      animationController.forward().whenComplete(nextQuestion);
    }
    // 테스트를 다 풀 었으면
    else {
      if (numOfCorrectAns == questions.length) {
        userController.plusHeart(plusHeartCount: 3);
      }
      // AD
      adController.showRewardedInterstitialAd();
      kangiController.updateScore(numOfCorrectAns);

      Get.toNamed(KANGI_SCORE_PATH);
    }
  }

  void updateTheQnNum(int index) {
    questionNumber.value = index + 1;
  }

  String get scoreResult => '$numOfCorrectAns / ${questions.length}';

  String wrongMean(int index) {
    return '${wrongQuestions[index].options[wrongQuestions[index].answer].mean}\n${wrongQuestions[index].options[wrongQuestions[index].answer].yomikata}';
  }

  String wrongWord(int index) {
    return wrongQuestions[index].question.word;
  }
}
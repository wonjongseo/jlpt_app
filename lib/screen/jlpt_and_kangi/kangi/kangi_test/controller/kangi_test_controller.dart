import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/controller/ad_controller.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/screen/jlpt_and_kangi/kangi/controller/kangi_step_controller.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/Question.dart';
import 'package:japanese_voca/model/word.dart';

import '../../../../../common/admob/banner_ad/banner_ad_controller.dart';
import '../../../../score/kangi_score_screen.dart';
import '../../../../user/controller/user_controller.dart';
import '../kangi_test_screen.dart';

class KangiTestController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  late Animation animation;
  late PageController pageController;
  List<Map<int, List<Word>>> map = List.empty(growable: true);
  AdController adController = Get.find<AdController>();
  UserController userController = Get.find<UserController>();

  late KangiStepController kangiController;
  BannerAdController bannerAdController = Get.find<BannerAdController>();
  // 틀릴 경우
  bool isWrong = false;

  void init(dynamic arguments) {
    if (!userController.isUserPremieum()) {
      if (!bannerAdController.loadingScoreBanner) {
        bannerAdController.loadingScoreBanner = true;
        bannerAdController.createScoreBanner();
      }
    }

    // 모든 문제로 테스트 준비해기
    if (arguments != null && arguments[KANGI_TEST] != null) {
      startKangiQuiz(arguments[KANGI_TEST]);
    }
    // 과거에 틀린 문제로만 테스트 준비하기
    else {
      startKangiQuizHistory(
        arguments[CONTINUTE_KANGI_TEST],
      );
    }
    initTestAnswer();
  }

  Random random = Random();
  List<int> randumIndexs = [];
  List<int> randumIndexs2 = [];

  void initTestAnswer() {
    randumIndexs = [];
    randumIndexs2 = [];

    for (int i = 0; randumIndexs.length < 4; i++) {
      int temp = random.nextInt(4);

      if (randumIndexs.contains(temp)) continue;

      randumIndexs.add(temp);
    }

    for (int i = 0; randumIndexs2.length < 4; i++) {
      int temp = random.nextInt(4);

      if (randumIndexs2.contains(temp)) continue;

      randumIndexs2.add(temp);
    }
  }

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
  bool isDisTouchable = false;

  void startKangiQuiz(List<Kangi> kangis) {
    kangiController = Get.find<KangiStepController>();

    List<Word> words = [];

    for (int i = 0; i < kangis.length; i++) {
      words.add(kangis[i].kangiToWord());
    }
    kangiController.getKangiStep().scores = 0;
    map = Question.generateQustion(words);

    setQuestions();
  }

  void startKangiQuizHistory(List<Question> wrongQuestions) {
    kangiController = Get.find<KangiStepController>();
    // isKangi = true;
    questions = wrongQuestions;

    questions.shuffle();
    for (int i = 0; i < questions.length; i++) {
      questions[i].options.shuffle();
    }

    for (int i = 0; i < questions.length; i++) {
      questions[i].options.shuffle();
    }
    for (int i = 0; i < questions.length; i++) {
      for (int j = 0; j < questions[i].options.length; j++) {
        if (questions[i].question.word == questions[i].options[j].word) {
          questions[i].answer = j;
          break;
        }
      }
    }
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
    // 운독, 훈독, 읽는 법을 다 채크 했니 ?
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

    // 운독, 훈독, 읽는 법 중 하나라도 채크가 안됬으면  리턴.
    if (!(isAnswered1 && isAnswered2 && isAnswered3)) {
      return;
    } else {
      isDisTouchable = true;
      animationController.stop();
      update();

      // 정답 이면
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
        saveWrongQuestion();
        isWrong = true;
        color = Colors.pink;
        text = 'next';
        Future.delayed(const Duration(milliseconds: 1500), () {
          nextQuestion();
        });
      }
    }
  }

  void saveWrongQuestion() {
    if (!wrongQuestions.contains(questions[questionNumber.value - 1])) {
      wrongQuestions.add(questions[questionNumber.value - 1]);
    }
  }

  void skipQuestion() {
    isDisTouchable = false;
    isAnswered1 = true;
    isAnswered2 = true;
    isAnswered3 = true;
    animationController.stop();
    saveWrongQuestion();
    isWrong = true;
    color = Colors.pink;
    text = 'next';
    nextQuestion();
  }

  void nextQuestion() {
    initTestAnswer();
    isDisTouchable = false;

    // 테스트 문제가 남아 있으면.
    if (questionNumber.value != questions.length) {
      if (!(isAnswered1 && isAnswered2 && isAnswered3)) {
        saveWrongQuestion();
      }
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
      kangiController.updateScore(numOfCorrectAns, wrongQuestions);

      Get.toNamed(KANGI_SCORE_PATH, arguments: {});
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

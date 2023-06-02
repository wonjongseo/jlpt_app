import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/ad_controller.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/controller/jlpt_word_controller.dart';
import 'package:japanese_voca/controller/user_controller.dart';
import 'package:japanese_voca/model/Question.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/screen/score/score_screen.dart';

class QuestionController extends GetxController
    with
        // ignore: deprecated_member_use
        SingleGetTickerProviderMixin {
  AdController adController = Get.find<AdController>();
  UserController userController = Get.find<UserController>();
  late AnimationController animationController;
  late Animation animation;
  late PageController pageController;
  List<Map<int, List<Word>>> map = List.empty(growable: true);
  late JlptWordController jlptWordController;
  late TextEditingController textEditingController;
  String inputValue = '';

  late FocusNode focusNode;
  bool isWrong = false;
  List<Question> questions = [];
  List<Question> wrongQuestions = [];

  late Word correctQuestion;
  int step = 0;
  bool isAnswered = false;
  int correctAns = 0;
  late int selectedAns;
  RxInt questionNumber = 1.obs;
  int numOfCorrectAns = 0;
  String text = 'skip';
  Color color = Colors.white;
  int day = 0;
  bool isKangi = false;

  void startJlptQuiz(List<Word> words) {
    jlptWordController = Get.find<JlptWordController>();
    map = Question.generateQustion(words);
    setQuestions();
  }

  void onFieldSubmitted(String value) {
    inputValue = value;
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
    textEditingController = TextEditingController();
    focusNode = FocusNode();

    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    pageController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
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

  void checkAnsForGrammar(Question question, int selectedIndex) {
    correctAns = question.answer;
    selectedAns = selectedIndex;

    if (correctAns == selectedAns) {
      numOfCorrectAns++;
    } else {
      if (!wrongQuestions.contains(questions[questionNumber.value - 1])) {
        wrongQuestions.add(questions[questionNumber.value - 1]);
      }
    }
  }

  Color getTheTextEditerBorderRightColor({bool isBorder = true}) {
    if (isAnswered) {
      if (formattingQuestion(correctQuestion.yomikata, inputValue)
          // correctQuestion.yomikata.replaceAll('-', '') == inputValue.replaceAll('-', '')
          ) {
        return const Color(0xFF6AC259);
      } else {
        return const Color(0xFFE92E30);
      }
    }
    return isBorder ? Colors.black.withOpacity(0.5) : AppColors.black;
  }

  void requestFocus() {
    focusNode.requestFocus();
  }

  void checkAns(Question question, int selectedIndex) {
    correctAns = question.answer;
    selectedAns = selectedIndex;
    isAnswered = true;

    correctQuestion = question.options[correctAns];

    if (textEditingController.text.isEmpty) {
      requestFocus();
      return;
    }

    animationController.stop();
    update();
    if (correctAns == selectedAns &&
        // correctQuestion.yomikata.replaceAll('-', '') ==inputValue.replaceAll('-', '')
        formattingQuestion(correctQuestion.yomikata, inputValue)) {
      text = 'skip';
      numOfCorrectAns++;
      color = Colors.blue;
      text = 'next';
      Future.delayed(const Duration(milliseconds: 800), () {
        nextQuestion();
      });
      // }
    } else {
      if (!wrongQuestions.contains(questions[questionNumber.value - 1])) {
        wrongQuestions.add(questions[questionNumber.value - 1]);
      }
      isWrong = true;
      color = Colors.pink;
      text = 'next';
      Future.delayed(
        const Duration(milliseconds: 1500),
        () {
          nextQuestion();
        },
      );
    }
  }

  bool formattingQuestion(String correct, String answer) {
    correct.trim();

    answer.trim();

    correct = correct.replaceAll('-', '');
    correct = correct.replaceAll('ー', '');
    correct = correct.replaceAll('　', '');
    correct = correct.replaceAll(' ', '');

    answer = answer.replaceAll('-', '');
    answer = answer.replaceAll('ー', '');
    answer = answer.replaceAll(' ', '');
    answer = answer.replaceAll('　', '');

    return answer == correct;
  }

  void skipQuestion() {
    isAnswered = true;
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
      isAnswered = false;
      textEditingController.clear();

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

      jlptWordController.updateScore(numOfCorrectAns);
      Get.toNamed(SCORE_PATH);
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

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/controller/ad_controller.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/controller/jlpt_word_controller.dart';
import 'package:japanese_voca/controller/my_voca_controller.dart';
import 'package:japanese_voca/screen/setting/services/setting_controller.dart';
import 'package:japanese_voca/model/Question.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/screen/score/score_screen.dart';

import '../common/admob/banner_ad/banner_ad_controller.dart';
import '../model/my_word.dart';
import '../screen/jlpt/jlpt_quiz/jlpt_quiz_screen.dart';
import 'user_controller.dart';

class JlptQuizController extends GetxController
    with SingleGetTickerProviderMixin {
  late BannerAdController? bannerAdController;
  MyVocaController? myVocaController;

  void init(dynamic arguments) {
    if (arguments != null && arguments[MY_VOCA_TEST] != null) {
      // 나만의 시험 초기화
      myVocaController = Get.find<MyVocaController>();
      startMyVocaQuiz(arguments[MY_VOCA_TEST]);
    } else if (arguments != null && arguments[JLPT_TEST] != null) {
      // JLPT 단어 시험 초기화
      startJlptQuiz(arguments[JLPT_TEST]);
    } else {
      // 과거에 틀린 문제로만 테스트 준비하기
      startJlptQuizHistory(
        arguments[CONTINUTE_JLPT_TEST],
      );
    }

    if (!userController.user.isPremieum) {
      bannerAdController = Get.find<BannerAdController>();
      if (!bannerAdController!.loadingTestBanner) {
        bannerAdController!.loadingTestBanner = true;
        bannerAdController!.createTestBanner();
      }
    }
  }

  AdController adController = Get.find<AdController>();
  UserController userController = Get.find<UserController>();
  SettingController settingController = Get.find<SettingController>();

  // 진행률 바
  late AnimationController animationController;
  // 진행률 바 애니메이션
  late Animation animation;

  // 문제 컨트롤러
  late PageController pageController;

  // 퀴즈를 위한 맵.
  List<Map<int, List<Word>>> map = List.empty(growable: true);

  late JlptStepController jlptWordController;

  TextEditingController? textEditingController;
  FocusNode? focusNode;
  String? inputValue;

  bool isSubmitted = false;
  bool isMyWordTest = false;
  // 읽는 법 값

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

  void manualSaveToMyVoca(int index) {
    if (isMyWordTest) {
      return;
    }

    // 수동
    MyWord.saveToMyVoca(
      wrongQuestions[index].question,
    );
  }

  void startJlptQuiz(List<Word> words) {
    jlptWordController = Get.find<JlptStepController>();
    map = Question.generateQustion(words);
    // 테스트 다시 시작한 것이기 때문에,
    // 기존에 저장 되어 있는 점수 초기화.
    jlptWordController.getJlptStep().scores = 0;
    setQuestions();
  }

  void startMyVocaQuiz(List<MyWord> myWords) {
    isMyWordTest = true;
    List<Word> tempWords = List.generate(
      myWords.length,
      (i) => Word(
          word: myWords[i].word,
          mean: myWords[i].mean,
          yomikata: myWords[i].yomikata ?? '',
          headTitle: ''),
    );

    map = Question.generateQustion(tempWords);
    setQuestions();
  }

  void startJlptQuizHistory(List<Question> wrongQuestions) {
    jlptWordController = Get.find<JlptStepController>();
    questions = wrongQuestions;

    questions.shuffle();
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

  void onFieldSubmitted(String value) {
    inputValue = value;
  }

  @override
  void onInit() {
    animationController =
        AnimationController(duration: const Duration(seconds: 30), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addListener(() {
        update();
      });

    animationController.forward().whenComplete(nextQuestion);
    pageController = PageController();

    if (settingController.isTestKeyBoard) {
      textEditingController = TextEditingController();
      focusNode = FocusNode();
    }

    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    pageController.dispose();
    textEditingController?.dispose();
    focusNode?.dispose();
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

  void saveWrongQuestion() {
    if (!wrongQuestions.contains(questions[questionNumber.value - 1])) {
      wrongQuestions.add(questions[questionNumber.value - 1]);
    }
  }

  Color getTheTextEditerBorderRightColor({bool isBorder = true}) {
    if (isAnswered) {
      if (formattingQuestion(correctQuestion.yomikata, inputValue!)) {
        return const Color(0xFF6AC259);
      } else {
        return const Color(0xFFE92E30);
      }
    }
    return isBorder ? Colors.black.withOpacity(0.5) : AppColors.black;
  }

  void requestFocus() {
    focusNode?.requestFocus();
  }

  void checkAns(Question question, int selectedIndex) {
    isSubmitted = true;
    correctAns = question.answer;
    selectedAns = selectedIndex;
    isAnswered = true;

    correctQuestion = question.options[correctAns];

    if (settingController.isTestKeyBoard) {
      if (textEditingController!.text.isEmpty) {
        requestFocus();
        return;
      }
    }

    animationController.stop();
    update();

    // if 설정에서 읽는법도 테스트에 포함
    if (settingController.isTestKeyBoard) {
      if (correctAns == selectedAns &&
          formattingQuestion(correctQuestion.yomikata, inputValue!)) {
        testCorect();
      } else {
        textWrong();
      }
    }
    // if 설정에서 읽는법도 테스트에 포함하지 않았나.
    else if (correctAns == selectedAns) {
      testCorect();
    } else {
      textWrong();
    }
  }

  textWrong() {
    if (isMyWordTest) {
      myVocaController!.updateWord(correctQuestion.word, false);
    }
    saveWrongQuestion();
    isWrong = true;
    color = Colors.pink;
    text = 'next';
    Future.delayed(const Duration(milliseconds: 1500), () {
      nextQuestion();
    });
  }

  testCorect() {
    text = 'skip';
    numOfCorrectAns++;
    color = Colors.blue;
    text = 'next';
    if (isMyWordTest) {
      myVocaController!.updateWord(correctQuestion.word, true);
    }
    Future.delayed(const Duration(milliseconds: 800), () {
      nextQuestion();
    });
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
    print('skipQuestion');
    isAnswered = true;

    animationController.stop();
    saveWrongQuestion();
    isWrong = true;
    color = Colors.pink;
    text = 'next';
    nextQuestion();
  }

  void nextQuestion() {
    print('nextQuestion');
    isSubmitted = false;
    /**
     * if 테스트 문제가 남아 있다면.
     *  if 정답을 틀렸다면
     * 
     * 초기화
     * 
     */
    if (questionNumber.value != questions.length) {
      if (!isAnswered) {
        saveWrongQuestion();
      }
      isWrong = false;
      text = 'skip';
      color = Colors.white;
      isAnswered = false;

      textEditingController?.clear();

      pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);

      animationController.reset();
      animationController.forward().whenComplete(nextQuestion);
    }
    // 테스트를 다 풀 었으면
    else {
      // AD
      adController.showRewardedInterstitialAd();
      if (!isMyWordTest) {
        jlptWordController.updateScore(numOfCorrectAns, wrongQuestions);
      }

      if (numOfCorrectAns == questions.length) {
        userController.plusHeart(plusHeartCount: HERAT_COUNT_AD);
        getBacks(2);
        return;
      }
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

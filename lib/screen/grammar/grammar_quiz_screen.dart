import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/background.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/controller/grammar_controller.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:japanese_voca/model/Question.dart';
import 'package:japanese_voca/screen/grammar/components/grammar_quiz_card.dart';
import 'package:japanese_voca/screen/grammar/components/score_and_message.dart';

const GRAMMAR_QUIZ_SCREEN = '/grammar_quiz';

class GrammarQuizScreen extends StatefulWidget {
  const GrammarQuizScreen({super.key});

  @override
  State<GrammarQuizScreen> createState() => _GrammarQuizScreenState();
}

class _GrammarQuizScreenState extends State<GrammarQuizScreen> {
  late ScrollController scrollController;

  late GrammarController grammarController;
  QuestionController questionController = Get.put(QuestionController());
  late List<int> wrongQuetionIndexList;
  late List<int> checkedQuestionNumberIndexList;

  // [제출] 버튼 누르면 true
  bool isSubmitted = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    // GrammerScreen 에서 grammar 파라티머 받음.
    questionController.startGrammarQuiz(Get.arguments['grammar']);

    /**
     * 틀린 퀴즈 인덱스 리스트
     */
    wrongQuetionIndexList =
        List.generate(questionController.questions.length, (index) => index);
    checkedQuestionNumberIndexList =
        List.generate(questionController.questions.length, (index) => index);
  }

  /*
  * 사지선다 문제 중 클릭 할 때마다 함수 발생
  * 정답 맞추면 리스트에서 제거
  * 틀리면 리스트에 추가 (중복 체크 불가) 
  */
  void clickButton(int questionIndex, int selectedAnswerIndex) {
    Question question = questionController.questions[questionIndex];
    int correctAns = question.answer;

    if (correctAns == selectedAnswerIndex) {
      wrongQuetionIndexList.remove(questionIndex);
    } else {
      if (!wrongQuetionIndexList.contains(questionIndex)) {
        wrongQuetionIndexList.add(questionIndex);
      }
    }
    checkedQuestionNumberIndexList.remove(questionIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // 진행률 백분율
    double currentProgressValue = ((questionController.questions.length -
                    checkedQuestionNumberIndexList.length)
                .toDouble() /
            questionController.questions.length.toDouble()) *
        100;

    // 점수 백분율
    double score =
        ((questionController.questions.length - wrongQuetionIndexList.length)
                    .toDouble() /
                questionController.questions.length.toDouble()) *
            100;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(currentProgressValue, size),
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (isSubmitted)
                  // 점수와 격려의 메세지 출력.
                  ScoreAndMessage(
                    score: score,
                    size: size,
                  ),
                ...List.generate(
                  questionController.questions.length,
                  (questionIndex) {
                    return GrammarQuizCard(
                      size: size,
                      questionIndex: questionIndex,
                      question: questionController.questions[questionIndex],
                      onChanged: (int selectedAnswerIndex) {
                        clickButton(questionIndex, selectedAnswerIndex);
                      },
                      isCorrect: !wrongQuetionIndexList.contains(questionIndex),
                      isSubmitted: isSubmitted,
                    );
                  },
                ),
                CustomButton(
                    text: isSubmitted ? '다시 하기' : '제출',
                    onTap: () {
                      if (isSubmitted) {
                        saveScore();
                        Get.offNamed(GRAMMAR_QUIZ_SCREEN,
                            preventDuplicates: false,
                            arguments: {'grammar': Get.arguments['grammar']});
                      } else {
                        isSubmitted = true;
                        scrollController.jumpTo(0);
                        setState(() {});
                      }
                    }),
                const SizedBox(height: 16)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveScore() {
    questionController.grammarController.updateScore(
        questionController.questions.length - wrongQuetionIndexList.length);
  }

  AppBar _appBar(double currentValue, Size size) {
    return AppBar(
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            saveScore();
            getBacks(2);
          }),
      title: FAProgressBar(
        currentValue: currentValue,
        maxValue: 100,
        displayText: ' %',
        size: size.width > 500 ? 35 : 25,
        formatValueFixed: 0,
        backgroundColor: Colors.grey,
        progressColor: AppColors.lightGreen,
        borderRadius: size.width > 500
            ? BorderRadius.circular(30)
            : BorderRadius.circular(12),
        displayTextStyle: TextStyle(
          color: const Color(0xFFFFFFFF),
          fontSize: size.width > 500 ? 18 : 14,
        ),
      ),
    );
  }
}

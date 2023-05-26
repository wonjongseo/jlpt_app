import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/app_bar_progress_bar.dart';
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

  // 틀린 문제
  late List<int> wrongQuetionIndexList;

  // 선택된 인덱스
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
      appBar: _appBar(currentProgressValue, size),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Container(
              color: Colors.white,
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
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '빈칸에 맞는 답을 선택해 주세요.',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              )),
                        ),
                      ...List.generate(
                        questionController.questions.length,
                        (questionIndex) {
                          return GrammarQuizCard(
                            size: size,
                            questionIndex: questionIndex,
                            question:
                                questionController.questions[questionIndex],
                            onChanged: (int selectedAnswerIndex) {
                              clickButton(questionIndex, selectedAnswerIndex);
                            },
                            isCorrect:
                                !wrongQuetionIndexList.contains(questionIndex),
                            isSubmitted: isSubmitted,
                          );
                        },
                      ),
                      const SizedBox(height: 16)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: isSubmitted
                ? Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                          ),
                          child: const Text(
                            '나가기',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            saveScore();
                            getBacks(2);
                          },
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                            ),
                            onPressed: () {
                              saveScore();
                              Get.offNamed(
                                GRAMMAR_QUIZ_SCREEN,
                                preventDuplicates: false,
                                arguments: {
                                  'grammar': Get.arguments['grammar']
                                },
                              );
                            },
                            child: const Text(
                              '다시 하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                      ],
                    ),
                  )
                : Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                      ),
                      onPressed: () {
                        isSubmitted = true;
                        scrollController.jumpTo(0);
                        setState(() {});
                      },
                      child: const Text(
                        '제출',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // child: CustomButton(
                    //   text: '제출',
                    //   onTap: () {
                    //     isSubmitted = true;
                    //     scrollController.jumpTo(0);
                    //     setState(() {});
                    //   },
                    // ),
                  ),
          ),
        ],
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
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            saveScore();
            getBacks(2);
          }),
      title: AppBarProgressBar(
        size: size,
        currentValue: currentValue,
      ),
    );
  }
}

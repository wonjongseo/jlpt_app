import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/controller/grammar_controller.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:japanese_voca/model/Question.dart';
import 'package:japanese_voca/model/grammar_step.dart';

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
  // late GrammarStep grammarStep;
  late List<int> wrongQuetionIndexList;
  late List<int> checkedQuestionNumberIndexList;
  bool isSubmitted = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    questionController.startGrammarQuiz(Get.arguments['grammar']);
    wrongQuetionIndexList =
        List.generate(questionController.questions.length, (index) => index);

    checkedQuestionNumberIndexList =
        List.generate(questionController.questions.length, (index) => index);
  }

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

    double currentValue = ((questionController.questions.length -
                    checkedQuestionNumberIndexList.length)
                .toDouble() /
            questionController.questions.length.toDouble()) *
        100;

    return Scaffold(
      appBar: AppBar(
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
              fontSize: size.width > 500 ? 18 : 14),
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            ...List.generate(
              questionController.questions.length,
              (questionIndex) {
                return GrammarQuizCard(
                  size: size,
                  questionIndex: questionIndex,
                  isCorrect: !wrongQuetionIndexList.contains(questionIndex),
                  question: questionController.questions[questionIndex],
                  onChanged: (int selectedAnswerIndex) {
                    clickButton(questionIndex, selectedAnswerIndex);
                  },
                  isSubmitted: isSubmitted,
                );
              },
            ),
            CustomButton(
                text: '제출',
                onTap: () {
                  isSubmitted = true;
                  scrollController.jumpTo(0);
                  setState(() {});
                }),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class GrammarQuizCard extends StatefulWidget {
  GrammarQuizCard(
      {Key? key,
      required this.questionIndex,
      required this.question,
      this.onChanged,
      required this.size,
      this.isCorrect = false,
      this.isSubmitted = false})
      : super(key: key);
  final int questionIndex;
  final Size size;
  final Question question;
  Function(int)? onChanged;
  final bool isCorrect;
  final bool isSubmitted;

  @override
  State<GrammarQuizCard> createState() => _GrammarQuizCardState();
}

class _GrammarQuizCardState extends State<GrammarQuizCard> {
  String selectedAnswer = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 8),
            child: Text(
              '${widget.questionIndex + 1}. ${widget.question.question.word}',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: widget.size.width > 500 ? 20 : 18,
              ),
            ),
          ),
          Column(
            children: List.generate(
              widget.question.options.length,
              (index2) {
                String value =
                    '${index2 + 1}.  ${widget.question.options[index2].mean}';

                if (!widget.isSubmitted) {
                  String value =
                      '${index2 + 1}.  ${widget.question.options[index2].mean}';

                  return ListTile(
                    title: Text(value),
                    leading: Radio<String>(
                      groupValue: selectedAnswer,
                      value: value,
                      activeColor: Colors.black,
                      focusColor: Colors.black,
                      onChanged: (String? value) {
                        if (widget.isSubmitted == false) {
                          widget.onChanged!(index2);
                          setState(() {
                            selectedAnswer = value!;
                          });
                        }
                      },
                    ),
                  );
                } else {
                  late Color color;
                  if (widget.isCorrect) {
                    color = Colors.blue;
                    print('GREEN');
                  } else {
                    color = Colors.red;
                    print('RED');
                  }

                  if (widget.question.answer == index2) {
                    return ListTile(
                      title: Text(value),
                      leading: Radio<String>(
                        groupValue: value,
                        value: value,
                        activeColor: color,
                        focusColor: color,
                        onChanged: (String? value) {
                          if (widget.onChanged != null) {
                            widget.onChanged!(index2);
                            setState(() {
                              selectedAnswer = value!;
                            });
                          }
                        },
                      ),
                    );
                  } else {
                    return ListTile(
                      title: Text(value),
                      leading: Radio<String>(
                        groupValue: '',
                        value: value,
                        onChanged: (String? value) {
                          if (widget.onChanged != null) {
                            widget.onChanged!(index2);
                            setState(() {
                              selectedAnswer = value!;
                            });
                          }
                        },
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

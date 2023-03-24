import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/quiz/quiz_screen.dart';
import 'package:japanese_voca/screen/word/n_word_screen.dart';
import 'package:japanese_voca/screen/word/n_word_study_sceen.dart';

const SCORE_PATH = '/score';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    QuestionController _qnController = Get.put(QuestionController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
            Get.back();
            Get.back();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            children: [
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: const Color(0xFF8B94BC)),
              ),
              const SizedBox(height: 20),
              Text(
                "${_qnController.numOfCorrectAns} / ${_qnController.questions.length}",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: const Color(0xFF8B94BC)),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...List.generate(_qnController.wrongQuestions.length,
                          (index) {
                        return Container(
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 15),
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 15),
                          decoration: BoxDecoration(
                              color: Get.isDarkMode
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 1,
                                  offset: const Offset(0, 1),
                                )
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: size.width / 2 - 20,
                                  // height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                        '${_qnController.wrongQuestions[index].question.word}'),
                                  )),
                              const SizedBox(width: 10),
                              Expanded(
                                child: SizedBox(
                                  width: size.width / 2 - 20,
                                  // height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                        '${_qnController.wrongQuestions[index].options[_qnController.wrongQuestions[index].answer].mean}\n${_qnController.wrongQuestions[index].options[_qnController.wrongQuestions[index].answer].yomikata}'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      _qnController.isEnd
                          ? CustomButton(
                              text: 'Exit',
                              onTap: () {
                                Get.back();
                                Get.back();
                                Get.back();
                              },
                            )
                          : CustomButton(
                              text: 'Continue',
                              onTap: () {
                                _qnController.toContinue();
                                Get.toNamed(QUIZ_PATH);
                              },
                            ),
                    ],
                  ),
                ),
              ),
              // Spacer(flex: 3),
              const SizedBox(height: 20),
            ],
          )
        ],
      ),
    );
  }
}

class ScoreButton extends StatelessWidget {
  const ScoreButton({
    super.key,
    required this.text,
    required this.onPress,
  });

  final String text;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    QuestionController qnController = Get.find<QuestionController>();
    return OutlinedButton(
      onPressed: onPress,
      child: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

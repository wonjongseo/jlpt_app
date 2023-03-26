import 'package:flutter/material.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/model/my_word.dart';
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
                        String word =
                            _qnController.wrongQuestions[index].question.word;
                        String mean =
                            '${_qnController.wrongQuestions[index].options[_qnController.wrongQuestions[index].answer].mean}\n${_qnController.wrongQuestions[index].options[_qnController.wrongQuestions[index].answer].yomikata}';

                        return InkWell(
                          onTap: () {
                            MyWord.saveMyVoca(
                                _qnController.wrongQuestions[index].question);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 30, right: 30, bottom: 15),
                            padding: const EdgeInsets.all(15),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: size.width / 2 - 20,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(word),
                                    )),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: SizedBox(
                                    width: size.width / 2 - 20,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Text(mean),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Exit',
                        onTap: () {
                          Get.back();
                          Get.back();
                          Get.back();
                        },
                      )
                    ],
                  ),
                ),
              ),
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

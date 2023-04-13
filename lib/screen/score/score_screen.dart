import 'package:flutter/material.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/screen/score/components/wrong_word_card.dart';

const SCORE_PATH = '/score';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    QuestionController qnController = Get.find<QuestionController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => getBacks(3),
        ),
        backgroundColor: Colors.transparent,
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
                qnController.scoreResult,
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
                      if (qnController.wrongQuestions.isEmpty)
                        const SizedBox(width: double.infinity)
                      else
                        ...List.generate(qnController.wrongQuestions.length,
                            (index) {
                          String word = qnController.wrongWord(index);
                          String mean = qnController.wrongMean(index);
                          return WrongWordCard(
                            onTap: () => MyWord.saveMyVoca(
                                qnController.wrongQuestions[index].question),
                            textWidth: size.width / 2 - 20,
                            word: word,
                            mean: mean,
                          );
                        }),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Exit',
                        onTap: () => getBacks(3),
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

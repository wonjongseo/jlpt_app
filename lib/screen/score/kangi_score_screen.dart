import 'package:flutter/material.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/controller/kangi_question_controller.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/screen/score/components/wrong_word_card.dart';

const KANGI_SCORE_PATH = '/kangi_score';

class KangiScoreScreen extends StatelessWidget {
  const KangiScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    KangiQuestionController qnController = Get.find<KangiQuestionController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Score",
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: const Color(0xFF8B94BC)),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => getBacks(3),
        ),
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
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
                            onTap: () => MyWord.saveToMyVoca(
                                qnController.wrongQuestions[index].question),
                            textWidth: size.width / 2 - 20,
                            word: word,
                            mean: mean,
                          );
                        }),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        child: const Text('나가기'),
                        onPressed: () => getBacks(3),
                      ),
                      const SizedBox(height: 20),
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

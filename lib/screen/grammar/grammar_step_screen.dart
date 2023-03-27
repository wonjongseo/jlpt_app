import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:japanese_voca/model/Question.dart';
import 'package:japanese_voca/screen/home/home_screen.dart';
import 'package:japanese_voca/screen/quiz/quiz_screen.dart';
import 'package:japanese_voca/screen/grammar/grammar_screen.dart';

const VOCA_STEP_PATH = '/voca-section';

class VocaStepScreen extends StatelessWidget {
  const VocaStepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // VocabularyController vocabularyController = Get.put(VocabularyController());
    QuestionController _questionController = Get.put(QuestionController());
    var arguments = Get.arguments;

    // List<Vocabulary> vocabularies = vocabularyController.getVocabularyOfDay();

    int gridCount = 5;
    // int gridCount = vocabularies.length % 10 == 0
    //     ? (vocabularies.length / 10).floor()
    //     : (vocabularies.length / 10).ceil();

    return Scaffold(
      appBar: AppBar(
        title: Text('Day ${'vocabularyController.day'}',
            style: Theme.of(context).textTheme.bodyLarge),
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: getTo,
        ),
        actions: [
          InkWell(
            // onTap:
            onTap: () {
              // _questionController.map = Question.generateQustion(vocabularies);
              // _questionController.setQuestions(false);
              // Get.toNamed(QUIZ_PATH);
            },

            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: SvgPicture.asset(
                  'assets/svg/book.svg',
                  height: 30,
                ),
              ),
            ),
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20.0),
        crossAxisCount: 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        children: List.generate(
          gridCount,
          (step) {
            return StepCard();
          },
        ),
      ),
    );
  }

  void getTo() {
    Get.offNamed(HOME_PATH);
  }
}

class StepCard extends StatelessWidget {
  const StepCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: true ? AppColors.correctColor : AppColors.whiteGrey,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  )
                ],
                borderRadius: BorderRadius.circular(10)),
            child: GridTile(
              footer: Center(
                child: Text('aaa'),
              ),
              child: Center(
                  child: Text((1).toString(),
                      style: Theme.of(context).textTheme.displayMedium)),
            )));
  }
}

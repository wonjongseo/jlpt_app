import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:japanese_voca/common/widget/background.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:japanese_voca/screen/quiz/components/progress_bar.dart';
import 'package:japanese_voca/screen/quiz/components/question_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());

    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Obx(
                  (() => Text.rich(
                        TextSpan(
                            text:
                                "Question ${_questionController.questionNumber.value}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: Color(0xFF8B94BC),
                                ),
                            children: [
                              TextSpan(
                                  text:
                                      "/${_questionController.questions.length}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(color: Color(0xFF8B94BC)))
                            ]),
                      )),
                ),
              ),
              const Divider(thickness: 1.5),
              const SizedBox(height: 20.0),
              Expanded(
                child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _questionController.pageController,
                    onPageChanged: _questionController.updateTheQnNum,
                    itemCount: _questionController.questions.length,
                    itemBuilder: (context, index) {
                      return QuestionCard(
                        question: _questionController.questions[index],
                      );
                    }),
              )
            ],
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:japanese_voca/screen/quiz/components/question_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController questionController = Get.put(QuestionController());

    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //   child: Obx(
              //     (() => Text.rich(
              //           TextSpan(
              //             text: "問題 ${questionController.questionNumber.value}",
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .headlineMedium!
              //                 .copyWith(
              //                   color: Colors.white,
              //                 ),
              //             children: [
              //               TextSpan(
              //                 text: "/${questionController.questions.length}",
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .headlineSmall!
              //                     .copyWith(color: Colors.white),
              //               )
              //             ],
              //           ),
              //         )),
              //   ),
              // ),
              // Divider(
              //   thickness: 1.5,
              //   color: Colors.white.withOpacity(0.7),
              // ),
              // const SizedBox(height: 20.0),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: questionController.pageController,
                  onPageChanged: questionController.updateTheQnNum,
                  itemCount: questionController.questions.length,
                  itemBuilder: (context, index) {
                    return QuestionCard(
                      question: questionController.questions[index],
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

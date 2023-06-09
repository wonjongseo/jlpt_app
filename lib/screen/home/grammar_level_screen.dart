import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/controller/user_controller.dart';

import '../grammar/grammar_step_screen.dart';
import 'components/home_navigator_button.dart';

class HomeGrammarScreen extends StatelessWidget {
  const HomeGrammarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<UserController>(builder: (userController) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInLeft(
              delay: const Duration(milliseconds: 0),
              child: HomeNaviatorButton(
                text: 'N1 문법',
                currentProgressCount:
                    userController.user.currentGrammarScores[0],
                totalProgressCount: userController.user.grammarScores[0],
                onTap: () => Get.to(
                  () => GrammarStepSceen(level: '1'),
                ),
              ),
            ),
            FadeInLeft(
              delay: const Duration(milliseconds: 300),
              child: HomeNaviatorButton(
                text: 'N2 문법',
                currentProgressCount:
                    userController.user.currentGrammarScores[1],
                totalProgressCount: userController.user.grammarScores[1],
                onTap: () => Get.to(
                  () => GrammarStepSceen(level: '2'),
                ),
              ),
            ),
            FadeInLeft(
              delay: const Duration(milliseconds: 500),
              child: HomeNaviatorButton(
                text: 'N3 문법',
                currentProgressCount:
                    userController.user.currentGrammarScores[2],
                totalProgressCount: userController.user.grammarScores[2],
                onTap: () => Get.to(
                  () => GrammarStepSceen(level: '3'),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

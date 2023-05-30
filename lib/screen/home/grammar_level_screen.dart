import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../grammar/grammar_step_screen.dart';
import 'components/home_navigator_button.dart';

class GrammarLevelScreen extends StatelessWidget {
  const GrammarLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInLeft(
            delay: const Duration(milliseconds: 0),
            child: HomeNaviatorButton(
              text: 'N1 문법',
              wordsCount: '237',
              onTap: () => Get.to(
                () => const GrammarStepSceen(level: '1'),
              ),
            ),
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 300),
            child: HomeNaviatorButton(
                text: 'N2 문법',
                wordsCount: '93',
                onTap: () => Get.to(
                      () => const GrammarStepSceen(level: '2'),
                    )),
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 500),
            child: HomeNaviatorButton(
                text: 'N3 문법',
                wordsCount: '106',
                onTap: () => Get.to(
                      () => const GrammarStepSceen(level: '3'),
                    )),
          ),
        ],
      ),
    );
  }
}

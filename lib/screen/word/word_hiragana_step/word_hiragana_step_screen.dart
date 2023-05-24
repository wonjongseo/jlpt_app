import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_word_controller.dart';
import 'package:japanese_voca/screen/word/word_step/word_step_sceen.dart';

import 'components/book_card.dart';

final String WORD_HIRAGANA_STEP_PATH = '/word-hiragana-step';

class WordHiraganaStepScreen extends StatelessWidget {
  const WordHiraganaStepScreen({super.key});

  void goTo(int index, String firstHiragana) {
    Get.toNamed(
      WORD_STEP_PATH,
      arguments: {'firstHiragana': firstHiragana},
    );
  }

  @override
  Widget build(BuildContext context) {
    JlptWordController jlptWordController = Get.find<JlptWordController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              jlptWordController.headTitleCount,
              (index) {
                String firstHiragana = '챕터${index + 1}';
                return FadeInLeft(
                  delay: Duration(milliseconds: 200 * index),
                  child: BookCard(
                      level: firstHiragana,
                      onTap: () => goTo(index, firstHiragana)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
